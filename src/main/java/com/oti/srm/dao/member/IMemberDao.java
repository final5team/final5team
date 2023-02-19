package com.oti.srm.dao.member;

import org.apache.ibatis.annotations.Mapper;

import com.oti.srm.dto.Member;

@Mapper
public interface IMemberDao {
	Member getMember(Member member);
}
