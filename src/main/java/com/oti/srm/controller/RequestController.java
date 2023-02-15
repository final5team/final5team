package com.oti.srm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Request;
import com.oti.srm.service.IRequestRegisterService;
import com.oti.srm.service.IUserRegisterService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/customer")
public class RequestController {

	@Autowired
	private IUserRegisterService userRegisterService;
	@Autowired
	private IRequestRegisterService requestService;

	@GetMapping("/register")
	public String register() {
		return "user/userregister";
	}

	@PostMapping("/register")
	public String register(Member member, Model model) {
		log.info("등록 실행");
		log.info("member : " + member.toString());
		System.out.println(member.toString());

		
		int result = userRegisterService.register(member);

		if (result == IUserRegisterService.REGISTER_FAIL) {
			return "redirect:/customer/register";
		} else {
			model.addAttribute("registerResult", "FAIL");
			return "redirect:/login";
		}
		
		
//		return "redirect:/login";
	}
	
	
	@GetMapping("/request")
	public String customerRequest() {
		return "request/request";
	}
		
	@PostMapping("/request")
	public String customerRequest(Request request, Model model) {
		request.setStatusNo(1);
		
		//임시 데이터
		request.setSystemName("가족관계시스템");
		request.setClient("thddudgns79");
		
		System.out.println("컨트롤러");
		
		int result = requestService.request(request);
		if(result == IRequestRegisterService.REQUEST_SUCCESS) {
			return "redirect:/login";
		} else {
			model.addAttribute("requestResult", "FAIL");
			return "redirect:/customer/request";
		}
		
		
		
	}
	
	
	
	
	

}
