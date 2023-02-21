package com.oti.srm.controller.srm;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.StatusHistory;
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
		model.addAttribute("request", commonService.getRequest(rno));
		// 요청 처리정보
		model.addAttribute("requestProcess", commonService.getRequestProcess(rno));
		// 개발자 -> 테스터
		model.addAttribute("devToTesterHistories", commonService.getDevToTesterHistories(rno));
		return "srm/userTester";
	}

	// 작성자 : 송영훈
	@GetMapping("/distributedetail")
	public String distributeDetail(int rno, HttpSession session, Model model) {
		log.info("요청번호" + rno);
		// Validation(내 담당건 맞는지)
		// 요청정보
		model.addAttribute("request", commonService.getRequest(rno));
		// 요청 처리정보
		model.addAttribute("requestProcess", commonService.getRequestProcess(rno));
		// 개발자 -> 테스터
		model.addAttribute("devToTesterHistories", commonService.getDevToTesterHistories(rno));
		return "srm/distributor";
	}
	
	// 작성자 : 송영훈
	// 작업 시작(고객테스터 / 배포자 공용)
	// => requests테이블(현재단계 최신화 + 완료예정일 기입) + status_histories테이블(단계 변경 이력 추가)
	@PostMapping("/startwork")
	public String startWork(StatusHistory statusHistory, @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date expectDate, HttpSession session, Model model) {
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
	public String endWork(StatusHistory statusHistory, HttpSession session) {
		log.info("실행");
		Member me = (Member) session.getAttribute("member");
		statusHistory.setWriter(me.getMid());
		if (me.getMtype().equals("usertester")) {
			statusHistory.setNextStatus(9);
			commonService.endWork(statusHistory, me.getMtype());
			return "redirect:/usertestdetail?rno=" + statusHistory.getRno();
		} else {
			statusHistory.setNextStatus(11);
			commonService.endWork(statusHistory, me.getMtype());
			return "redirect:/distributedetail?rno=" + statusHistory.getRno();
		}
	}

}
