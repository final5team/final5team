package com.oti.srm.service.srm;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class CommonService implements ICommonService {
	@Autowired
	ICommonDao commonDao;

	 /*
	   <이 메소드는 본인 맡은 업무에 맞게 서비스 메소드 따로 만들어야 함>
	   1. commonDao.getRequestHistories(rno) 통해 모든 단계 변경 이력을 긁어온 다음
	   2. 본인이 조회해야할 단계 변경 이력만 필터링 
	 */
	// 개발완료 시 단계 변경 이력 가져오기
	@Override
	@Transactional
	public List<StatusHistory> getDevToTesterHistories(int rno) {
		List<StatusHistory> requestHistories = commonDao.getRequestHistories(rno);

		List<StatusHistory> devToTesterHistories = new ArrayList<StatusHistory>();

		for (StatusHistory sh : requestHistories) {
			// 개발자 -> 테스터 단계 이력만 담기
			if (sh.getNextStatus() == 5) {
				sh.setFileList(commonDao.getStatusHistoryFiles(sh.getHno()));
				devToTesterHistories.add(sh);
			}
		}

		return devToTesterHistories;
	}
	
	// 요청정보 조회(+해당 요청에 첨부된 파일들까지)
	@Override
	@Transactional
	public Request getRequest(int rno) {
		Request request = commonDao.getRequest(rno);
		request.setFiles(commonDao.getRequestFiles(rno));
		return request;
	}

	// 요청 처리 정보 조회
	@Override
	public RequestProcess getRequestProcess(int rno) {
		RequestProcess requestProcess = commonDao.getRequestProcess(rno);
		log.info(requestProcess);
		return requestProcess;
	}

	// 작업 시작
	/* 
	   1. requests 테이블 => 현재 단계 갱신
	   2. request_process 테이블 => 완료 예정일(expect_date) 기입  
	   3. status_histories 테이블 => 단계 변경 이력 추가
	*/
	@Override
	@Transactional
	public void startWork(StatusHistory statusHistory, Date expectDate, String mtype) {
		commonDao.updateRequestStatus(statusHistory.getRno(), statusHistory.getNextStatus());
		commonDao.updateExpectDate(statusHistory.getRno(), expectDate, mtype);
		commonDao.insertStatusHistory(statusHistory);
	}

	
	// 작업 완료 or 재검토
	/* 
	   1. requests 테이블 => 현재 단계 갱신
	   2. request_process 테이블 => 완료일(comp_date) 기입  
	   3. status_histories 테이블 => 단계 변경 이력 추가
	*/
	@Override
	@Transactional
	public void endWork(StatusHistory statusHistory, String mtype) {
		commonDao.updateRequestStatus(statusHistory.getRno(), statusHistory.getNextStatus());
		commonDao.updateCompDate(statusHistory.getRno(), mtype);
		commonDao.insertStatusHistory(statusHistory);
	}

	
//	(테스터 -> 개발자) 재검토 요청에 대한 단계 변경 이력
	@Override
	@Transactional
	public List<StatusHistory> getTesterToDevHistories(int rno) {
		List<StatusHistory> allHistories = commonDao.getRequestHistories(rno);
		List<StatusHistory> testerToDevHistories = new ArrayList<>();
		for(StatusHistory tester: allHistories) {
			if(tester.getNextStatus() == 3 ) {
				tester.setFileList(commonDao.getStatusHistoryFiles(tester.getHno()));
				testerToDevHistories.add(tester);
			}
		}
		
		return testerToDevHistories;
	}
	
}
