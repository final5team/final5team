package com.oti.srm.controller.srm;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class TesterController {

	@GetMapping("/tester")
	public String developerDetail(int rno, Model model, HttpSession session) {
		log.info("실행");
		
		return "srm/testerdetail";
	}
}
