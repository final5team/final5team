package com.oti.srm.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;

public interface ICommonDao {
	// 요청의 단계 이력(status_histories 테이블) 모두 조회
	public List<StatusHistory> getRequestHistories(int rno);

	// 단계 이력에 첨부된 파일(status_histories_files) 조회
	public List<StatusHistoryFile> getStatusHistoryFiles(int hno);

	// 요청정보(requests 테이블) 조회
	public Request getRequest(int rno);
	
	// 요청 첨부 파일 조회
	public List<StatusHistoryFile> getRequestFiles(int rno);
	
	// 요청처리정보(request_process 테이블) 조회
	public RequestProcess getRequestProcess(int rno);
	
	// -------------------미구현 DAO--------------------------
	// 개발/테스트/유저테스트/배포/전체 완료 예정일 입력
	// expectDate = 입력한 예정일, type = 개발/테스트/유저테스트/배포/전체 중 어떤 예정일인지
    public int updateExpectDate(@Param("rno") int rno, @Param("expectDate") Date expectDate, @Param("type") String type);
    
	// 단계 변경 이력 추가(status_histories 테이블)
	public int insertStatusHistory(@Param("rno") int rno, @Param("statusHistory") StatusHistory statusHistory);
	
	// 요청의 현재 단계 최신화
	public void updateRequestStatus(@Param("rno") int rno, @Param("statusNo") int statusNo);
	
	// 단계 변경 이력에 파일 추가(status_histories_files 테이블)
	public int insertStatusHistoryFile(@Param("hno") int hno, @Param("statusHistoryFile")  StatusHistoryFile statusHistoryFile);
	
}
