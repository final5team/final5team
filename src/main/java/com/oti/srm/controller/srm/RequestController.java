package com.oti.srm.controller.srm;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
		return "member/userregister";
	}

	@PostMapping("/register")
	public String register(Member member, Model model) {
		log.info("등록 실행");
		String address = member.getPostcode() + member.getAddr1() + member.getAddr2();
		member.setAddress(address);
		
		MultipartFile mfile = member.getMfile();
		log.info(member.toString());
		
		try {

			if (mfile != null && !mfile.isEmpty()) {
				log.info(mfile.toString());
				member.setFileName(mfile.getOriginalFilename());
				member.setSavedDate(new Date());
				member.setFileType(mfile.getContentType());
				member.setFileData(mfile.getBytes());
				
				int result  = userRegisterService.register(member);
				if(result == IUserRegisterService.REGISTER_FAIL) {
					return "redirect:/customer/register";
				} else {
					return "redirect:/";
				}
				
			} else {
				int result = userRegisterService.register(member);
				if (result == IUserRegisterService.REGISTER_FAIL) {
					return "redirect:/customer/register";
					//성공
				} else {
					return "redirect:/";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("registerResult", "FAIL");
			return "redirect:/customer/register";
		}
	}

	@GetMapping("/request")
	public String customerRequest() {
		return "srm/request";
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
	public String requestList(Request request, Model model, HttpSession session) {


		Pager pager = new Pager();
		
		
		
		List<Request> requestList = requestService.getRequestList(request, pager);
		model.addAttribute("requestList", requestList);
		return "srm/requestlist";
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
