package com.oti.srm.service.srm;

import java.util.Map;

/**
 * @author KIM JI YOUNG
 *
 */
// 통계 관련 서비스 메소드
public interface IStatsService {
	// SR 처리 현황 구하기
	public void getSRState(String string);
	// 
	
	// 서비스 요청 추이 값 구하기
	public Map<String, Integer> getSRChange(int req);
	// 서비스 요청 완료율 구하기
	public int getComRate();
	// 서비스 요청 지연율 구하기
	public int getDelRate();


}
