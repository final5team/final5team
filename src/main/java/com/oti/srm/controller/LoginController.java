package com.oti.srm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.oti.srm.dto.Member;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class LoginController {
	/*로그인*/
	@GetMapping("/login")
	public String loginForm() {
		log.info("실행");
		return "member/loginform";
	}
	
   /*@PostMapping("/login")
   public String login(Member member, Model model, HttpSession session) {
      log.info("실행");
      //패스워드 암호화 ( 암호화된걸 복호화는 못함. 비교만 가능)
      //모두 bcrypt 일 경우 
      //new BCrypt~~~~ 를 생성해서 그냥 넣어주면 된다.
      
      MemberService.LoginResult loginResult = memberService.login(member);
      if(loginResult == MemberService.LoginResult.WRONG_ID) {
    	  //mid가 없다.
    	  model.addAttribute("member", member);
    	  model.addAttribute("result", "wrongMid");
    	  return "member/loginForm";
      } else if(loginResult == MemberService.LoginResult.WRONG_PASSWORD){
		  model.addAttribute("member", member);
		  model.addAttribute("result","wrongMpassword");
		  return "member/loginForm";
      }else {
    	  session.setAttribute("loginMember", member);
    	  return "redirect:/";
      }
   }*/
 
	/*로그아웃*/
@GetMapping("/logout")
   public String logout(HttpSession session) {
	   session.removeAttribute("loginMember");
	   return "redirect:/";
   }
	
}
