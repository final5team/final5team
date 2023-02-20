package com.oti.srm.service.member;

import com.oti.srm.dto.Member;

public interface IUserRegisterService {
	public enum RegisterResult {
		SUCCESS, FAIL;
	}

	public static final int REGISTER_SUCCESS = 1;
	public static final int REGISTER_FAIL = 0;

	public int register(Member member);
	
}
