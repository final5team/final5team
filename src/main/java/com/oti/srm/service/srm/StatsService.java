package com.oti.srm.service.srm;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
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
	@Autowired
	ICommonDao commonDao;
	
	//서비스 요청 처리 현황 구하기
	@Override
	@Transactional
	public List<Integer> getSRState() {
		// 값 저장할 List 객체 생성하기
		List<Integer> list = new ArrayList<>();		
		// 태스크별 담당한 전체 요청 건수 저장하기
		// pm 접수 단계 요청 건수 구하기
		list.add(statsDao.selectRequestRecentPM());
		// 그외 담당자 태스크별 담당 요청 건수 구하기
		for(int i=1; i<5; i++) {
			list.add(statsDao.selectAllReqTask(i)-statsDao.selectComReqTask(i));
		}
		// 완료 대기 + 완료 요청 건수 구하기
		list.add(statsDao.selectComReqTask(4)+commonDao.selectRequestReject());              ////statsDao.selectComReq());
		// 비율 계산을 위한 전체 분모값 구하기
		list.add(list.stream().mapToInt(Integer::intValue).sum());
		return list;		
	}
	
	// 서비스 요청 완료율 구하기
	@Override
	public int getComRate() {
		// 서비스 요청 완료율 구하기
		// 월별 필터 적용하면 selectSRChange 메소드 재활용해도 될 듯
		return 100* statsDao.selectComReq() / statsDao.selectAllReq();
	}
	// 전체 서비스 요청 지연율 구하기
	@Override
	public int getDelRate() {
		// 전체 서비스 요청 지연율 구하기
		return 100* statsDao.selectDelReq() / statsDao.selectComReq();
	}
	// 태스크별 서비스 요청 지연율 구하기
	@Override
	@Transactional
	public Map<String, Integer> getDelRateTask() {		
		// 값 저장할 Map 객체 생성하기
		Map<String, Integer> del = new HashMap<>();
		// 태스크별 서비스 요청 지연율 저장하기
		for(int i=1; i<5; i++) {
			String mtype= (i==1)?"developer":(i==2)?"tester":(i==3)?"usertester":"distributor";
			del.put(mtype, 100*statsDao.selectDelReqTask(i) / statsDao.selectComReqTask(i));
		}
		return del;
	}
	// 태스크별 서비스 요청 완료율 구하기
	@Override
	@Transactional
	public Map<String, Integer> getComRateTask() {
		// 값 저장할 Map 객체 생성하기
		Map<String, Integer>com = new HashMap<>();
		// 태스크별 서비스 요청 완료울 저장하기
		for(int i=1; i<5; i++) {
			String mtype= (i==1)?"developer":(i==2)?"tester":(i==3)?"usertester":"distributor";
			com.put(mtype, 100*statsDao.selectComReqTask(i) / statsDao.selectAllReqTask(i));
		}
		return com;
	}	
	// 시스템별 요청 비중 구하기
	@Override
	public List<System> getSystemSlice() {
		// 시스템별 요청 비중 구하기
		return statsDao.selectSystemSlice();
	}
	// 태스크별 서비스 요청 처리 현황 구하기
	@Override
	public List<ArrayList<Integer>> getSRStateTask() {
		// 전체 값 저장할 List 객체 생성하기
		List<ArrayList<Integer>> list = new ArrayList<>();		
		for(int j=1; j<5; j++) {
			// 태스크 별 요청 값 저장할 ArrayList 객체 생성하기
			ArrayList<Integer> arr = new ArrayList<>();
			// 전체 서비스 요청 건수
			arr.add(statsDao.selectAllReqTask(j)-statsDao.selectComReqTask(j));			
			// 진행 중 서비스 요청 건수
			arr.add(statsDao.selectOnReqTask(j));
			// 완료 서비스 요청 건수
			arr.add(statsDao.selectComReqTask(j));
			
			list.add(arr);
		}		
		return list;
	}
	// 시스템 이름 구하기
	@Override
	public List<String> getSystemName() {	
		// 시스템 이름 리스트 반환하기
		return statsDao.selectSystemName();
	}
	
	//서비스 요청 추이 그래프 값 구하기
	@Override
	@Transactional
	public List<ArrayList<Integer>> getSRChange() {
		// 값 저장할 List 객체 생성하기
		List<ArrayList<Integer>> change = new ArrayList<>();
		// 현재 연도 구하기
		int year = Calendar.getInstance().get(Calendar.YEAR);
		// 시스템별 요청 추이 값 저장하기
		for(int j=1; j<5; j++) {
			// 값 저장할 ArrayList 객체 생성하기
			ArrayList<Integer> list = new ArrayList<>();
				
			// 월별 서비스 요청 추이 값 저장하기
			for(int i=1; i<13; i++) {
				// 현재 연도와 월 구하기
				DecimalFormat df= new DecimalFormat("00");
				String result=year+df.format(i);
				/*
				// 월별 서비스 요청 건수 구하기
				if(req == 0) {
					change.put(String.valueOf(i), statsDao.selectSRChange(result));
				//월별 서비스 완료 건수 구하기
				} else if(req == 1) {
					change.put(String.valueOf(i), statsDao.selectSRComChange(result));
				}
				*/	
				list.add(statsDao.selectSRChange(result, j));
			}
			change.add(list);
		}
		return change;
	}


}
