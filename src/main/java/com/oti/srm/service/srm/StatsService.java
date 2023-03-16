package com.oti.srm.service.srm;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
import com.oti.srm.dao.srm.IStatsDao;
import com.oti.srm.dto.Status;

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

	// 서비스 요청 처리 현황 구하기
	@Override
	@Transactional
	public List<Integer> getSRState() {
		// 값 저장할 List 객체 생성하기
		List<Integer> list = new ArrayList<>();
		// 태스크별 담당한 전체 요청 건수 저장하기
		// pm 접수 단계 요청 건수 구하기
		list.add(statsDao.selectRequestRecentPM());
		// 그외 담당자 태스크별 담당 요청 건수 구하기
		for (int i = 1; i < 5; i++) {
			list.add(statsDao.selectAllReqTask(i) - statsDao.selectComReqTask(i));
		}
		// 완료 대기 + 완료 요청 건수 구하기
		list.add(statsDao.selectComReq(0) + statsDao.selectComReqD());
		// 비율 계산을 위한 전체 분모값 구하기
		list.add(list.stream().mapToInt(Integer::intValue).sum());
		return list;
	}

	// 서비스 요청 완료율 구하기
	@Override
	public int getComRate(int sno) {
		// 해당하는 전체 서비스 건수 구하기
		int all = statsDao.selectAllReq(sno);
		// 해당 전체 서비스 건수가 0일 경우(분모가 0일 경우)
		if (all == 0) {
			// 0 반환하기
			return 0;
		}
		// 서비스 요청 완료율 구하기(완료된 서비스 건 / 전체 서비스 건)
		// 월별 필터 적용하면 selectSRChange 메소드 재활용해도 될 듯
		return 100 * statsDao.selectComReq(sno) / all;
	}

	// 서비스 요청 지연율 구하기
	@Override
	public int getDelRate(int sno) {
		// 해당 완료 서비스 건수 구하기
		int com = statsDao.selectComReq(sno);
		// 해당 완료 서비스 건수가 0일 경우(분모가 0일 경우)
		if (com == 0) {
			// 0 반환하기
			return 0;
		}
		// 서비스 요청 지연율 반환하기(지연된 서비스 건 / 완료된 서비스 건)
		return 100 * statsDao.selectDelReq(sno) / com;
	}

	// 태스크별 서비스 요청 지연율 구하기
	@Override
	@Transactional
	public Map<String, Integer> getDelRateTask() {
		// 값 저장할 Map 객체 생성하기
		Map<String, Integer> del = new HashMap<>();
		// 태스크별 서비스 요청 지연율 저장하기
		for (int i = 1; i < 5; i++) {
			String mtype = (i == 1) ? "developer" : (i == 2) ? "tester" : (i == 3) ? "usertester" : "distributor";
			del.put(mtype, 100 * statsDao.selectDelReqTask(i) / statsDao.selectComReqTask(i));
		}
		return del;
	}

	// 태스크별 서비스 요청 완료율 구하기
	@Override
	@Transactional
	public Map<String, Integer> getComRateTask() {
		// 값 저장할 Map 객체 생성하기
		Map<String, Integer> com = new HashMap<>();
		// 태스크별 서비스 요청 완료울 저장하기
		for (int i = 1; i < 5; i++) {
			String mtype = (i == 1) ? "developer" : (i == 2) ? "tester" : (i == 3) ? "usertester" : "distributor";
			com.put(mtype, 100 * statsDao.selectComReqTask(i) / statsDao.selectAllReqTask(i));
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
		for (int j = 1; j < 5; j++) {
			// 태스크 별 요청 값 저장할 ArrayList 객체 생성하기
			ArrayList<Integer> arr = new ArrayList<>();
			// 전체 서비스 요청 건수
			arr.add(statsDao.selectAllReqTask(j) - statsDao.selectComReqTask(j));
			// 진행 중 서비스 요청 건수
			arr.add(statsDao.selectOnReqTask(j));
			// 완료 서비스 요청 건수
			arr.add(statsDao.selectComReqTask(j));

			list.add(arr);
		}
		return list;
	}

	// 서비스 요청 추이 그래프 값 구하기
	@Override
	@Transactional
	public List<ArrayList<Integer>> getSRChange(String year, int month) {
		// 값 저장할 List 객체 생성하기
		List<ArrayList<Integer>> change = new ArrayList<>();
		// 시스템별 요청 추이 값 저장하기
		for (int j = 1; j < 5; j++) {
			// 값 저장할 ArrayList 객체 생성하기
			ArrayList<Integer> list = new ArrayList<>();

			// 월별 서비스 요청 추이 값 저장하기
			for (int i = month; i < month + 3; i++) {
				// 해당 연도와 월 구하기
				DecimalFormat df = new DecimalFormat("00");
				String result = year + df.format(i);
				/*
				 * // 월별 서비스 요청 건수 구하기 if(req == 0) { change.put(String.valueOf(i),
				 * statsDao.selectSRChange(result)); //월별 서비스 완료 건수 구하기 } else if(req == 1) {
				 * change.put(String.valueOf(i), statsDao.selectSRComChange(result)); }
				 */
				list.add(statsDao.selectSRChange(result, j));
			}
			change.add(list);
		}
		return change;
	}

	// 단계별 서비스 요청 처리 현황
	@Override
	public Map<String, Integer> getStageCount() {
		// 값 저장할 Map 객체 생성하기
		Map<String, Integer> map = new HashMap<String, Integer>();
		// 단게별 값 저장하기
		map.put("접수", 0);
		map.put("개발", 0);
		map.put("테스트", 0);
		map.put("품질검토", 0);
		map.put("배포", 0);
		map.put("완료", 0);
		map.put("전체", 0);
		// 단계별 서비스 요청 처리 현황 구하기
		List<Status> statList = statsDao.selectStageCount();
		for (Status stat : statList) {
			map.put("전체", map.get("전체") + stat.getCount());
			if (stat.getStatusNo() == 1) {
				map.put("접수", map.get("접수") + stat.getCount());
			}
			if (stat.getStatusNo() == 2 || stat.getStatusNo() == 3 || stat.getStatusNo() == 4) {
				map.put("개발", map.get("개발") + stat.getCount());
			}
			if (stat.getStatusNo() == 5 || stat.getStatusNo() == 6) {
				map.put("테스트", map.get("테스트") + stat.getCount());
			}
			if ((stat.getStatusNo() == 7 && stat.getReqType().equals("정규")) || stat.getStatusNo() == 8) {
				map.put("품질검토", map.get("품질검토") + stat.getCount());
			}
			if ((stat.getStatusNo() == 7 && stat.getReqType().equals("긴급")) || stat.getStatusNo() == 9
					|| stat.getStatusNo() == 10) {
				map.put("배포", map.get("배포") + stat.getCount());
			}
			if (stat.getStatusNo() == 11 || stat.getStatusNo() == 12 || stat.getStatusNo() == 13) {
				map.put("완료", map.get("완료") + stat.getCount());
			}
		}
		return map;
	}

	
	// 태스크별 서비스 요청 처리 현황
	@Override
	public Map<String, Integer> getTaskCount() {
		// 값 저장할 Map 객체 생성하기
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("개발대기", 0);
		map.put("개발중", 0);
		map.put("개발완료", 0);
		map.put("테스트대기", 0);
		map.put("테스트중", 0);
		map.put("테스트완료", 0);
		map.put("품질검토대기", 0);
		map.put("품질검토중", 0);
		map.put("품질검토완료", 0);
		map.put("배포대기", 0);
		map.put("배포중", 0);
		map.put("배포완료", 0);
		// 태스크별 업무 현황에 따른 서비스 요청 처리 현황 구하기
		List<Status> statList = statsDao.selectStageCount();
		for (Status stat : statList) {
			if (stat.getStatusNo() == 2 || stat.getStatusNo() == 3) {
				map.put("개발대기", map.get("개발대기") + stat.getCount());
			}
			if (stat.getStatusNo() == 4) {
				map.put("개발중", map.get("개발중") + stat.getCount());
			}
			if (stat.getStatusNo() >= 5 && stat.getStatusNo() != 12) {
				map.put("개발완료", map.get("개발완료") + stat.getCount());
			}
			if (stat.getStatusNo() == 5 ) {
				map.put("테스트대기", map.get("테스트대기") + stat.getCount());
			}
			if (stat.getStatusNo() == 6) {
				map.put("테스트중", map.get("테스트중") + stat.getCount());
			}
			if (stat.getStatusNo() >= 7 && stat.getStatusNo() != 12) {
				map.put("테스트완료", map.get("테스트완료") + stat.getCount());
			}
			if (stat.getStatusNo() == 7 && stat.getReqType().equals("정규")) {
				map.put("품질검토대기", map.get("품질검토대기") + stat.getCount());
			}
			if (stat.getStatusNo() == 8) {
				map.put("품질검토중", map.get("품질검토중") + stat.getCount());
			}
			if (stat.getStatusNo() >= 9 && stat.getStatusNo() != 12) {
				map.put("품질검토완료", map.get("품질검토완료") + stat.getCount());
			}
			if (stat.getStatusNo() == 9 || (stat.getStatusNo() == 7 && stat.getReqType().equals("긴급"))) {
				map.put("배포대기", map.get("배포대기") + stat.getCount());
			}
			if (stat.getStatusNo() == 10) {
				map.put("배포중", map.get("배포중") + stat.getCount());
			}
			if (stat.getStatusNo() >= 11 || stat.getStatusNo() == 13) {
				map.put("배포완료", map.get("배포완료") + stat.getCount());
			}
		}
		return map;
	}

}
