package com.oti.srm.controller.srm;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.sun.media.jfxmedia.logging.Logger;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class DeveloperController {
	
	@GetMapping("/developer")
	public String developerDetail() {
		log.info("실행");
		
		return "mywork/developerdetail";
	}
}
