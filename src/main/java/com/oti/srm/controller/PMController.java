package com.oti.srm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/pm")
@Log4j2
public class PMController {
	// 통계 페이지
	@RequestMapping("/pm")
	public String pm(HttpSession session, Model model) {
		
		return "pm/stats";
	}
}
