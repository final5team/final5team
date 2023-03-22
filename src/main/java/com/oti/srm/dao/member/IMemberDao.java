package com.oti.srm.dao.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.srm.dto.Member;

@Mapper
public interface IMemberDao {
	// 작성자 : 강지성
	public Member getMember(Member member);
	//유저 등록
	public int insertMember(Member member);
	//시스템 조회
	public List<System> selectSystem();
	//유저 정보 조회
	public Member selectMemberInfo(String mid);
	//유저 정보 수정
	public int updateUserInfo(Member member);
	//아이디 중복 확인
	public int selectMid(String mid);
	
	
	
	
	
}
