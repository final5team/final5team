package com.oti.srm.controller.srm;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;
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
	 * @param session
	 * @param model
	 * @return
	 */
	// 접수 상세보기
	@GetMapping("/receiptdetail")
	public String receiptDetail(int rno, HttpSession session, Model model) {
		// 요청정보
		Request request=commonService.getRequest(rno);
		model.addAttribute("request", request);
		// 개발자 정보
		model.addAttribute("devStaffList", pMService.getStaffBySno(request.getSno(), "developer"));
		// 테스터 정보
		model.addAttribute("tesStaffList", pMService.getStaffBySno(request.getSno(), "tester"));
		// 유저테스터 정보
		model.addAttribute("uteStaffList", pMService.getStaffBySno(request.getSno(), "usertester"));
		// 배포자 정보
		model.addAttribute("disStaffList", pMService.getStaffBySno(request.getSno(), "distributor"));
		
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
	@RequestMapping(value="/receipt", method = RequestMethod.POST)
	public String receipt(StatusHistory statusHistory, RequestProcess requestProcess, MultipartFile[] files, HttpSession session, Model model) {
		try {
			// 작성자 입력
			Member me = (Member) session.getAttribute("member");		
			statusHistory.setWriter(me.getMid());
			requestProcess.setPm(me.getMid());
			
			// 첨부파일 매핑
			if(files!=null) {
				List<StatusHistoryFile> fileList=new ArrayList<>();
				for(MultipartFile file : files) {
					if(file!=null && !file.isEmpty()) {
						StatusHistoryFile shf = new StatusHistoryFile();
						
						shf.setFileName(file.getOriginalFilename());
						shf.setFileType(file.getContentType());
						shf.setFileData(file.getBytes());
						fileList.add(shf);
					}
				}
				statusHistory.setFileList(fileList);
			}			
			// 접수 완료
			int result=pMService.receipt(statusHistory, requestProcess);
			if(result==1) {
				return "srm/request"; //목록 가든가 개발 상세 가든가
			}
		} catch(Exception e) {
			e.printStackTrace();
		}		
		return "redirect:/";
	}
	
	// 완료 전 상세보기
	@GetMapping("/completedetail")
	public String completedetail(int rno, HttpSession session, Model model) {
		// 서비스 요청 정보
		model.addAttribute("request", commonService.getRequest(rno));	
		// 요청 처리 정보
		model.addAttribute("reqProcess", commonService.getRequestProcess(rno));
		
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
		
		//최종 완료 처리
		statusHistory.setNextStatus(13);
		commonService.endWork(statusHistory, me.getMtype());
		return "redirect:/enddetail?rno=" + statusHistory.getRno();
	}
	
	// 완료 후 상세보기
	@RequestMapping("/enddetail")
	public String endDetail(int rno, HttpSession session, Model model) {
		// 서비스 요청 정보
		model.addAttribute("request", commonService.getRequest(rno));	
		// 요청 처리 정보
		model.addAttribute("reqProcess", commonService.getRequestProcess(rno));
		// 요청 처리 내역
		model.addAttribute("devStatusHistory", pMService.getStatusHistory(rno, "developer"));
		model.addAttribute("tesStatusHistory", pMService.getStatusHistory(rno, "tester"));
		model.addAttribute("uteStatusHistory", pMService.getStatusHistory(rno, "usertester"));
		model.addAttribute("disStatusHistory", pMService.getStatusHistory(rno, "distributor"));
		return "srm/end";
	}	
	
	//화면에서 입력한 날짜 컨트롤러의 Date 매개변수에 넣기
	//@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date expectDate
}
