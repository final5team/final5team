package com.oti.srm.controller.srm;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oti.srm.dto.ListFilter;
import com.oti.srm.dto.Member;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.SelectPM;
import com.oti.srm.dto.StatusHistoryFile;
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
	


	
	/** Kang Ji Seong
	 *  유저 등록 폼 요청 
	 */
	@GetMapping("/register")
	public String register(Model model) {
		List<System> systemList = userRegisterService.getSystemList();
		model.addAttribute("systemList", systemList);
		return "member/userregister";
	}
	
	/** Kang Ji Seong
	 *  유저 등록 폼 요청 
	 */
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

	/** Kang Ji Seong
	 *  요청 등록 폼 요청
	 */
	@GetMapping("/request")
	public String customerRequest(Member member, Request request, Model model, RequestProcess requestProcess, HttpSession session) {
		
		//로그인 member 정보는 JSP에서 SessionScope 이용하여 표시
		//요청 단계 (default 값으로 지정하여 전달)
		request.setStatusName("접수중");
		request.setStatusNo(1);
		requestProcess.setReqType("정규");
		
		//시스템 리스트 전달
		List<System> systemList = userRegisterService.getSystemList();
		
		model.addAttribute("request", request);
		model.addAttribute("requestProcess", requestProcess);
		model.addAttribute("systemList", systemList);
		
		return "srm/request";
	}
	
	/** 
	 *  요청 등록 폼 작성
	 */
	@PostMapping("/request")
	public String customerRequest(Request request, Model model, HttpSession session,@RequestParam("mfile[]") MultipartFile[] files) {
		//요청 상태값은 1
		request.setStatusNo(1);
		request.setSno(1);
		Member member = (Member) session.getAttribute("member");
		request.setClient(member.getMname());
		
		log.info("파일 길이 : " + files.length);
		
		List<StatusHistoryFile> fileList = new ArrayList<>();
		
		
		try {
		if(files != null) {
			for(MultipartFile file : files) {
				if(!file.isEmpty()) {
					StatusHistoryFile shf = new StatusHistoryFile();
					shf.setFileData(file.getBytes());
					shf.setFileName(file.getOriginalFilename());
					shf.setFileType(file.getContentType());
					fileList.add(shf);
				}
			}
		}
		} catch(Exception e) {
			e.printStackTrace();
		}
			int result = requestService.writeRequest(request, fileList);
			if(result == IRequestRegisterService.REQUEST_SUCCESS) {
				return "redirect:/customer/requestlist";
			} else {
				model.addAttribute("requestResult", "FAIL");
				return "redirect:/customer/request";
			}
	}

	/** Kang Ji Seong
	 * 	member type별 요청 조회
	 * 
	 */
	@GetMapping("/requestlist")
	public String requestList(Request request, Model model, HttpSession session, @RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue="")String date_first, @RequestParam(defaultValue="")String date_last,
			@RequestParam(defaultValue="0")int sno, @RequestParam(defaultValue="전체")String req_type ) {
		
		//필터에 출력할 시스템 리스트 조회
		List<System> systemList = userRegisterService.getSystemList();
		
		//전달받은 필터 값 저장
		ListFilter listFilter = new ListFilter();
		listFilter.setReqType(req_type);
		listFilter.setDateFirst(date_first);
		listFilter.setDateLast(date_last);
		listFilter.setSno(sno);
		
		//유저 권한 확인
		Member member = (Member) session.getAttribute("member");
		//유저 id 저장
		request.setMid(member.getMid());
		
		

		
		//PM case
		if(member.getMtype().equals("pm")) {
			//PM은 전체 조회가 가능함.
			int totalRows = requestService.getPmTotalRows();
			
			if(pageNo == 1) {
				//pageNo 1인 경우
				log.info("1page 요청");
				Pager pager = new Pager(5, 5,totalRows, pageNo);
				List<SelectPM> requestList = requestService.getPmRequestList(request, listFilter, pager);
				
				
				//시스템 리스트 전달
				model.addAttribute("systemList", systemList);
				//목록 리스트와 페이지 return
				model.addAttribute("requestList", requestList);
				model.addAttribute("pager", pager);
				
				return "srm/requestlist";
				
			} else {
				//요청한 페이지로 이동.
				log.info(pageNo + "pageNo != 1");
				Pager pager = new Pager(5, 5,totalRows, pageNo);
				
				
				requestService.getPmRequestList(request, listFilter, pager);
				return "srm/requestlist";
			}
		//Not PM
		} else {
			log.info("not PM");
		}

		
		
		
//		
//		Pager pager = new Pager(5, 5, 10, pageNo);
//		List<Request> requestList = requestService.getRequestList(request, pager);
//		model.addAttribute("requestList", requestList);
		return "srm/requestlist";
//		
	}
	
	/** Kang Ji Seong
	 * 	member type 단계 처리 가져오기
	 */
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
