package com.oti.srm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Request;
import com.oti.srm.service.srm.ICommonService;

import lombok.extern.log4j.Log4j2;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j2
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	ICommonService commonService;
	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) {
		logger.info("실행");
		//세션에 담긴 member객체 받기
		Member member = (Member) session.getAttribute("member");
		
		//각 요청건 출력
		HashMap<String,Integer> workingStatus = commonService.getWorkingStatus(member);
		//D-7 리스트 출력
		List<Request> listOf7daysLeft = commonService.getListOf7daysLeft(member);
		//업무 처리율(지연율) 출력
		Map<String, Object> workCompletionRate = commonService.getWorkCompletionRate(member);
		//모달에 담기
		model.addAttribute("workingStatus", workingStatus);
		model.addAttribute("listOf7daysLeft", listOf7daysLeft);
		model.addAttribute("workCompletionRate", workCompletionRate);
		return "/home";
	}
	
	@GetMapping("/main")
	public String developerDetail() {
		log.info("실행");
		
		return "homemain/homemain";
	}
	@GetMapping("/devmain")
	public String developerMain() {
		log.info("실행");
		
		return "homemain/devmain";
	}
	@GetMapping("/pmmain")
	public String pmMain() {
		log.info("실행");
		
		return "homemain/pmmain";
	}
	
}
