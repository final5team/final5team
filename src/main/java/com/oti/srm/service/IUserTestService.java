package com.oti.srm.service;

import java.util.List;
import java.util.Map;

import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;

public interface IUserTestService {
	// 개발자 -> 테스터 + 테스터 -> 개발자
	public  Map<String, List<StatusHistory>> getDevAndTesterHistories(int rno);
	
	// 요청정보 조회 
	public Request getRequest(int rno);
	
	// 요청처리정보 조회 
	public RequestProcess getRequestProcess(int rno);
	
	
}
