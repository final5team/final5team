package com.oti.srm.controller.notice;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Notice;
import com.oti.srm.dto.NoticeFile;
import com.oti.srm.dto.Pager;
import com.oti.srm.service.notice.INoticeService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class NoticeController {
	@Autowired
	INoticeService noticeService;

	// 공지사항 목록
	@GetMapping("/noticelist")
	public String noticeList(@RequestParam(defaultValue = "제목") String searchType,
			@RequestParam(defaultValue = "") String searchWord, @RequestParam(defaultValue = "1") int pageNo,
			Model model, HttpSession session) {
		log.info("실행");
		Member member = (Member) session.getAttribute("member");
		if (!searchWord.equals("")) {
			searchWord = "%" + searchWord + "%";
		}
		int count = noticeService.getNoticeListCount(searchType, searchWord, member.getMtype(), member.getSno());
		Pager pager = new Pager(5, 5, count, pageNo);
		List<Notice> noticeList = noticeService.getNoticeList(searchType, searchWord, member.getMtype(), pager,
				member.getSno());
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pager", pager);
		return "notice/noticeList";
	}

	// 공지사항 상세
	@GetMapping("/noticedetail")
	public String noticeDetail(int nno, Model model) {
		log.info("실행");
		model.addAttribute("notice", noticeService.getNotice(nno));
		return "notice/noticeDetail";
	}

	// 공지사항 작성 폼
	@GetMapping("/noticewriteform")
	public String noticeWriteForm(Model model) {
		// validation : 공지사항 작성은 pm만 가능하다
		model.addAttribute("systemList", noticeService.getSystemList());
		return "notice/noticeWriteForm";
	}

	// 공지사항 작성
	@PostMapping("/noticewrite")
	public String noticeWrite(Notice notice, MultipartFile[] files, Model model, HttpSession session) {
		if (notice.getUserShow() == null) {
			notice.setUserShow("N");
		}
		if (notice.getDevShow()== null) {
			notice.setDevShow("N");
		}
		if (notice.getTesterShow() == null) {
			notice.setTesterShow("N");
		}
		if (notice.getUserTesterShow() == null) {
			notice.setUserTesterShow("N");
		}
		if (notice.getDistributorShow() == null) {
			notice.setDistributorShow("N");
		}
		Member member = (Member) session.getAttribute("member");
		notice.setMid(member.getMid());
		List<NoticeFile> fileList = new ArrayList<NoticeFile>();
		try {
			if (files != null) {
				for (MultipartFile file : files) {
					if (!file.isEmpty()) {
						NoticeFile noticeFile = new NoticeFile();
						noticeFile.setFileName(file.getOriginalFilename());
						noticeFile.setFileType(file.getContentType());
						noticeFile.setFileData(file.getBytes());
						fileList.add(noticeFile);
					}
				}
			}
			notice.setFileList(fileList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		noticeService.noticeWrite(notice);
		return "redirect:/noticedetail?nno=" + notice.getNno();
	}

	// 공지사항 수정 폼
	@GetMapping("/noticeupdateform")
	public String noticeUpdateForm() {
		return "notice/noticeUpdateForm";
	}

	// 공지사항 수정
	@GetMapping("/noticeupdate")
	public String noticeUpdate() {
		return "redirect:/noticeList";
	}

	// 공지사항 삭제
	@GetMapping("/noticedelete")
	public String noticeDelete() {
		return "redirect:/noticeList";
	}

}
