package com.oti.srm.service.member;

import java.util.Map;

import com.oti.srm.dto.Member;

public interface IMemberService {
	Member getMember(Member member);
	public Member getNoPasswordMember(Member member);
	int checkId(String mid);
}
