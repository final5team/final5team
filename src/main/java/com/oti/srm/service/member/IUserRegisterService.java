package com.oti.srm.service.member;

import java.util.List;

import com.oti.srm.dto.Member;

public interface IUserRegisterService {
	public enum RegisterResult {
		SUCCESS, FAIL;
	}

	public static final int REGISTER_SUCCESS = 1;
	public static final int REGISTER_FAIL = 0;
	
	// 유저 등록
	public int register(Member member);
	// 시스템 리스트 조회
	public List<System> getSystemList();
	// 유저 정보 조회
	public Member getUserInfo(String mid);
	// 유저 정보 수정
	public int updateUserInfo(Member member);
	// 비밀번호 확인
	public boolean passwordConfirm(String password, Member member);
	
}
