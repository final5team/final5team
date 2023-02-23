package com.oti.srm.dao.srm;

import org.apache.ibatis.annotations.Mapper;

/**
 * @author KIM JI YOUNG
 *
 */

// 통계 관련 dao 메소드 
@Mapper
public interface IStatsDao {
	//
	
	// 전체 완료 건수 구하기
	int selectAllReq();
	// 전체 완료 건수 구하기
	int selectComReq();	
	// 전체 지연 건수 구하기
	int selectDelReq();
	// 태스크별 지연 건수 구하기
	int selectDelReqTask(int mtype);
	// 태스크 별 완료 건수 구하기
	int selectComReqTask(int mtype);
	// 태스크 별 전체 담당 건수 구하기
	int selectAllReqTask(int mtype);
	
	// 서비스 요청 추이 월별 요청 건수 구하기
	int selectSRChange(String month);
	// 서비스 요청 추이 월별 완료 건수 구하기
	int selectSRComChange(String month);
	

	
	

}
