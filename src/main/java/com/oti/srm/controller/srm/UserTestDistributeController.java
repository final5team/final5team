package com.oti.srm.controller.srm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;
import com.oti.srm.service.srm.ICommonService;

import lombok.extern.log4j.Log4j2;


@Log4j2
@Controller
public class UserTestDistributeController {
	@Autowired
	ICommonService commonService;
	
	
	/**
	 * 품질검토단계 상세페이지 조회
	 * @author 			송영훈
	 * @param rno 		조회할 SR번호
	 * @param sesssion  현재 로그인 사용자 정보 얻기
	 * @param model     View에서 사용할 데이터 바인딩 
	 * @return  		품질검토 상세 jsp
	 */
	@GetMapping("/usertestdetail")
	public String userTestDetail(int rno, HttpSession session, Model model) {
		log.info("요청번호" + rno);
		// 요청정보
		Request request = commonService.getRequest(rno);
		model.addAttribute("request", request);
		// 요청 처리정보
		RequestProcess requestProcess = commonService.getRequestProcess(rno);
		model.addAttribute("requestProcess", requestProcess);
		// 품질검사 완료 내역
		model.addAttribute("userTesterToDistributorHistories", commonService.getUserTesterToDistributorHistories(rno));
		// 임시저장 정보
		StatusHistory sh = new StatusHistory();
		sh.setRno(rno);
		sh.setNextStatus(17);
		Member member = (Member) session.getAttribute("member");
		model.addAttribute("userTesterTemp", commonService.getTempStatusHistory(member, sh));
		model.addAttribute("testRejectExist", commonService.isThereTestReject(rno));
		
		// 품질 검토 담당자 확인 여부 변경(확인)	
		if(request.getUttCheck()==1 && member.getMtype().equals("usertester") && requestProcess.getUserTester().equals(member.getMid())) {
			commonService.check("usertester", request.getRno());
		}
		// 신규 내역 알림 갱신
		session.setAttribute("newAlertList", commonService.getNewAlertList(member));
				
		return "srm/userTester";
	}

	/**
	 * 배포 상세페이지 조회
	 * @author 			송영훈
	 * @param rno 		조회할 SR번호
	 * @param sesssion  현재 로그인 사용자 정보 얻기
	 * @param model     View에서 사용할 데이터 바인딩 
	 * @return  		배포 상세 jsp
	 */
	@GetMapping("/distributedetail")
	public String distributeDetail(int rno, HttpSession session, Model model) {
		log.info("요청번호" + rno);
		// Validation(내 담당건 맞는지)
		// 요청정보
		Request request = commonService.getRequest(rno);
		model.addAttribute("request", request);
		// 요청 처리정보
		RequestProcess requestProcess = commonService.getRequestProcess(rno);
		model.addAttribute("requestProcess", requestProcess);
		// 배포 완료 내역
		model.addAttribute("distributorToPmHistories", commonService.getDistributorToPmHistories(rno));
		// 임시저장 정보
		StatusHistory sh = new StatusHistory();
		sh.setRno(rno);
		sh.setNextStatus(18);
		Member member = (Member) session.getAttribute("member");
		model.addAttribute("distributorTemp", commonService.getTempStatusHistory(member, sh));
		model.addAttribute("testRejectExist", commonService.isThereTestReject(rno));
		
		// 배포 담당자 확인 여부 변경(확인)	
		if(request.getDisCheck()==1 && member.getMtype().equals("distributor") && requestProcess.getDistributor().equals(member.getMid())) {
			commonService.check("distributor", request.getRno());
		}
		// 신규 내역 알림 갱신
		session.setAttribute("newAlertList", commonService.getNewAlertList(member));
		
		return "srm/distributor";
	}

	/**
	 * 품질검토/배포 시작
	 * @author 						송영훈
	 * @param statusHistory 		업무 시작할 SR번호와 다음 진행상태 값 
	 * @param sesssion  			현재 로그인 사용자 정보 얻기
	 * @param model     			View에서 사용할 데이터 바인딩 
	 * @return  					배포자 : 배포상세 jsp / 품질검토자 : 품질겅토상세 jsp
	 */
	@PostMapping("/startwork")
	public String startWork(StatusHistory statusHistory,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date expectDate, HttpSession session, Model model) {
		log.info("실행");
		Member me = (Member) session.getAttribute("member");
		statusHistory.setWriter(me.getMid());
		if (me.getMtype().equals("usertester")) {
			statusHistory.setNextStatus(8);
			commonService.startWork(statusHistory, expectDate, me.getMtype());
			return "redirect:/usertestdetail?rno=" + statusHistory.getRno();
		} else {
			statusHistory.setNextStatus(10);
			commonService.startWork(statusHistory, expectDate, me.getMtype());
			return "redirect:/distributedetail?rno=" + statusHistory.getRno();
		}
	}

	/**
	 * 품질검토/배포 완료
	 * @author 						송영훈
	 * @param statusHistory 		업무 완료할 SR번호와 다음 진행상태 값 
	 * @param files					업무 완료 시 첨부한 파일 데이터 
	 * @param sesssion  			현재 로그인 사용자 정보 얻기
	 * @param model     			View에서 사용할 데이터 바인딩 
	 * @return  					배포자 : 배포상세 jsp / 품질검토자 : 품질겅토상세 jsp
	 */
	@PostMapping("/endwork")
	public String endWork(StatusHistory statusHistory, HttpSession session, MultipartFile[] files) {
		log.info("실행");
		Member me = (Member) session.getAttribute("member");
		statusHistory.setWriter(me.getMid());
		List<StatusHistoryFile> sFiles = new ArrayList<>();
		try {
			if (files != null) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						StatusHistoryFile statusHistoryFile = new StatusHistoryFile();
						statusHistoryFile.setFileName(file.getOriginalFilename());
						statusHistoryFile.setFileType(file.getContentType());
						statusHistoryFile.setFileData(file.getBytes());
						sFiles.add(statusHistoryFile);
					}
				}

			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		statusHistory.setFileList(sFiles);
		if (me.getMtype().equals("usertester")) {
			statusHistory.setNextStatus(9);
			commonService.endWork(statusHistory, me);
			
			// 서비스 변경 여부(배포자 미확인  상태 변경)
			commonService.notCheck("distributor", statusHistory.getRno());
			
			return "redirect:/usertestdetail?rno=" + statusHistory.getRno();
		} else {
			statusHistory.setNextStatus(11);
			commonService.endWork(statusHistory, me);
			
			// 서비스 변경 여부(PM 미확인  상태 변경)
			commonService.notCheck("pm", statusHistory.getRno());
			
			
			return "redirect:/distributedetail?rno=" + statusHistory.getRno();
		}
	}

}
