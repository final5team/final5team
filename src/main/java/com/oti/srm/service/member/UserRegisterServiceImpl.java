package com.oti.srm.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.srm.dao.member.IUserRegisterDao;
import com.oti.srm.dto.Member;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class UserRegisterServiceImpl implements IUserRegisterService {

	@Autowired
	private IUserRegisterDao registerDao;

	@Override
	public int register(Member member) {
		log.info("가입 실행");
		int rows = registerDao.register(member);
		return REGISTER_SUCCESS;
	}

	@Override
	public int registerWithFile(Member member) {
		int rows = registerDao.registerWithFile(member);
		return REGISTER_SUCCESS;
	}

	
	
	
}
