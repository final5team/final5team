package com.oti.srm.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.ICommonDao;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;

@Service
public class UserTestService implements IUserTestService {
	@Autowired
	ICommonDao commonDao;

	@Override
	@Transactional
	public List<StatusHistory> getDevToTesterHistories(int rno) {
		// 요청에 딸린 전체 단계 이력 가져오기
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

	@Override
	@Transactional
	public Request getRequest(int rno) {
		Request request = commonDao.getRequest(rno);
		request.setFiles(commonDao.getRequestFiles(rno));
		return request;
	}

	@Override
	public RequestProcess getRequestProcess(int rno) {
		RequestProcess requestProcess = commonDao.getRequestProcess(rno);
		return requestProcess;
	}

	// 작업 시작(고객테스터 / 배포자 공용)
	// => requests테이블(현재단계 최신화 + 완료예정일 기입) + status_histories테이블(단계 변경 이력 추가)
	@Override
	@Transactional
	public void startWork(StatusHistory statusHistory, Date expectDate, String mtype) {
		commonDao.updateExpectDate(statusHistory.getRno(), expectDate, mtype);
		commonDao.updateRequestStatus(statusHistory.getRno(), statusHistory.getNextStatus());
		commonDao.insertStatusHistory(statusHistory);
	}

	// 작업 완료(고객테스터 / 배포자 공용)
	// => requests테이블(현재단계 최신화) + status_histories테이블(단계 변경 이력 추가) 
	// * 파일이 있다면 status_histories_files테이블(단계 변경 이력에 첨부파일 등록)
	@Override
	@Transactional
	public void endWork(StatusHistory statusHistory) {
		commonDao.updateRequestStatus(statusHistory.getRno(), statusHistory.getNextStatus());
		commonDao.insertStatusHistory(statusHistory);
	}

}
