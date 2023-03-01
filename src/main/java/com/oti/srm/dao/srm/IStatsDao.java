package com.oti.srm.dao.srm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.srm.dto.Member;

/**
 * @author KIM JI YOUNG
 *
 */

// 통계 관련 dao 메소드 
@Mapper
public interface IStatsDao {
	//
	
	// 시스템 별 서비스 요청 비중 구하기
	public List<System> selectSystemSlice();
	
	// 전체 서비스 요청 건수 구하기
	public int selectAllReq();
	// 전체 완료 건수 구하기
	public int selectComReq();	
	// 전체 지연 건수 구하기
	public int selectDelReq();
	// 태스크별 지연 건수 구하기
	public int selectDelReqTask(int mtype);
	// 태스크 별 완료 건수 구하기
	public int selectComReqTask(int mtype);
	// 태스크 별 전체 담당 건수 구하기
	public int selectAllReqTask(int mtype);
	// 태스크별 진행 중 건수 구하기
	public int selectOnReqTask(int mtype);
	// 접수 건수 구하기
	public int selectRequestRecentPM();
	
	// 서비스 요청 추이 월별 요청 건수 구하기
	public int selectSRChange(String month);
	// 서비스 요청 추이 월별 완료 건수 구하기
	int selectSRComChange(String month);

	
	
	

	
	

}
