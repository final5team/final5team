package com.oti.srm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.srm.dao.IUserRegisterDao;
import com.oti.srm.dto.Member;
import com.oti.srm.service.IUserRegisterService;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class UserRegisterServiceImpl implements IUserRegisterService {

	@Autowired
	private IUserRegisterDao registerDao;
	
	@Override
	public int register(Member member) {
		log.info("가입 실행");
		try {
			int rows = registerDao.register(member);
			return REGISTER_SUCCESS;
		} catch(Exception e) {
			log.error(e.toString());
			return REGISTER_FAIL;
		}
	}
	
	
	
	
	
	

}
