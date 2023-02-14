package com.oti.srm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserTestController {
	// 테스트 상세보기
	@RequestMapping("/usertest")
	public String userTestRequest(int rno, HttpSession session, Model model) {
		// 테스터의 정보는 session의 userInfo에 저장되어 있음
		// 가장 최근의 개발 -> 테스트 단계 변경 이력 
		
		return "usertest.jsp";
	}
}
