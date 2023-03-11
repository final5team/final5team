package com.oti.srm.controller.srm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;
import com.oti.srm.service.srm.ICommonService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class UserTestDistributeController {
	@Autowired
	ICommonService commonService;

	// 작성자 : 송영훈
	// 고객테스트 단계(고객테스트 요청, 고객테스트 중)상세보기
	@GetMapping("/usertestdetail")
	public String userTestDetail(int rno, HttpSession session, Model model) {
		log.info("요청번호" + rno);
		// Validation(내 담당건 맞는지)
		// 요청정보
		Request request = commonService.getRequest(rno);
		model.addAttribute("request", request);
		// 요청 처리정보
		RequestProcess requestProcess = commonService.getRequestProcess(rno);
		model.addAttribute("requestProcess", requestProcess);
		// 품질검사 완료 내역
		model.addAttribute("userTesterToDistributorHistories", commonService.getUserTesterToDistributorHistories(rno));
		// 임시저장 정보
		StatusHistory sh = new StatusHistory();
		sh.setRno(rno);
		sh.setNextStatus(17);
		Member member = (Member) session.getAttribute("member");
		model.addAttribute("userTesterTemp", commonService.getTempStatusHistory(member, sh));
		model.addAttribute("testRejectExist", commonService.isThereTestReject(rno));
		
		// 품질 검토 담당자 확인 여부 변경(확인)	
		if(request.getUttCheck()==1 && member.getMtype().equals("usertester") && requestProcess.getUserTester().equals(member.getMid())) {
			commonService.check("usertester", request.getRno());
		}
		// 신규 내역 알림 갱신
		session.setAttribute("newAlertList", commonService.getNewAlertList(member));
				
		return "srm/userTester";
	}

	// 작성자 : 송영훈
	@GetMapping("/distributedetail")
	public String distributeDetail(int rno, HttpSession session, Model model) {
		log.info("요청번호" + rno);
		// Validation(내 담당건 맞는지)
		// 요청정보
		Request request = commonService.getRequest(rno);
		model.addAttribute("request", request);
		// 요청 처리정보
		RequestProcess requestProcess = commonService.getRequestProcess(rno);
		model.addAttribute("requestProcess", requestProcess);
		// 배포 완료 내역
		model.addAttribute("distributorToPmHistories", commonService.getDistributorToPmHistories(rno));
		// 임시저장 정보
		StatusHistory sh = new StatusHistory();
		sh.setRno(rno);
		sh.setNextStatus(18);
		Member member = (Member) session.getAttribute("member");
		model.addAttribute("distributorTemp", commonService.getTempStatusHistory(member, sh));
		model.addAttribute("testRejectExist", commonService.isThereTestReject(rno));
		
		// 배포 담당자 확인 여부 변경(확인)	
		if(request.getDisCheck()==1 && member.getMtype().equals("distributor") && requestProcess.getDistributor().equals(member.getMid())) {
			commonService.check("distributor", request.getRno());
		}
		// 신규 내역 알림 갱신
		session.setAttribute("newAlertList", commonService.getNewAlertList(member));
		
		return "srm/distributor";
	}

	// 작성자 : 송영훈
	// 작업 시작(고객테스터 / 배포자 공용)
	// => requests테이블(현재단계 최신화 + 완료예정일 기입) + status_histories테이블(단계 변경 이력 추가)
	@PostMapping("/startwork")
	public String startWork(StatusHistory statusHistory,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date expectDate, HttpSession session, Model model) {
		log.info("실행");
		Member me = (Member) session.getAttribute("member");
		statusHistory.setWriter(me.getMid());
		if (me.getMtype().equals("usertester")) {
			statusHistory.setNextStatus(8);
			commonService.startWork(statusHistory, expectDate, me.getMtype());
			return "redirect:/usertestdetail?rno=" + statusHistory.getRno();
		} else {
			statusHistory.setNextStatus(10);
			commonService.startWork(statusHistory, expectDate, me.getMtype());
			return "redirect:/distributedetail?rno=" + statusHistory.getRno();
		}
	}

	// 작성자 : 송영훈
	// 작업 완료(고객테스터 / 배포자 공용)
	// => requests테이블(현재단계 최신화) + status_histories테이블(단계 변경 이력 추가)
	// + status_histories_files테이블(단계 변경 이력에 첨부파일 등록)
	@PostMapping("/endwork")
	public String endWork(StatusHistory statusHistory, HttpSession session, MultipartFile[] files) {
		log.info("실행");
		Member me = (Member) session.getAttribute("member");
		statusHistory.setWriter(me.getMid());
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
		if (me.getMtype().equals("usertester")) {
			statusHistory.setNextStatus(9);
			commonService.endWork(statusHistory, me);
			
			// 서비스 변경 여부(배포자 미확인  상태 변경)
			commonService.notCheck("distributor", statusHistory.getRno());
			
			return "redirect:/usertestdetail?rno=" + statusHistory.getRno();
		} else {
			statusHistory.setNextStatus(11);
			commonService.endWork(statusHistory, me);
			
			// 서비스 변경 여부(PM 미확인  상태 변경)
			commonService.notCheck("pm", statusHistory.getRno());
			
			
			return "redirect:/distributedetail?rno=" + statusHistory.getRno();
		}
	}

}
