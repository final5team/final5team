package com.oti.srm.controller.srm;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

/**
 * @author KOSA
 *
 */
/**
 * @author KOSA
 *
 */
/**
 * @author KOSA
 *
 */
@Controller
@Log4j2
@RequestMapping("/customer")
public class RequestController {

	@Autowired
	private IUserRegisterService userRegisterService;
	@Autowired
	private IRequestRegisterService requestService;

	/**
	 * Kang Ji Seong 유저 등록 페이지 조회
	 */
	@GetMapping("/register")
	public String register(Model model) {
		List<System> systemList = userRegisterService.getSystemList();
		model.addAttribute("systemList", systemList);
		return "member/userregister_re";
	}

	/**
	 * Kang Ji Seong 유저 등록
	 */
	@PostMapping("/register")
	public String register(Member member, Model model) {
		String address = member.getPostcode() + "-" + member.getAddr1() + "-" + member.getAddr2();
		member.setAddress(address);
		member.setPassword("0000");
		MultipartFile mfile = member.getMfile();
		log.info("유저 등록");
		log.info(member.toString());
		
		try {
			if (mfile != null && !mfile.isEmpty()) {
				member.setFileName(mfile.getOriginalFilename());
				member.setSavedDate(new Date());
				member.setFileType(mfile.getContentType());
				member.setFileData(mfile.getBytes());

				int result = userRegisterService.register(member);
				if (result == IUserRegisterService.REGISTER_FAIL) {
					return "redirect:/customer/register";
				} else {
					return "redirect:/";
				}
			} 
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("registerResult", "FAIL");
			return "redirect:/customer/register";
		}
		return "redirect:/customer/register";
	}

	/**
	 * Kang Ji Seong 내 정보 조회
	 */
	@GetMapping("/mypage")
	public String myPage(HttpSession session, Model model) {
		// 내 정보 조회
		Member Sessionmember = (Member) session.getAttribute("member");
		Member returnMember = userRegisterService.getUserInfo(Sessionmember.getMid());

		// 주소 변환
		String[] address = returnMember.getAddress().split("-");
		returnMember.setPostcode(Integer.parseInt(address[0]));
		returnMember.setAddr1(address[1]);
		returnMember.setAddr2(address[2]);


		model.addAttribute("returnMember", returnMember);

		return "member/mypage";
	}

	/**
	 * Kang Ji Seong img byte[] 변환 메소드
	 */
	@GetMapping("/mypage/{mid}")
	public ResponseEntity<byte[]> returnImg(@PathVariable String mid) {
		
		Member returnMember = userRegisterService.getUserInfo(mid);
		
		if(returnMember.getMfile() == null) {
			returnMember = userRegisterService.getUserInfo("img");
		}
		HttpHeaders headers = new HttpHeaders();
		String[] fileTypes = returnMember.getFileType().split("/");
		headers.setContentType(new MediaType(fileTypes[0], fileTypes[1]));
		headers.setContentDispositionFormData("attachment", returnMember.getFileName());
		return new ResponseEntity<byte[]>(returnMember.getFileData(), headers, HttpStatus.OK);

		
	}

	// 요청 작성 페이지
	@GetMapping("/request")
	public String customerRequest(Member member, Request request, Model model, RequestProcess requestProcess,
			HttpSession session) {
		// 로그인 member 정보는 JSP에서 SessionScope 이용하여 표시
		// 요청 단계 (default 값으로 지정하여 전달)
		request.setStatusName("접수중");
		request.setStatusNo(1);
		requestProcess.setReqType("정규");
		
		// 시스템 리스트 전달
		List<System> systemList = userRegisterService.getSystemList();
		model.addAttribute("request", request);
		model.addAttribute("requestProcess", requestProcess);
		model.addAttribute("systemList", systemList);
		
		return "srm/request/request";
	}
	
	/**
	 * 요청 등록 폼 작성
	 */
	@PostMapping("/request")
	public String customerRequest(Request request, Model model, HttpSession session,
			@RequestParam("mfile[]") MultipartFile[] files) {
		// 요청 상태값은 1
		request.setStatusNo(1);
		Member member = (Member) session.getAttribute("member");
		request.setClient(member.getMid());

		List<StatusHistoryFile> fileList = new ArrayList<>();

		try {
			if (files != null) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						StatusHistoryFile shf = new StatusHistoryFile();
						shf.setFileData(file.getBytes());
						shf.setFileName(file.getOriginalFilename());
						shf.setFileType(file.getContentType());
						fileList.add(shf);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		int result = requestService.writeRequest(request, fileList);
		if (result == IRequestRegisterService.REQUEST_SUCCESS) {
			if(member.getMtype().equals("user")) {
				return "redirect:/customer/userrequestlist";
			} else {
				return "redirect:/customer/requestlist";
			}
		} else {
			model.addAttribute("requestResult", "FAIL");
			if(member.getMtype().equals("user")) {
				return "redirect:/customer/userrequestlist";
			} else {
				return "redirect:/customer/requestlist";
			}
		}
	}
	
	//(유저) 요청 리스트 초기 조회

	@GetMapping("/userrequestlist")
	public String myrequestlist (Model model, HttpSession session) {
		//시스템
		List<System> systemList = userRegisterService.getSystemList();
		model.addAttribute("systemList", systemList);
		
		// 유저 정보 전달
		Member member = (Member) session.getAttribute("member");
		
		//초기값
		ListFilter listFilter = new ListFilter();
		listFilter.setReqType("전체");
		listFilter.setDateFirst("");
		listFilter.setDateLast("");
		listFilter.setSno(0);
		listFilter.setStatusNo(0);
		listFilter.setPageNo(1);
		
		ListFilter returnList = requestService.dateFilterList(listFilter);
		// 보여줄 행 수 조회
		
		int totalRows = requestService.getRequestListRows(listFilter, member);
		Pager pager = new Pager(7, 5, totalRows, listFilter.getPageNo());
		List<SelectPM> requestList = requestService.getMyRequestList(listFilter, pager, member);
		
		// 시스템 리스트 전달
		// 목록 리스트와 페이지 return
		model.addAttribute("requestList", requestList);
		model.addAttribute("pager", pager);
		// filter 전달
		model.addAttribute("listFilter", returnList);
		
		return "srm/uesrrequestlist";
	}
	
	//(유저 제외) 요청 목록 조회 ajax
	@PostMapping("/myrequestlist")
	public String myRequestList(@RequestBody ListFilter listFilter, Model model, HttpSession session) {
		// 요청 조회 필터
		List<System> systemList = userRegisterService.getSystemList();
		// 유저 정보 전달
		Member member = (Member) session.getAttribute("member");
		ListFilter returnList = requestService.dateFilterList(listFilter);
		// 보여줄 행 수 조회
		int totalRows = requestService.getRequestListRows(listFilter, member);
		Pager pager = new Pager(7, 5, totalRows, listFilter.getPageNo());
		List<SelectPM> requestList = requestService.getMyRequestList(listFilter, pager, member);
		
		// 시스템 리스트 전달
		model.addAttribute("systemList", systemList);
		// 목록 리스트와 페이지 return
		model.addAttribute("requestList", requestList);
		model.addAttribute("pager", pager);
		// filter 전달
		model.addAttribute("listFilter", returnList);
		return "srm/list/ajaxmyrequestlist";
	}
	
	//담당 요청 목록 이동 페이지
	@GetMapping("/requestlist")
	public String requestList(Model model, HttpSession session) {
		List<System> systemList = userRegisterService.getSystemList();
		// 유저 정보 전달
		Member member = (Member) session.getAttribute("member");
		//초기값
		ListFilter listFilter = new ListFilter();
		listFilter.setReqType("전체");
		listFilter.setDateFirst("");
		listFilter.setDateLast("");
		listFilter.setSno(0);
		listFilter.setStatusNo(0);
		listFilter.setPageNo(1);
		ListFilter returnList = requestService.dateFilterList(listFilter);
		int totalRows = requestService.getMyWorkRows(listFilter, member);
		Pager pager = new Pager(7, 5, totalRows, listFilter.getPageNo());
		List<SelectPM> requestList = requestService.getMyWorkList(listFilter, pager, member);
		// 시스템 리스트 전달
		model.addAttribute("systemList", systemList);
		// 목록 리스트와 페이지 return
		model.addAttribute("requestList", requestList);
		model.addAttribute("pager", pager);
		// filter 전달
		model.addAttribute("listFilter", returnList);
		return "srm/requestlist_re";
	}
	//담당 요청 목록 조회 ajax
	@PostMapping("/myworklist")
	public String myWrokList(@RequestBody ListFilter listFilter, Model model, HttpSession session) {

		// 필터에 출력할 시스템 리스트 조회
		List<System> systemList = userRegisterService.getSystemList();
		ListFilter returnList = requestService.dateFilterList(listFilter);
		
		//세션에 저장된 멤버 객체 전달
		Member member = (Member) session.getAttribute("member");
		int totalRows = requestService.getMyWorkRows(listFilter, member);
		Pager pager = new Pager(7, 5, totalRows, listFilter.getPageNo());
		List<SelectPM> requestList = requestService.getMyWorkList(listFilter, pager, member);
		// 시스템 리스트 전달
		model.addAttribute("systemList", systemList);
		// 목록 리스트와 페이지 return
		model.addAttribute("requestList", requestList);
		model.addAttribute("pager", pager);
		// filter 전달
		model.addAttribute("listFilter", returnList);
		
		return "srm/list/ajaxmyworklist";
	}
	/**
	 * Kang Ji Seong member type 단계 처리 가져오기
	 */
	@PostMapping("/viewstep")
	@ResponseBody
	public int viewStep(Model model, Request request) {
		int result = requestService.getPresentStep(request.getRno());
		return result;
	}
	
	//요청 글 상세보기
	@GetMapping("/requestdetail")
	public String userRequestDetail(int rno, HttpSession session, Model model) {
		Request request = requestService.getRequestDetail(rno);
		List<System> systemList = userRegisterService.getSystemList();
		
		//반려 페이지
		if(request.getStatusNo() == 12) {
			
			return "srm/requestrejectpage";
		//완료 페이지
		} else if (request.getStatusNo() == 13) {
			
			
			return "srm/pm/enddetail" + rno;
		} else {
			
			model.addAttribute("request", request);
			model.addAttribute("systemList", systemList);
			return "srm/request/requestdetail";
		}
		
		
	}
	
	
	//요청 수정하기
	@PostMapping("/requestupdate")
	public String requestUpdate(Request request, HttpSession session, Model model) {
		
		Member member = (Member) session.getAttribute("member");
		request.setClient(member.getMid());

		int result = requestService.updateRequest(request);
		if (result == IRequestRegisterService.REQUEST_SUCCESS) {
			return "redirect:requestdetail?rno=" + request.getRno();
		} else {
			return "redirect:requestdetail?rno=" + request.getRno();
		}
	}
	
	//요청 글 파일 다운로드
	@GetMapping("/requestdetail/filedownload/{fno}")
	public ResponseEntity<byte[]> filDownload(@PathVariable int fno) throws UnsupportedEncodingException {
		
		log.info(fno);
		
		StatusHistoryFile file = requestService.getMyRequestFile(fno);
		final HttpHeaders headers = new HttpHeaders();
		String [] mtypes = file.getFileType().split("/");
		headers.setContentType(new MediaType(mtypes[0], mtypes[1]));
		headers.setContentDispositionFormData("attachment",new String(file.getFileName().getBytes("UTF-8"), "ISO-8859-1"));
		
		return new ResponseEntity<byte[]>(file.getFileData(), headers, HttpStatus.OK);
	}
	
	

	
	
	
	

}
