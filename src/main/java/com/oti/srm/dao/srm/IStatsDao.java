package com.oti.srm.dao.srm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.RequestProcess;

/**
 * @author KIM JI YOUNG
 *
 */

// 통계 관련 dao 메소드 
@Mapper
public interface IStatsDao {
	//
	// 서비스 요청 추이 월별 요청 건수 구하기
	int selectSRChange(String month);
	// 서비스 요청 추이 월별 완료 건수 구하기
	int selectSRComChange(String month);
	
}
