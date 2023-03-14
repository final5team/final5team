package com.oti.srm.controller.srm;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Notice;
import com.oti.srm.dto.Pager;
import com.oti.srm.service.member.IUserRegisterService;
import com.oti.srm.service.srm.IRequestRegisterService;
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
	@Autowired
	IUserRegisterService userRegisterService;

	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param session
	 * @param model
	 * @return
	 */
	// 통계 페이지
	@Transactional
	@RequestMapping("/statistics")
	public String statistics(HttpSession session, Model model) {
		// 첫째 줄
		// 전체 서비스 요청 시스템 별 비중 구하기
		model.addAttribute("systemSlice", statsService.getSystemSlice());

		// 전체 완료율 구하기
		model.addAttribute("comRate", statsService.getComRate(0));
		// 태스크별 완료율 구하기
		model.addAttribute("comRateTask", statsService.getComRateTask());

		// 전체 지연율 구하기
		model.addAttribute("delRate", statsService.getDelRate(0));
		// 태스크별 지연율 구하기
		model.addAttribute("delRateTask", statsService.getDelRateTask());

		// 둘째 줄
		// SR 처리 현황
		// 전체 서비스 요청 처리 현황
		model.addAttribute("stageCount", statsService.getStageCount());
		// 태스크별 서비스 요청 처리 현황
		model.addAttribute("taskCount", statsService.getTaskCount());
		
		
		// 셋째 줄
		// 서비스 요청 추이
		// 시스템 정보 구하기
		model.addAttribute("systemList", userRegisterService.getSystemList());
		// 현재 연도 구하기
		String year = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
		// 현재 월 구하기
		int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
		// 현재 월에 따른 분기 계산하기
		month = (month < 4) ? 1 : (month < 7) ? 4 : (month < 10) ? 7 : 10;
		// 현재 기준 월별 서비스 요청 건수 구하기
		model.addAttribute("SRChange", statsService.getSRChange(year, month));
		// 해당 날짜(월) 반환하기
		model.addAttribute("SRChangeMonth", month);
		// 월별 서비스 완료 건수 구하기
		// model.addAttribute("SRComChange", statsService.getSRChange(1));
		
		//사이드바 버튼 저장
		session.setAttribute("where", "stat");
		
		return "srm/stats";
	}

	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param session
	 * @param model
	 * @param sno
	 * @return
	 */
	// Ajax로 시스템별 완료율 구하기
	@RequestMapping(value = "/comrate/{sno}", method = RequestMethod.GET)
	public String getComRateSystem(HttpSession session, Model model, @PathVariable int sno) {
		// 해당 시스템 번호에 맞는 완료율 구하기
		model.addAttribute("comRate", statsService.getComRate(sno));
		return "srm/comrate";
	}

	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param session
	 * @param model
	 * @param sno
	 * @return
	 */
	// Ajax로 시스템별 지연율 구하기
	@RequestMapping(value = "/delrate/{sno}", method = RequestMethod.GET)
	public String getDelRateSystem(HttpSession session, Model model, @PathVariable int sno) {
		// 해당 시스템 번호에 맞는 지연율 구하기
		model.addAttribute("delRate", statsService.getDelRate(sno));
		return "srm/delrate";
	}

	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param session
	 * @param model
	 * @param year
	 * @param month
	 * @return
	 */
	// Ajax로 분기별 서비스 요청 추이 구하기
	@RequestMapping(value = "/curve/{year}/{month}", method = RequestMethod.GET)
	public String getCurveSystem(HttpSession session, Model model, @PathVariable String year, @PathVariable int month) {
		// 서비스 요청 추이
		// 시스템 정보 구하기
		model.addAttribute("systemList", userRegisterService.getSystemList());
		// 월별 서비스 요청 건수 구하기
		model.addAttribute("SRChange", statsService.getSRChange(year, month));
		// 해당 분기 반환하기
		model.addAttribute("SRChangeMonth", month);

		return "srm/curve";
	}

}
