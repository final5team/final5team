package com.oti.srm.controller.srm;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
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
	
	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param rno
	 * @param sno
	 * @param session
	 * @param model
	 * @return
	 */
	// 상세보기
	@GetMapping("/receiptdetail")
	public String receiptDetail(int rno, int sno, HttpSession session, Model model) {
		// 요청정보
		model.addAttribute("request", commonService.getRequest(rno));
		// 개발자 정보
		model.addAttribute("devStaffList", pMService.getStaffBySno(sno, "developer"));
		// 테스터 정보
		model.addAttribute("tesStaffList", pMService.getStaffBySno(sno, "tester"));
		// 유저테스터 정보
		model.addAttribute("uteStaffList", pMService.getStaffBySno(sno, "usertester"));
		// 배포자 정보
		model.addAttribute("disStaffList", pMService.getStaffBySno(sno, "distributor"));
		
		return "srm/receipt";
	}
	
	/**
	 * 
	 * @author: KIM JI YOUNG
	 * @param session
	 * @param model
	 * @return
	 */
	// 접수
	@RequestMapping("/receipt")
	public String receipt(StatusHistory statusHistory, RequestProcess requestProcess, HttpSession session, Model model) {
		log.info("접수");
		// 작성자 입력
		Member me = (Member) session.getAttribute("member");		
		statusHistory.setWriter(me.getMid());
		requestProcess.setPm(me.getMid());
		log.info(me.getMid());
		log.info(statusHistory);
		log.info(requestProcess);
		// 접수 완료
		int result=pMService.receipt(statusHistory, requestProcess);
		if(result==1) {
			return "srm/receipt"; //목록 가든가 개발 상세 가든가
		}
		return "redirect:/";
	}
	
	// 완료 처리
	@RequestMapping("/complete")
	public String complete(HttpSession session, Model model) {
		
		return "srm/complete";
	}
	
	// 완료 상세
	@RequestMapping("/end")
	public String end(HttpSession session, Model model) {
		
		return "srm/end";
	}	
	
	//화면에서 입력한 날짜 컨트롤러의 Date 매개변수에 넣으려면 
	//@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date expectDate
}
