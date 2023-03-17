package com.oti.srm.service.srm;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author KIM JI YOUNG
 *
 */
// 통계 관련 서비스 메소드
public interface IStatsService {	
	// 시스템 비중 구하기
	public List<System> getSystemSlice();
	// 전체 서비스 요청 완료율 구하기
	public int getComRate(int sno);
	// 전체 서비스 요청 지연율 구하기
	public int getDelRate(int sno);
	// 태스크 별 요청 완료율 구하기
	public Map<String, Integer> getComRateTask();
	// 태스크 별 요청 지연율 구하기
	public Map<String, Integer> getDelRateTask();
	
	// 서비스 요청 처리 현황 구하기
	public List<Integer> getSRState();
	// 태스크별 서비스 요청 처리 현황 구하기
	public List<ArrayList<Integer>> getSRStateTask();
	// 단계별 서비스 요청 처리 현황 구하기
	public Map<String, Integer> getStageCount();
	// 태스크별 업무 현황에 따른 서비스 요청 처리 현황 구하기
	public Map<String, Integer> getTaskCount();
	
	// 서비스 요청 추이 값 구하기
	public List<ArrayList<Integer>> getSRChange(String year, int month);
	
	

}
