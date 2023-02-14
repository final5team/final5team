package com.oti.srm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oti.srm.dto.Member;

import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
@RequestMapping("/customer")
public class RequestController {
	
	
	@GetMapping("/request")
	public String customerLogin() {
		return "request/request";
	}
	
	
	@GetMapping("/register")
	public String register() {
		return "user/userregister";
	}
	
	@PostMapping("/register")
	public String register(Member member , Model model) {
		log.info("등록 실행");
		
		
		return "redirect:/user/userregister";
	}
	
	
	
}
