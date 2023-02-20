package com.oti.srm.controller.srm;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.service.srm.ICommonService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class DeveloperController {
	
	@Autowired
	ICommonService commonService;
	
	@GetMapping("/developerdetail")
	public String developerDetail(Model model, int rno, HttpSession session) {
		log.info("실행");
		
		//요청내용 출력 -장현
		Request request = commonService.getRequest(rno);
		//요청 프로세스 출력 -장현
		RequestProcess requestProcess = commonService.getRequestProcess(rno);
		//개발자가 테스터로 넘길시 작성했던 내용 출력 -장현
		List<StatusHistory> devToTester = commonService.getDevToTesterHistories(rno);
		//테스터가 개발자에게 보내는 결함내용(재검토) -장현
		List<StatusHistory> testerToDev = commonService.getTesterToDevHistories(rno);
		
		//요청, 요청프로세스, 작성내용들 모달에 담기 -장현
		model.addAttribute("request", request);
		model.addAttribute("devToTester", devToTester);
		model.addAttribute("testerToDev", testerToDev);
		model.addAttribute("requestProcess", requestProcess);
		
		return "srm/developerdetail";
	}
}
