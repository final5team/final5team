package com.oti.srm.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
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

		PasswordEncoder pe = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		Member returnMember = memberDao.getMember(member);
		if(returnMember == null) {
			member.setPassConfirm("T");
			return member;
		}
		boolean checkPass = pe.matches(member.getPassword(), returnMember.getPassword());
		if (checkPass == false) {
			member.setPassConfirm("N");
			return member;
		} else {
			return returnMember;
		}

	}
	
	@Override
	public Member getNoPasswordMember(Member member) {
        return memberDao.getMember(member);
	}
	

	// 유저 아이디 중복 확인
	@Override
	public int checkId(String mid) {

		return memberDao.selectMid(mid);
	}

}
