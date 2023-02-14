package com.oti.srm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/stats")
@Log4j2
public class StatsController {
	// 통계 페이지
	@RequestMapping("/statistics")
	public String statistics(HttpSession session, Model model) {
		
		return "stats/stats";
	}
}
