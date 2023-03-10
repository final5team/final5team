package com.oti.srm.controller.notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		Member member = (Member) session.getAttribute("member");
		if (!searchWord.equals("")) {
			searchWord = "%" + searchWord + "%";
		}
		int count = noticeService.getNoticeListCount(searchType, searchWord, member.getMtype());
		Pager pager = new Pager(10, 5, count, pageNo);
		List<Notice> noticeList = noticeService.getNoticeList(searchType, searchWord, member.getMtype(), pager);
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
	public String noticeWriteForm(Model model, HttpSession session) {
		// validation : 공지사항 작성은 pm만 가능하다
		Member member = (Member) session.getAttribute("member");
		if(!member.getMtype().equals("pm")) {
			return "redirect:/noticelist";
		}
		model.addAttribute("systemList", noticeService.getSystemList());
		return "notice/noticeWriteForm";
	}

	// 공지사항 작성
	@PostMapping("/noticewrite")
	public String noticeWrite(Notice notice, MultipartFile[] files, Model model, HttpSession session) {
		log.info("실행");
		if (notice.getUserShow() == null) {
			notice.setUserShow("N");
		}
		if (notice.getDevShow() == null) {
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
	public String noticeUpdateForm(int nno, Model model) {
		model.addAttribute("notice", noticeService.getNotice(nno));
		model.addAttribute("systemList", noticeService.getSystemList());
		return "notice/noticeUpdateForm";
	}

	// 공지사항 수정
	@PostMapping("/noticeupdate")
	public String noticeUpdate(Notice notice, MultipartFile[] files) {
		log.info("실행");
		if (notice.getUserShow() == null) {
			notice.setUserShow("N");
		}
		if (notice.getDevShow() == null) {
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
		noticeService.noticeUpdate(notice);
		return "redirect:/noticedetail?nno=" + notice.getNno();
	}

	// 공지사항 삭제
	@GetMapping("/noticedelete")
	public String noticeDelete(int nno) {
		noticeService.deleteNotice(nno);
		return "redirect:/noticelist";
	}
	
	// 공지사항 단일 파일 삭제 
	@PostMapping("/noticefiledelete")
	@ResponseBody
	public Map<String, String> noticeFileDelete(int fno, Model model,
			@RequestParam(defaultValue = "0") int distinguish) {
		noticeService.deleteNoticeFile(fno, distinguish);
		Map<String,String> map = new HashMap<>();
		map.put("result", "파일 삭제 완료");
		return map;
	}
	// 공지사항 다운로드
	@GetMapping("/noticefiledownload")
	public  ResponseEntity<byte[]> noticeFileDownload(int fno) throws Exception{
		NoticeFile noticeFile = noticeService.downloadNoticeFile(fno);
		final HttpHeaders headers = new HttpHeaders();
		String[] mtypes = noticeFile.getFileType().split("/");
		headers.setContentType(new MediaType(mtypes[0], mtypes[1]));
		headers.setContentDispositionFormData("attachment",new String(noticeFile.getFileName().getBytes("UTF-8"), "ISO-8859-1"));
		return new ResponseEntity<byte[]>(noticeFile.getFileData(), headers, HttpStatus.OK);
	}
	
	@GetMapping("/new")
	public String getCalendar() {
		return "notice/new";
	}
	
}
