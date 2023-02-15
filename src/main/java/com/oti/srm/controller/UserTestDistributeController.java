package com.oti.srm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.service.IUserTestService;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class UserTestDistributeController {
	@Autowired
	IUserTestService userTestService;
	
	// 고객테스트 단계(고객테스트 요청, 고객테스트 중)상세보기
	@GetMapping("/usertestdetail")
	public String userTestDetail(int rno, HttpSession session, Model model) {
		log.info("요청번호" + rno);
		// 요청정보 
		model.addAttribute("request", userTestService.getRequest(rno));
		// Validation(내 담당건 맞는지)
		// 요청 처리정보
		model.addAttribute("requestProcess", userTestService.getRequestProcess(rno));
		List<StatusHistory> devToTesterHistories = userTestService.getDevToTesterHistories(rno);
		Member member = new Member();
		member.setMid("thddudgns79");
		member.setMname("송영훈");
		member.setMtype("pm");
		member.setOrgan("서울시청");
		member.setPosition("주임");
		session.setAttribute("userInfo", member);
		// 개발자 -> 테스터 
		model.addAttribute("devToTesterHistories", devToTesterHistories);
		return "younghun/usertester";
	}
	
	@GetMapping("/distributedetail")
	public String distributeDetail(int rno, HttpSession session, Model model) {
		log.info("요청번호" + rno);
		// 요청정보 
		model.addAttribute("request", userTestService.getRequest(rno));
		// Validation(내 담당건 맞는지)
		// 요청 처리정보
		model.addAttribute("requestProcess", userTestService.getRequestProcess(rno));
		List<StatusHistory> devToTesterHistories = userTestService.getDevToTesterHistories(rno);
		Member member = new Member();
		member.setMid("thddudgns79");
		member.setMname("송영훈");
		member.setMtype("pm");
		member.setOrgan("서울시청");
		member.setPosition("주임");
		session.setAttribute("userInfo", member);
		// 개발자 -> 테스터 
		model.addAttribute("devToTesterHistories", devToTesterHistories);
		return "younghun/distributor";
	}
}
