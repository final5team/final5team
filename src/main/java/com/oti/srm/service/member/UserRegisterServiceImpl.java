package com.oti.srm.service.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.srm.dao.member.IMemberDao;
import com.oti.srm.dto.ListFilter;
import com.oti.srm.dto.Member;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class UserRegisterServiceImpl implements IUserRegisterService {

	@Autowired
	private IMemberDao memberDao;

	// 유저 등록
	@Override
	public int register(Member member) {
		int rows = memberDao.insertMember(member);
		return rows;
	}

	// 시스템 리스트 조회
	@Override
	public List<System> getSystemList() {
		return memberDao.selectSystem();
	}

	// 유저 정보 조회
	@Override
	public Member getUserInfo(String mid) {
		return memberDao.selectMemberInfo(mid);
	}
}
