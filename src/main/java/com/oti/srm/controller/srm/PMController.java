package com.oti.srm.controller.srm;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;
import com.oti.srm.dto.WorkingInfo;
import com.oti.srm.service.member.IMemberService;
import com.oti.srm.service.member.MemberService;
import com.oti.srm.service.srm.ICommonService;
import com.oti.srm.service.srm.IPMService;

import lombok.extern.log4j.Log4j2;

/**
 * @author KIM JI YOUNG
 *
 */
@Controller
@RequestMapping("/pm")
@Log4j2
public class PMController {
	@Autowired
	ICommonService commonService;
	@Autowired
	IPMService pMService;
	@Autowired
	IMemberService memberService;

	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param rno
	 * @param session
	 * @param model
	 * @return
	 */
	// 접수 상세보기
	@GetMapping("/receiptdetail")
	public String receiptDetail(int rno, HttpSession session, Model model) {
		// 요청정보
		Request request = commonService.getRequest(rno);
		model.addAttribute("request", request);
		// 요청 상태가 접수중일 때 담당자 정보
		// 개발자 정보
		model.addAttribute("devStaffList", pMService.getStaffBySno(request.getSno(), "developer"));
		// 테스터 정보
		model.addAttribute("tesStaffList", pMService.getStaffBySno(request.getSno(), "tester"));
		// 유저테스터 정보
		model.addAttribute("uteStaffList", pMService.getStaffBySno(request.getSno(), "usertester"));
		// 배포자 정보
		model.addAttribute("disStaffList", pMService.getStaffBySno(request.getSno(), "distributor"));
		model.addAttribute("requestProcess", commonService.getRequestProcess(rno));
		model.addAttribute("pmToAllHistories", commonService.getPmToAllHistories(rno));
		model.addAttribute("testRejectExist", commonService.isThereTestReject(rno));
		// 세션에 저장된 현재 로그인 사용자 정보 구하기
		Member member = (Member) session.getAttribute("member");
		// 확인 여부 
		if(request.getPmCheck()==1 && member.getMtype().equals("pm") && request.getStatusNo()==1) {
			// PM 확인 여부 변경
			commonService.check("pm", request.getRno());
		}		
		// 요청 상태가 반려일 때 상태 변경 정보(반려 사유)
		if(request.getStatusNo()==12) {
			model.addAttribute("rejectHistory", pMService.getStatusHistory(rno, "reject"));
		}		
		// 신규 내역 알림 갱신
		session.setAttribute("newAlertList", commonService.getNewAlertList(member));	
		return "srm/receipt";
	}

	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param statusHistory
	 * @param requestProcess
	 * @param files
	 * @param session
	 * @param model
	 * @return
	 */
	// 접수하기
	@RequestMapping(value = "/receipt", method = RequestMethod.POST)
	public String receipt(StatusHistory statusHistory, RequestProcess requestProcess, MultipartFile[] files,
			HttpSession session, Model model) {
		try {
			// 작성자 입력
			Member me = (Member) session.getAttribute("member");
			statusHistory.setWriter(me.getMid());
			requestProcess.setPm(me.getMid());

			// 첨부파일 매핑
			if (files != null) {
				// 첨부파일 저장할 List 객체 생성
				List<StatusHistoryFile> fileList = new ArrayList<>();
				for (MultipartFile file : files) {
					// 첨부파일 값이 존재할 때
					if (file != null && !file.isEmpty()) {
						// 상태 이력 파일 DTO에 저장
						StatusHistoryFile shf = new StatusHistoryFile();
						// 첨부파일 이름 저장
						shf.setFileName(file.getOriginalFilename());
						// 첨부파일 타입 저장
						shf.setFileType(file.getContentType());
						// 첨부파일 데이터 저장
						shf.setFileData(file.getBytes());
						// List에 파일 저장
						fileList.add(shf);
					}
				}
				// 상태 이력 기록 파일에 파일 저장
				statusHistory.setFileList(fileList);
			}
			// 접수 완료
			int result = pMService.receipt(statusHistory, requestProcess);
			// 접수 성공
			if (result == 1) {
				return "redirect:/customer/requestlist";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/pm/receiptdetail?rno=" + requestProcess.getRno();
	}

	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param rno
	 * @param session
	 * @param model
	 * @return
	 */
	// 완료 전 상세보기
	@GetMapping("/completedetail")
	public String completeDetail(int rno, HttpSession session, Model model) {
		// 서비스 요청 정보
		Request request=commonService.getRequest(rno);
		model.addAttribute("request", request);	
		// 요청 처리 정보
		model.addAttribute("reqProcess", commonService.getRequestProcess(rno));

		// 세션에 저장된 현재 로그인 사용자 정보 구하기
		Member member = (Member) session.getAttribute("member");
		// 확인 여부 
		if(request.getPmCheck()==1 && member.getMtype().equals("pm") && request.getStatusNo()==11) {
			// PM 확인 여부 변경
			commonService.check("pm", request.getRno());
		}				
		// 신규 내역 알림 갱신
		session.setAttribute("newAlertList", commonService.getNewAlertList(member));	
		
		return "srm/complete";
	}

	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param statusHistory
	 * @param session
	 * @param model
	 * @return
	 */
	// 완료 처리하기
	@RequestMapping("/complete")
	public String complete(StatusHistory statusHistory, HttpSession session, Model model) {
		// 작성자 입력
		Member me = (Member) session.getAttribute("member");
		statusHistory.setWriter(me.getMid());

		// 최종 완료 처리
		statusHistory.setNextStatus(13);
		// PM 처리 완료(완료 승인)
		commonService.endWork(statusHistory, me.getMtype());
		// 서비스 변경 여부(사용자 미확인)
		commonService.notCheck("user", statusHistory.getRno());

		return "redirect:/pm/enddetail?rno=" + statusHistory.getRno();
	}

	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param rno
	 * @param session
	 * @param model
	 * @return
	 */
	// 완료 후 상세보기
	@RequestMapping("/enddetail")
	public String endDetail(int rno, HttpSession session, Model model) {
		// 서비스 요청 정보
		Request request = commonService.getRequest(rno);
		model.addAttribute("request", request);	
		// 요청 처리 정보
		model.addAttribute("requestProcess", commonService.getRequestProcess(rno));
		// 요청 처리 내역
		// 요청 상태가 반려일 때 상태 변경 정보(반려 사유)
		if(request.getStatusNo()==12) {
			model.addAttribute("rejectHistory", pMService.getStatusHistory(rno, "reject"));
		}
		model.addAttribute("devStatusHistory", pMService.getStatusHistory(rno, "developer"));
		model.addAttribute("tesStatusHistory", pMService.getStatusHistory(rno, "tester"));
		model.addAttribute("uteStatusHistory", pMService.getStatusHistory(rno, "usertester"));
		model.addAttribute("disStatusHistory", pMService.getStatusHistory(rno, "distributor"));
		model.addAttribute("testRejectExist", commonService.isThereTestReject(rno));
				
		// 세션에 저장된 현재 로그인 사용자 정보 구하기
		Member member = (Member) session.getAttribute("member");
		// PM 확인 여부 
		if(request.getPmCheck()==1 && member.getMtype().equals("pm") && request.getStatusNo()==11) {
			// PM 확인 여부 변경
			commonService.check("pm", request.getRno());
		}
		// 사용자 확인 여부 변경	
		log.info("check: "+request.getUsrCheck());
		log.info("u: "+member.getMtype().equals("user"));
		log.info("c: "+request.getClient());
		if(request.getUsrCheck()==1 && member.getMtype().equals("user") && request.getClient().equals(member.getMid())) {
			commonService.check("user", request.getRno());
		}
		// 신규 내역 알림 갱신
		session.setAttribute("newAlertList", commonService.getNewAlertList(member));	
		
		return "srm/end";
	}

	// 화면에서 입력한 날짜 컨트롤러의 Date 매개변수에 넣기
	// @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date expectDate

	// 완료 처리하기
	@GetMapping("/workinginfo")
	@ResponseBody
	public List<WorkingInfo> workinginfo(String mid, HttpSession session, Model model) {
		log.info("실행");
		Member member = new Member();
		member.setMid(mid);
		member.setPassword("1234");
		Member me = memberService.getMember(member);
		List<WorkingInfo> workingInfoList =  pMService.getWorkingInfo(me);
		for(WorkingInfo wif : workingInfoList) {
			log.info("rno : " + wif.getRno());
			wif.setMtype(me.getMtype());
		}
		return workingInfoList;
	}
}
