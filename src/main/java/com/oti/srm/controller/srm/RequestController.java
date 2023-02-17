package com.oti.srm.controller.srm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.service.member.IUserRegisterService;
import com.oti.srm.service.srm.IRequestRegisterService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/customer")
public class RequestController {

	@Autowired
	private IUserRegisterService userRegisterService;
	@Autowired
	private IRequestRegisterService requestService;

	@GetMapping("/register")
	public String register() {
		return "user/userregister";
	}

	@PostMapping("/register")
	public String register(Member member, Model model) {
		log.info("등록 실행");
		log.info("member : " + member.toString());
		int result = userRegisterService.register(member);
		
		if (result == IUserRegisterService.REGISTER_FAIL) {
			return "redirect:/customer/register";
		} else {
			model.addAttribute("registerResult", "FAIL");
			return "redirect:/login";
		}
		
	}
	
	
	@GetMapping("/request")
	public String customerRequest() {
		return "request/request";
	}
		
	
	@PostMapping("/request")
	public String customerRequest(Request request, Model model) {
		request.setStatusNo(1);
		

		log.info(model.toString());
		
		
//		
//		int result = requestService.request(request);
//		if(result == IRequestRegisterService.REQUEST_SUCCESS) {
//			return "redirect:/login";
//		} else {
//			model.addAttribute("requestResult", "FAIL");
//			return "redirect:/customer/request";
//		}
//		
		return "redirect:/login";
	}
	
	
	@GetMapping("/requestlist")
	public String requestList(Request request, Model model, Pager pager) {
		
		List<Request> requestList= requestService.getRequestList(request, pager);
		model.addAttribute("requestList", requestList);
		
		
		log.info(model.toString());
		
		return "request/requestlist";
	}
	
	
	
	@PostMapping("/viewstep")
	@ResponseBody
	public int viewStep(Model model, Request request) {
		log.info("viewStep");
		log.info(request.getRno());
		int result = requestService.getPresentStep(request.getRno());
		
		log.info("리턴값" + result);
		
		return result;
	}
	


}
