package com.oti.srm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class NoticeController {
	// 공지사항 목록
	@GetMapping("/noticelist")
	public String noticeList() {
		return "younghun/noticeList";
	}

	// 공지사항 상세
	@GetMapping("/noticedetail")
	public String noticeDetail() {
		return "younghun/noticeDetail";
	}

	// 공지사항 작성 폼
	@GetMapping("/noticewriteform")
	public String noticeWriteForm() {
		return "younghun/noticeWriteForm";
	}

	// 공지사항 작성
	@PostMapping("/noticewrite")
	public String noticeWrite() {
		return "redirect:/noticeList";
	}

	// 공지사항 수정 폼
	@GetMapping("/noticeupdateform")
	public String noticeUpdateForm() {
		return "younghun/noticeUpdateForm";
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
