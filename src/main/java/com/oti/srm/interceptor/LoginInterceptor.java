package com.oti.srm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import com.oti.srm.dto.Member;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class LoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		try {
			Member member = (Member) request.getSession().getAttribute("member");
			String reqUrl = request.getRequestURL().toString();
			log.info(reqUrl);
			if( member == null || member.equals("") ) {
				response.sendRedirect(request.getContextPath() + "/login");
				return false;
			} 
				
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
}
