package com.oti.srm.controller.srm;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oti.srm.service.srm.IStatsService;

import lombok.extern.log4j.Log4j2;

/**
 * @author KIM JI YOUNG
 *
 */
@Controller
@RequestMapping("/stats")
@Log4j2
public class StatsController {
	@Autowired
	IStatsService statsService;
	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param session
	 * @param model
	 * @return
	 */
	// 통계 페이지
	@RequestMapping("/statistics")
	public String statistics(HttpSession session, Model model) {
		// 
		
		// SR 처리 현황
		// 전체 SR 처리 현황
		//model.addAttribute("allState", statsService.getSRState("all"));
		
		// 월별 서비스 요청 건수 구하기
		model.addAttribute("SRChange", statsService.getSRChange(0));
		// 월별 서비스  완료 건수 구하기
		model.addAttribute("SRComChange", statsService.getSRChange(1));
				
		return "srm/stats";
	}
}
