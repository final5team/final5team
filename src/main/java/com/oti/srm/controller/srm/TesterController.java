package com.oti.srm.controller.srm;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;
import com.oti.srm.service.srm.ICommonService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class TesterController {
	@Autowired
	ICommonService commonService;

	/**
	 * @author : 장현
	 * @param rno         상세보기할 번호 주입
	 * @param model       view로 전달을 위한 model객체 주입
	 * @param Httpsession 객체 주입
	 * @return rno에 맞는 view 리턴
	 */
	@GetMapping("/testerdetail")
	public String testerDetail(int rno, Model model, HttpSession session) {
		log.info("실행");

		Request request = commonService.getRequest(rno);
		log.info("request.getRno() : " + request.getRno());
		RequestProcess requestProcess = commonService.getRequestProcess(rno);
		List<StatusHistory> devToTester = commonService.getDevToTesterHistories(rno);
		List<StatusHistory> testerToDev = commonService.getTesterToDevHistories(rno);
		Date receiptDoneDate = commonService.getReceiptDoneDate(rno);
		
		//임시저장 가져오기 (정상 처리 저장)
		StatusHistory sh = new StatusHistory();
		sh.setRno(rno);
		sh.setNextStatus(15);
		Member member = (Member)session.getAttribute("member");
		StatusHistory tempNormal = commonService.getTempStatusHistory(member, sh);
		//임시저장 가져오기 (재검토 처리 저장)
		sh.setNextStatus(16);
		StatusHistory tempReexam = commonService.getTempStatusHistory(member, sh);
		
		model.addAttribute("request", request);
		model.addAttribute("devToTester", devToTester);
		model.addAttribute("testerToDev", testerToDev);
		model.addAttribute("requestProcess", requestProcess);
		model.addAttribute("receiptDoneDate", receiptDoneDate);
		model.addAttribute("pmToAllHistories", commonService.getPmToAllHistories(rno));
		model.addAttribute("tempNormal",tempNormal);
		model.addAttribute("tempReexam",tempReexam);
		model.addAttribute("testRejectExist", commonService.isThereTestReject(rno));
		
		// 테스트 담당자 확인 여부 변경(확인)	
		if(request.getTesCheck()==1 && member.getMtype().equals("tester") && requestProcess.getTester().equals(member.getMid())) {
			commonService.check("tester", request.getRno());
		}
		// 신규 내역 알림 갱신
		session.setAttribute("newAlertList", commonService.getNewAlertList(member));
				
		return "srm/testerdetail";
	}

	/**
	 * @author : 장현
	 * @param statusHistory  form 태그에서 받은 필드값 저장
	 * @param testExpectDate RequestProcess에 테스트완료 예정일 업데이트
	 * @param session        HttpSession을 통해 StatusHistory 필드의 writer에 주입
	 * @return rno에 맞는 view 리턴
	 */
	@PostMapping("/testinprogress")
	public String switchTestInProgress(StatusHistory statusHistory,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date testExpectDate, HttpSession session, HttpServletResponse response) {
		
		log.info(testExpectDate);
		//세션에 저장된 멤버 객체 갖고오기
		Member member = (Member) session.getAttribute("member");
		
		//StatusHistory 객체에 member에 대한 정보 담기, nextStatus 상태 전환
		statusHistory.setWriter(member.getMid());
		statusHistory.setNextStatus(6);
		commonService.startWork(statusHistory, testExpectDate, member.getMtype());
		
		return "redirect:/testerdetail?rno=" + statusHistory.getRno();
		
	}
	
	
	/**
	 * @author : 장현
	 * @param statusHistory 상태 업데이트
	 * @param files 파일 입력
	 * @param session 저장된 member객체로 StatusHistory에 주입
	 * @return testerdetail로 rno에 맞는 view 리턴
	 */
	@PostMapping("/askreexam")
	public String switchReexam(StatusHistory statusHistory, MultipartFile[] files, HttpSession session) {
		log.info("실행");
		Member member = (Member) session.getAttribute("member");
		statusHistory.setWriter(member.getMid());
		statusHistory.setNextStatus(3);
		List<StatusHistoryFile> sFiles = new ArrayList<StatusHistoryFile>();
		//재검토 시 해당 요청의 개발 진척율 0으로 초기화 
		RequestProcess rp = new RequestProcess();
		rp.setRno(statusHistory.getRno());
		rp.setDevProgress(0);
		commonService.updateDevProgress(rp);
		try {
			if (files != null) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						StatusHistoryFile shf = new StatusHistoryFile();
						shf.setFileData(file.getBytes());
						shf.setFileName(file.getOriginalFilename());
						shf.setFileType(file.getContentType());
						sFiles.add(shf);
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		statusHistory.setFileList(sFiles);
		commonService.reWork(statusHistory, member);
		
		// 서비스 변경 여부(개발자 미확인  상태 변경)
		commonService.notCheck("developer", statusHistory.getRno());
				
		return "redirect:/testerdetail?rno=" + statusHistory.getRno();
		
	}
	/**
	 * @author : 장현
	 * @param rno StatusHistory 객체에 주입
	 * @param session StatusHistory 객체의 writer, mtype 주입
	 * @return testerdetail으로 리턴
	 */
	@PostMapping("/testdone")
	public String switchTestDone(StatusHistory statusHistory, MultipartFile[] files, HttpSession session) {
		log.info("실행");
		Member member = (Member)session.getAttribute("member");
		
		statusHistory.setWriter(member.getMid());
		statusHistory.setNextStatus(7);
		List<StatusHistoryFile> sFiles = new ArrayList<StatusHistoryFile>();

		try {
			if (files != null) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						StatusHistoryFile shf = new StatusHistoryFile();
						shf.setFileData(file.getBytes());
						shf.setFileName(file.getOriginalFilename());
						shf.setFileType(file.getContentType());
						sFiles.add(shf);
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		statusHistory.setFileList(sFiles);
		commonService.endWork(statusHistory, member);
		
		// 서비스 변경 여부(담당자 미확인  상태 변경)
		// 서비스 유형 확인
		if(commonService.getRequestProcess(statusHistory.getRno()).getReqType().equals("긴급")) {
			commonService.notCheck("distributor", statusHistory.getRno());
		} else {
			commonService.notCheck("usertester", statusHistory.getRno());
		}
				
		return "redirect:/testerdetail?rno=" + statusHistory.getRno();
		
	}

}
