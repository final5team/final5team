package com.oti.srm.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.srm.dao.member.IMemberDao;
import com.oti.srm.dto.Member;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class UserRegisterServiceImpl implements IUserRegisterService {

	@Autowired
	private IMemberDao registerDao;

	@Override
	public int register(Member member) {
		log.info("가입 실행");
		int rows = registerDao.insertMember(member);
		log.info(rows);
		return rows;
	}


	
	
	
}
