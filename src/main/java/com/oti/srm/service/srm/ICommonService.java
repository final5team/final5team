package com.oti.srm.service.srm;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;

public interface ICommonService {
	// 개발자 -> 테스터 단계 변경 이력 조회
	public List<StatusHistory> getDevToTesterHistories(int rno);

	// 요청정보 조회
	public Request getRequest(int rno);

	// 요청처리정보 조회
	public RequestProcess getRequestProcess(int rno);

	public void startWork(StatusHistory statusHistory, Date expectDate, String mtype);

	public void endWork(StatusHistory statusHistory, String mtype);
	
	public void reWork(StatusHistory statusHistory, String mtype);
	
	public List<StatusHistory> getTesterToDevHistories(int rno);
	
	public List<StatusHistory> getUserTesterToDistributorHistories(int rno);
	
	public List<StatusHistory> getDistributorToPmHistories(int rno);
	
	public List<StatusHistory> getPmToAllHistories(int rno);

	public void uploadFile(StatusHistoryFile statusHistoryFile);

	public Date getReceiptDoneDate(int rno);
	
	//업무 현황 출력
	public HashMap<String,Integer> getWorkingStatus(Member member);
	
	//D-7남은 요청 출력
	public List<Request> getListOf7daysLeft(Member member);

	//업무 진행율
	public Map<String, Object> getWorkCompletionRate(Member member);
	//파일 다운로드
	public StatusHistoryFile getFile(int fno);


}
