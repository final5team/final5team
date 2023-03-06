package com.oti.srm.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.oti.srm.dto.Member;
import com.oti.srm.service.member.IMemberService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class LoginController {
	
	@Autowired
	IMemberService memberService;
	/* 로그인 */
	@GetMapping("/login")
	public String loginForm() {
		log.info("실행");
		return "member/loginform";
	}

	@PostMapping("/login")
	public String login(Member member, Model model, HttpSession session) {
		log.info("실행"); // 패스워드 암호화 ( 암호화된걸 복호화는 못함. 비교만 가능)
		
		Member dbMember = memberService.getMember(member);
		
		
		if(dbMember == null) {
			model.addAttribute("member", member);
			model.addAttribute("loginResult", "잘못된 아이디입니다.");
			return "member/loginform";
		} else {
			//암호화 처리 로직
			if(dbMember.getPassConfirm() == "N") {
				model.addAttribute("member", member);
				model.addAttribute("loginResult", "잘못된 비밀번호입니다.");
				return "member/loginform";
			}
			
			//기존 로직
//			if(!dbMember.getPassword().equals(member.getPassword())) {
//				model.addAttribute("member", member);
//				model.addAttribute("loginResult", "잘못된 비밀번호입니다.");
//				return "member/loginform";
//			}
			
		}
		
		session.setAttribute("member", dbMember);
		String mtype = dbMember.getMtype();

		if(mtype.equals("user")) {
			return "redirect:" + "/userhome";
		} else if(mtype.equals("pm")) {
			return "redirect:" + "/pmhome";
		} else {
			return "redirect:" + "/";
		}
		
	}

	/* 로그아웃 */
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("member");
		return "redirect:/login";
	}

}
