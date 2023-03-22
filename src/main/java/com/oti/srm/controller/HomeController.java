package com.oti.srm.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Notice;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistoryFile;
import com.oti.srm.service.notice.INoticeService;
import com.oti.srm.service.srm.ICommonService;

import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	ICommonService commonService;
	@Autowired
	INoticeService noticeService;

	/**
	 * 실무자 업무 리스트 AJAX
	 * @author  				장현, 송영훈
	 * @param session 			세션에 저장된 member객체 추출
	 * @param model 			view에 전달할 객체 주입
	 * @param checkbox  		내 SR / 전체 SR 구분을 위함 
	 * @param workPageNo 		실무자 업무 리스트 페이지 번호 받기
	 * @param noticePageNo		공지사항 리스트 페이지 번호 받기
	 * @param status 			진행상태 받기 
	 * @return 					home.jsp 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model model,@RequestParam(defaultValue = "y") String checkbox,
			@RequestParam(defaultValue ="1") int workPageNo, @RequestParam(defaultValue ="전체") String status, @RequestParam(defaultValue ="1") int noticePageNo) {
		logger.info("실행");
		//세션에 담긴 member객체 받기
		Member member = (Member) session.getAttribute("member");
		
		//PM이 / 경로를 요청했을 경우 /pmhome으로 리다이렉트 시킴
		if(member.getMtype().equals("pm")) {
			return "redirect:/pmhome";
		}
		if(member.getMtype().equals("user")) {
			return "redirect:/userhome" ;
		}
		
		//각 요청건 출력
		HashMap<String,Integer> workingStatus = commonService.getWorkingStatus(member);
		//직무 요청 리스트 출력 및 페이지 처리
		int requestProcessTotalRows = commonService.getRequestProcessRows(member, checkbox, status);
		Pager rpPager = new Pager(7,5,requestProcessTotalRows,workPageNo);
		List<RequestProcess> requestProcessList = commonService.getRequestProcessList(member, checkbox, status, rpPager);
		//공지사항
		String searchWord = "";
		String searchType = "";
		int noticeTotalRows = noticeService.getNoticeListCount(searchType, searchWord, member.getMtype());
		Pager nPager = new Pager(7,5,noticeTotalRows,noticePageNo);
		List<Notice> noticeList = noticeService.getNoticeList(searchType, searchWord, member.getMtype(), nPager);
		
		log.info("requestProcessTotalRows" + requestProcessTotalRows);
		//모달에 담기
		model.addAttribute("checkbox", checkbox);
		model.addAttribute("workingStatus", workingStatus);
		model.addAttribute("rpPager", rpPager);
		model.addAttribute("requestProcessList", requestProcessList);
		model.addAttribute("nPager", nPager);
		model.addAttribute("noticeList", noticeList);
		
		//세션에 사이드 버튼 입력 주기
		session.setAttribute("where", "dashboard");
		return "/home";
		
	}
	
	/**
	 * 사용자의 메인페이지 조회
	 * @author  				장현, 송영훈
	 * @param session 			세션에 저장된 member객체 추출
	 * @param model 			view에 전달할 객체 주입
	 * @param noticePageNo 		메인페이지의 공지사항 pageNo 받기
	 * @param myReqestPageNo 	나의 요청리스트 페이지 번호 받기
	 * @param status 			완료/반려/진행중/전체 상태에 따라 데이터 추출
	 * @return					userhome.jsp
	 */
	@GetMapping("/userhome")
	public String userHome(HttpSession session, Model model,
			@RequestParam(defaultValue ="1") int noticePageNo, @RequestParam(defaultValue = "1") int myRequestPageNo,
			@RequestParam(defaultValue ="전체") String searchStatus) {
		log.info("실행");
		//세션에 담긴 member객체 받기
		Member member = (Member) session.getAttribute("member");
		
		//멤버 타입에 따라 경로 보내주기
		if(member.getMtype().equals("pm")) {
			return "redirect:/pmhome";
		}
		if(!member.getMtype().equals("pm")&&!member.getMtype().equals("user")) {
			return "redirect:/" ;
		}
		
		
		//각 요청건 출력
		HashMap<String, Integer> userRequestStatusCount = commonService.getUserRequestStatusCount(member);
		// 나의 요청 상황 리스트 
		int requestListTotalRows = commonService.getUserRequestListCount(searchStatus, member);
		Pager uPager = new Pager(7, 5, requestListTotalRows, myRequestPageNo);
		List<Request> userRequestList = commonService.getUserRequestList(searchStatus, member, uPager);
		//공지사항
		String searchWord = "";
		String searchType = "";
		int noticeTotalRows = noticeService.getNoticeListCount(searchType, searchWord, member.getMtype());
		Pager nPager = new Pager(7,5,noticeTotalRows,noticePageNo);
		List<Notice> noticeList = noticeService.getNoticeList(searchType, searchWord, member.getMtype(), nPager);
		//모달에 담기
		model.addAttribute("searchStatus", searchStatus);
		model.addAttribute("userRequestStatusCount" , userRequestStatusCount);
		model.addAttribute("uPager", uPager);
		model.addAttribute("userRequestList", userRequestList);
		model.addAttribute("nPager", nPager);
		model.addAttribute("noticeList", noticeList);
		
		//세션에 사이드 버튼 입력 주기 
		session.setAttribute("where", "dashboard");
		
		return "/userhome";
	}
	/**
	 * 관리자(pm)의 메인페이지
	 * @author  				장현, 송영훈
	 * @param session 			세션에 저장된 member객체 추출
	 * @param model				view에 전달할 객체 주입
	 * @param noticePageNo 		메인페이지의 공지사항 페이지 번호 받기
	 * @param pmWorkPageNo 		pm 업무리스트 페이지 번호 받기 
	 * @param status 			접수대기/승인대기/진행중/완료및반려 진행상태 받기
	 * @param dDay7PageNo 		D-7요청리스트 페이지 번호 받기
	 * @return					pmhome.jsp 
	 */
	@GetMapping("/pmhome")
	public String pmHome(HttpSession session, Model model,@RequestParam(defaultValue ="1") int noticePageNo, 
			@RequestParam(defaultValue ="1") int dDay7PageNo,  @RequestParam(defaultValue ="1") int pmWorkPageNo, @RequestParam(defaultValue ="전체") String status) {
		log.info("실행");
		//세션에 담긴 member객체 받기
		Member member = (Member) session.getAttribute("member");
		
		//멤버 타입에 따라 경로 보내주기
		if(member.getMtype().equals("user")) {
			return "redirect:/userhome";
		}
		if(!member.getMtype().equals("pm")&&!member.getMtype().equals("user")) {
			return "redirect:/" ;
		}
		
		//각 요청건 출력
		HashMap<String, Integer> workingStatus = commonService.getWorkingStatus(member);
		//D-7 리스트 출력
		int dDayTotalRows = commonService.getListOf7daysLeftCount(member);
		Pager dPager = new Pager(7, 5, dDayTotalRows, dDay7PageNo);
		List<Request> listOf7daysLeft = commonService.getListOf7daysLeft(member, dPager);
		//공지사항
		String searchWord = "";
		String searchType = "";
		int noticeTotalRows = noticeService.getNoticeListCount(searchType, searchWord, member.getMtype());
		Pager nPager = new Pager(7,5,noticeTotalRows,noticePageNo);
		List<Notice> noticeList = noticeService.getNoticeList(searchType, searchWord, member.getMtype(), nPager);
		//직무 요청 리스트 출력 및 페이지 처리
		int requestProcessTotalRows = commonService.getPmRequestProcessRows(status);
		log.info(requestProcessTotalRows);
		Pager rpPager = new Pager(7,5,requestProcessTotalRows,pmWorkPageNo);
		List<RequestProcess> requestProcessList = commonService.getPmRequestProcessList(status, rpPager);
				
		//모달에 담기
		model.addAttribute("workingStatus", workingStatus);
		model.addAttribute("dPager", dPager);
		model.addAttribute("listOf7daysLeft", listOf7daysLeft);
		model.addAttribute("nPager", nPager);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("rpPager",rpPager);
		model.addAttribute("requestProcessList",requestProcessList);
		model.addAttribute("searchStatus", status);
		
		//세션에 사이드 버튼 입력 주기 (실무자들 = workers/ pm = pm / 유저 = user)
		session.setAttribute("where", "dashboard");
		
		return "/pmhome";
	}
	/**
	 * 내 요청리스트(사용자) ajax 
	 * @author  				장현, 송영훈
	 * @param session 			세션에 저장된 member객체 추출
	 * @param myRequestPageNo 	내 요청리스트 페이지 번호 받기
	 * @param searchStatus 		진행중/완료/반려 진행상태 받기 
	 * @return 					내 요청리스트 조각 jsp 
	 */
	@GetMapping("/userrequestlist")
	public String getUserRequestList(HttpSession session, Model model, @RequestParam(defaultValue = "1") int myRequestPageNo,
			@RequestParam(defaultValue ="전체") String searchStatus) {
		log.info("실행");
		//세션에 담긴 member객체 받기
		Member member = (Member) session.getAttribute("member");
		// 나의 요청 상황 리스트 
		int requestListTotalRows = commonService.getUserRequestListCount(searchStatus, member);
		Pager uPager = new Pager(7, 5, requestListTotalRows, myRequestPageNo);
		List<Request> userRequestList = commonService.getUserRequestList(searchStatus, member, uPager);
		model.addAttribute("searchStatus", searchStatus);
		model.addAttribute("uPager", uPager);
		model.addAttribute("userRequestList",userRequestList);
		return "srm/uRequestList";
	}
	
	/**
	 * D-7 요청리스트 ajax 
	 * @author  				장현, 송영훈
	 * @param session 			세션에 저장된 member객체 추출
	 * @param dDay7PageNo 	    D-7 요청리스트 페이지 번호
	 * @return 					D-7 요청리스트 조각 jsp 
	 */
	@GetMapping("/7dayslist")
	public String get7DaysList(HttpSession session, Model model, @RequestParam(defaultValue ="1") int dDay7PageNo ) {
		log.info("실행");
		//세션에 담긴 member객체 받기
		Member member = (Member) session.getAttribute("member");
		//D-7 리스트 출력
		int dDayTotalRows = commonService.getListOf7daysLeftCount(member);
		Pager dPager = new Pager(7, 5, dDayTotalRows, dDay7PageNo);
		List<Request> listOf7daysLeft = commonService.getListOf7daysLeft(member, dPager);
		model.addAttribute("dPager",dPager);
		model.addAttribute("listOf7daysLeft",listOf7daysLeft);
		return "srm/7DaysList";
	}
	
	/**
	 * 실무자 업무 리스트 AJAX
	 * @author  				장현, 송영훈
	 * @param session 			세션에 저장된 member객체 추출
	 * @param checkbox  		내 SR / 전체 SR 구분을 위함 
	 * @param workPageNo 		실무자 업무 리스트 페이지 번호 받기
	 * @param status 			진행상태 받기 
	 * @return 					실무자 업무 리스트 조각 jsp 
	 */
	@GetMapping("/requestprocesslist")
	public String getRequestProcessList(HttpSession session, Model model,@RequestParam(defaultValue = "n") String checkbox,
			@RequestParam(defaultValue ="1") int workPageNo, @RequestParam(defaultValue ="전체") String status) {
		log.info("실행");
		//세션에 담긴 member객체 받기
		Member member = (Member) session.getAttribute("member");
		//직무 요청 리스트 출력 및 페이지 처리
		int requestProcessTotalRows = commonService.getRequestProcessRows(member, checkbox, status);
		Pager rpPager = new Pager(7,5,requestProcessTotalRows,workPageNo);
		List<RequestProcess> requestProcessList = commonService.getRequestProcessList(member, checkbox, status, rpPager);
		log.info("checkbox" + checkbox + ", 갯수 : " + requestProcessTotalRows);
		model.addAttribute("checkbox", checkbox);
		model.addAttribute("rpPager",rpPager);
		model.addAttribute("requestProcessList",requestProcessList);
		model.addAttribute("searchStatus", status);
		return "srm/requestProcessList";
	}
	
	/**
	 * PM 업무리스트 ajax 
	 * @author  				장현, 송영훈
	 * @param session 			세션에 저장된 member객체 추출
	 * @param pmWorkPageNo 		PM 업무리스트 페이지 번호 받기
	 * @param status 			진행상태 받기 
	 * @return 					PM 업무리스트 조각 jsp 
	 */
	@GetMapping("/pmrequestprocesslist")
	public String getPmRequestProcessList(HttpSession session, Model model, @RequestParam(defaultValue ="1") int pmWorkPageNo, @RequestParam(defaultValue ="전체") String status) {
		log.info("실행");
		//직무 요청 리스트 출력 및 페이지 처리
		int requestProcessTotalRows = commonService.getPmRequestProcessRows(status);
		log.info(requestProcessTotalRows);
		Pager rpPager = new Pager(7,5,requestProcessTotalRows,pmWorkPageNo);
		List<RequestProcess> requestProcessList = commonService.getPmRequestProcessList(status, rpPager);
		model.addAttribute("rpPager",rpPager);
		model.addAttribute("requestProcessList",requestProcessList);
		model.addAttribute("searchStatus", status);
		return "srm/pmRequestProcessList";
	}
	
	/**
	 * 공지사항 리스트 ajax 
	 * @author  				장현, 송영훈
	 * @param session 			세션에 저장된 member객체 추출
	 * @param noticePageNo 		공지사항 리스트 페이지 번호 받기
	 * @return 					내 요청리스트 조각 jsp 
	 */
	@GetMapping("/mainnoticelist")
	public String getMainNoticeList(HttpSession session, Model model,@RequestParam(defaultValue ="1") int noticePageNo) {
		log.info("실행");
		//세션에 담긴 member객체 받기
		Member member = (Member) session.getAttribute("member");
		//공지사항
		String searchWord = "";
		String searchType = "";
		int noticeTotalRows = noticeService.getNoticeListCount(searchType, searchWord, member.getMtype());
		Pager nPager = new Pager(7,5,noticeTotalRows,noticePageNo);
		List<Notice> noticeList = noticeService.getNoticeList(searchType, searchWord, member.getMtype(), nPager);
		model.addAttribute("nPager",nPager);
		model.addAttribute("noticeList",noticeList);
		return "srm/mainNoticeList";
	}
	
	/**
	 * 파일 다운로드 
	 * @author  				장현, 송영훈
	 * @param fno 				가져올 파일의 고유번호
	 * @return 					파일 데이터가 포함된 ResponseEntity객체 
	 */
	@RequestMapping("/filedouwnload/{fno}")
	public ResponseEntity<byte[]> getFile(@PathVariable int fno) throws Exception {
		StatusHistoryFile file = commonService.getFile(fno);
		final HttpHeaders headers = new HttpHeaders();
		String[] mtypes = file.getFileType().split("/");
		headers.setContentType(new MediaType(mtypes[0], mtypes[1]));
		headers.setContentDispositionFormData("attachment",new String(file.getFileName().getBytes("UTF-8"), "ISO-8859-1"));
		return new ResponseEntity<byte[]>(file.getFileData(), headers, HttpStatus.OK);
	}
}
