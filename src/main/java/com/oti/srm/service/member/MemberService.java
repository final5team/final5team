package com.oti.srm.service.member;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.srm.dao.member.IMemberDao;
import com.oti.srm.dto.Member;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class MemberService implements IMemberService {
	
	@Autowired
	IMemberDao memberDao;

	@Override
	public Member getMember(Member member) {
		return memberDao.getMember(member);
	}

}
