package com.oti.srm.service.srm;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.srm.dao.srm.IStatsDao;

import lombok.extern.log4j.Log4j2;

/**
 * @author KIM JI YOUNG
 *
 */
//통계 관련 서비스 구현 
@Log4j2
@Service
public class StatsService implements IStatsService {
	@Autowired
	IStatsDao statsDao;
	
	//서비스 요청 처리 현황 구하기
	@Override
	public void getSRState(String string) {
		//statsDao
		
	}
	//서비스 요청 추이 그래프 값 구하기
	@Override
	public Map<String, Integer> getSRChange(int req) {
		// 값 저장할 Map 객체 생성
		Map<String, Integer> change = new HashMap<>();
		// 현재 연도 구하기
		int year = Calendar.getInstance().get(Calendar.YEAR);
		for(int i=1; i<13; i++) {
			// 현재 연도와 월 구하기
			DecimalFormat df= new DecimalFormat("00");
			String result=year+df.format(i);
			// 월별 서비스 요청 건수 구하기
			if(req == 0) {
				change.put(String.valueOf(i), statsDao.selectSRChange(result));
			//월별 서비스 완료 건수 구하기
			} else if(req == 1) {
				change.put(String.valueOf(i), statsDao.selectSRComChange(result));
			}		
		}		
		return change;
	}
	@Override
	public int getComRate() {
		// 서비스 요청 완료율 구하기
		// 월별 필터 적용하면 selectSRChange 메소드 재활용해도 될 듯
		return 100* statsDao.selectComRate() / statsDao.selectAllRate();
	}
	@Override
	public int getDelRate() {
		// 서비스 요청 지연율 구하기
		return 100* statsDao.selectDelRate() / statsDao.selectComRate();
	}



}
