package com.oti.srm.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oti.srm.service.member.IMemberService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class CheckController {
	
	@Autowired
	IMemberService memberService;
	
	//아이디 확인 ajax
	@PostMapping("/idconfrim")
	@ResponseBody
	public int idConfirm(@RequestBody String mid) {
		log.info(mid);
		int result = memberService.checkId(mid);
		return result;
	}
	
}
