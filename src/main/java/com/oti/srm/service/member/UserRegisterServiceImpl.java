package com.oti.srm.service.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.oti.srm.dao.member.IMemberDao;
import com.oti.srm.dto.Member;
import com.oti.srm.encrypt.AesUtil;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class UserRegisterServiceImpl implements IUserRegisterService {

	@Autowired
	private IMemberDao memberDao;

	// 유저 등록
	@Override
	public int register(Member member) {
		
		PasswordEncoder pe = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		member.setPassword(pe.encode(member.getPassword()));
		member.setPhone(AesUtil.encrypt(member.getPhone()));
		
		int rows = memberDao.insertMember(member);
		log.info("서비스");
		
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
		
		Member returnMember = memberDao.selectMemberInfo(mid);
		//핸드폰 번호 복호화 처리
		returnMember.setPhone(AesUtil.decrypt(returnMember.getPhone()));
		log.info(returnMember.getPhone());
		return returnMember;
	}
	
	//유저 정보 수정
	@Override
	public int updateUserInfo(Member member) {
		PasswordEncoder pe = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		//패스워드 암호화 처리
		member.setPassword(pe.encode(member.getPassword()));
		
		//핸드폰 번호 암호화 처리
		String phone = AesUtil.encrypt(member.getPhone());
		member.setPhone(phone);
		
		int rows = memberDao.updateUserInfo(member);
		return rows;
	}
	
}
