package com.oti.srm.controller.srm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
public class DeveloperController {

	@Autowired
	ICommonService commonService;

	/**
	 * @author : 장현
	 * @param model view에 전달할 객체 주입
	 * @param rno   Request객체 내용 출력위해 rno주입
	 * @return developerdetail로 리턴
	 */
	@GetMapping("/developerdetail")
	public String getDeveloperDetail(Model model, int rno, HttpSession session) {
		log.info("실행");

		// 요청내용 출력 -장현
		Request request = commonService.getRequest(rno);
		// 요청 프로세스 출력 -장현
		RequestProcess requestProcess = commonService.getRequestProcess(rno);
		// 개발자가 테스터로 넘길시 작성했던 내용 출력 -장현
		List<StatusHistory> devToTester = commonService.getDevToTesterHistories(rno);
		// 테스터가 개발자에게 보내는 결함내용(재검토) -장현
		List<StatusHistory> testerToDev = commonService.getTesterToDevHistories(rno);
		// 접수완료일자 받기 (각 실무자의 할당시간 체크 용도)
		Date receiptDoneDate = commonService.getReceiptDoneDate(rno);
		// 임시저장한 정보 가져오기
		StatusHistory tempSh = new StatusHistory();
		tempSh.setRno(rno);
		tempSh.setNextStatus(14);

		Member member = (Member) session.getAttribute("member");
		StatusHistory devTemp = commonService.getTempStatusHistory(member, tempSh);

		// 요청, 요청프로세스, 작성내용들 모달에 담기 -장현
		model.addAttribute("request", request);
		model.addAttribute("devToTester", devToTester);
		model.addAttribute("testerToDev", testerToDev);
		model.addAttribute("requestProcess", requestProcess);
		model.addAttribute("receiptDoneDate", receiptDoneDate);
		model.addAttribute("pmToAllHistories", commonService.getPmToAllHistories(rno));
		model.addAttribute("devTemp", devTemp);
		model.addAttribute("testRejectExist", commonService.isThereTestReject(rno));

		// 개발 담당자 확인 여부 변경(확인)
		if (request.getDevCheck() == 1 && member.getMtype().equals("developer")
				&& requestProcess.getDeveloper().equals(member.getMid())) {
			commonService.check("developer", request.getRno());
		}
		// 신규 내역 알림 갱신
		session.setAttribute("newAlertList", commonService.getNewAlertList(member));

		return "srm/developerdetail";
	}

	/**
	 * @author : 장현
	 * @param statusHistory     StatusHistory객체 주입
	 * @param developExpectDate RequestProcess에 업데이트
	 * @param session           세션에 저장된 member 통해서 StatusHistory의 writer 주입
	 * @return developerdetail로 리다이렉트
	 */
	@PostMapping("/devinprogress")
	public String switchDevInProgress(StatusHistory statusHistory,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date devExpectDate, HttpSession session) {
		Member member = (Member) session.getAttribute("member");
		statusHistory.setWriter(member.getMid());
		statusHistory.setNextStatus(4);
		commonService.startWork(statusHistory, devExpectDate, member.getMtype());

		return "redirect:/developerdetail?rno=" + statusHistory.getRno();
	}

	@GetMapping("/developerdetail2")
	public String getDeveloperDetail2(Model model) {
		log.info("실행");
		return "srm/developerdetail2";
	}

	/**
	 * @author : 장현
	 * @param rp      rno 와 devProgress를 담은 객체
	 * @param session
	 * @return developerdetail로 리턴
	 */
	@PostMapping("/updatedevprogress")
	@ResponseBody
	public Map<String, String> updateDevProgress(RequestProcess rp, HttpSession session) {
		log.info("실행");
		commonService.updateDevProgress(rp);
		Map<String, String> map = new HashMap<>();
		map.put("result", "성공");
		return map;
	}

	/**
	 * @author : 장현
	 * @param statusHistory 상태 업데이트
	 * @param session       member객체로 statusHistory에 wrtier주입
	 * @param files         파일 입력
	 * @return developerdetail로 view전달
	 */
	@PostMapping("/devdone")
	public String switchDevDone(StatusHistory statusHistory, HttpSession session, @RequestParam MultipartFile[] files) {
		log.info("실행");
		log.info(files[0].getOriginalFilename());
		Member member = (Member) session.getAttribute("member");
		statusHistory.setWriter(member.getMid());
		statusHistory.setNextStatus(5);
		List<StatusHistoryFile> sFiles = new ArrayList<>();
		try {
			if (files != null) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						StatusHistoryFile statusHistoryFile = new StatusHistoryFile();
						statusHistoryFile.setFileName(file.getOriginalFilename());
						statusHistoryFile.setFileType(file.getContentType());
						statusHistoryFile.setFileData(file.getBytes());
						sFiles.add(statusHistoryFile);
					}
				}

			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		statusHistory.setFileList(sFiles);
		commonService.endWork(statusHistory, member);

		// 서비스 변경 여부(테스터 미확인 상태 변경)
		commonService.notCheck("tester", statusHistory.getRno());

		return "redirect:/developerdetail?rno=" + statusHistory.getRno();
	}

	@PostMapping("/tempstore")
	@ResponseBody
	public Map<String,String> tempStore(int rno, StatusHistory statusHistory,RequestProcess rp, HttpSession session, Model model, @RequestParam MultipartFile[] files) {
		log.info("실행");
		log.info("rno : " + statusHistory.getRno());
		log.info("nextStatus : " + statusHistory.getNextStatus());
		
		//rno 세팅
		statusHistory.setRno(rno);
		rp.setRno(rno);
		
		//파일 세팅
		List<StatusHistoryFile> sFiles = new ArrayList<>();
		try {
			if (files != null) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						StatusHistoryFile statusHistoryFile = new StatusHistoryFile();
						statusHistoryFile.setFileName(file.getOriginalFilename());
						statusHistoryFile.setFileType(file.getContentType());
						statusHistoryFile.setFileData(file.getBytes());
						sFiles.add(statusHistoryFile);
					}
				}

			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		statusHistory.setFileList(sFiles);
		
		
		Member member = (Member) session.getAttribute("member");
		statusHistory.setWriter(member.getMid());
		
		// 기존 임시 저장글이 있는지 확인
		StatusHistory tempStatusHistory = commonService.getTempStatusHistory(member, statusHistory);
		
		//진척률 업데이트
		if(member.getMtype().equals("developer")) {
			commonService.updateDevProgress(rp);
		}
		
		if (tempStatusHistory == null) {
			// insert
			commonService.writeStatusHistory(statusHistory);
		} else {
			// update
			commonService.updateStatusHistory(statusHistory);
		}
		Map<String, String> map = new HashMap<>();
		map.put("result", "success");

		return map;
	}

	// PM 요청 처리 계획 수정 
	@PostMapping("updatehistory")
	public String updateHistory(@RequestParam("rno") String rno, RequestProcess rp, StatusHistory sh, HttpSession session, Model model, MultipartFile[] files) {
		log.info("updateHistory");
		rp.setRno(Integer.parseInt(rno));
		sh.setRno(Integer.parseInt(rno));
		Member member = (Member) session.getAttribute("member");
		
		//MultipartFile[] 타입 파일 StatusHistoryFile 객체에 아서 서비스 전달
		if(files != null) {
			List<StatusHistoryFile> fileList = new ArrayList<StatusHistoryFile>();
			try {
				for(MultipartFile file : files) {
					if (!file.isEmpty()) {
						StatusHistoryFile shfile = new StatusHistoryFile();
						shfile.setFileData(file.getBytes());
						shfile.setFileName(file.getOriginalFilename());
						shfile.setFileType(file.getContentType());
						fileList.add(shfile);
					}
				}
				sh.setFileList(fileList);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		commonService.updateHistory(rp, sh, member);
		return "redirect:/receiptdetail?rno=" + rp.getRno();
		
	}

	// developer,tester,usertester,distributor 단계 롤백(수정)
	@PostMapping("rollbackstep")
	public String rollBackStep(int hno, HttpSession session, Model model) {
		log.info("실행");
		Member member = (Member) session.getAttribute("member");
		StatusHistory mySh = commonService.getStatusHistory(hno);
		int rno = mySh.getRno();
		commonService.rollBackStep(member, hno);
		log.info(mySh);
		if (member.getMtype().equals("developer")) {
			return "redirect:/developerdetail?rno=" + rno;
		} else if (member.getMtype().equals("tester")) {
			return "redirect:/testerdetail?rno=" + rno;
		} else if (member.getMtype().equals("usertester")) {
			return "redirect:/usertestdetail?rno=" + rno;
		} else {
			return "redirect:/distributedetail?rno=" + rno;
		}
	}

}
