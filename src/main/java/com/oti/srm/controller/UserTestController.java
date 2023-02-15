package com.oti.srm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.oti.srm.dto.StatusHistory;
import com.oti.srm.service.IUserTestService;

@Controller
public class UserTestController {
	@Autowired
	IUserTestService userTestService;
	
	// 테스트 상세보기
	@GetMapping("/usertest")
	public String userTestRequest(int rno, HttpSession session, Model model) {
		Map<String, List<StatusHistory>> devAndTesterHistories = userTestService.getDevAndTesterHistories(rno);
		// 개발자 -> 테스터 
		model.addAttribute("devToTesterHistories", devAndTesterHistories.get("devToTesterHistories"));
		// 테스터 -> 개발자
		model.addAttribute("testerToDevHistories", devAndTesterHistories.get("testerToDevHistories"));
		
		return "usertest.jsp";
	}
}
