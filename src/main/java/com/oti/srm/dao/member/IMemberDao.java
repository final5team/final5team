package com.oti.srm.dao.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.srm.dto.Member;

@Mapper
public interface IMemberDao {
	public Member getMember(Member member);
	public int insertMember(Member member);
	public List<System> selectSystem();
	
	
	
	
}
