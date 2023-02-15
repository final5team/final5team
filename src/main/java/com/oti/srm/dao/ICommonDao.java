package com.oti.srm.dao;

import java.util.List;

import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;

public interface ICommonDao {
	// 요청의 단계 이력 모두 조회
	public List<StatusHistory> getRequestHistories(int rno);

	// 단계 이력에 첨부된 파일 조회
	public List<StatusHistoryFile> getStatusHistoryFiles(int hno);

	// 요청정보 조회
	public Request getRequest(int rno);
	
	// 요청 첨부 파일 조회
	public List<StatusHistoryFile> getRequestFiles(int rno);
	
	// 요청처리정보 조회
	public RequestProcess getRequestProcess(int rno);
}
