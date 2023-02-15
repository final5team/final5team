package com.oti.srm.service;

import java.util.List;

import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;

public interface IDistributeService {
	// 개발자 -> 테스터 단계 변경 이력 조회
	public List<StatusHistory> getDevToTesterHistories(int rno);

	// 요청정보 조회
	public Request getRequest(int rno);

	// 요청처리정보 조회
	public RequestProcess getRequestProcess(int rno);
}
