package com.oti.srm.controller.srm;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/pm")
@Log4j2
public class PMController {
	// 접수
	@RequestMapping("/receipt")
	public String receipt(HttpSession session, Model model) {
		
		return "pm/receipt";
	}
	
	// 완료 처리
	@RequestMapping("/complete")
	public String complete(HttpSession session, Model model) {
		
		return "pm/complete";
	}
	
	// 완료 상세
	@RequestMapping("/end")
	public String end(HttpSession session, Model model) {
		
		return "pm/end";
	}	
	
	//화면에서 입력한 날짜 컨트롤러의 Date 매개변수에 넣을려면 
	//@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date expectDate
}
