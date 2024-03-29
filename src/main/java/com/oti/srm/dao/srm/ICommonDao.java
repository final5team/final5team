package com.oti.srm.dao.srm;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.RequestProcessMname;
import com.oti.srm.dto.Status;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;

@Mapper
// 단계 상세 페이지 단계 처리 관련 dao 메소드 
public interface ICommonDao {

	// 단계 이력 조회
	public StatusHistory selectStatusHistory(int hno);
	
	// 요청의 단계 이력(status_histories 테이블) 모두 조회
	public List<StatusHistory> selectRequestHistories(int rno);

	// 단계 이력에 첨부된 파일(status_histories_files) 조회
	public List<StatusHistoryFile> selectStatusHistoryFiles(int hno);

	// 요청정보(requests 테이블) 조회
	public Request selectRequest(int rno);
	
	// 요청 첨부 파일 조회
	public List<StatusHistoryFile> selectRequestFiles(int rno);
	
	// 요청처리정보(request_process 테이블) 조회
	public RequestProcess selectRequestProcess(int rno);
	
	// 요청 담당자들 이름 조회
	public RequestProcessMname selectRequestProcessMname(int rno);
		
	// 완료 예정일 기입
    public int updateExpectDate(@Param("rno") int rno, @Param("expectDate") Date expectDate, @Param("mtype") String mtype);
    
    // 완료일 기입
    public int updateCompDate(@Param("rno") int rno, @Param("mtype") String mtype);
    
    // 개발 재검토 처리 시 개발완료일자 null로 변경
    public int updateResetDate(int rno);
    
	// 단계 변경 이력 추가(status_histories 테이블)
	public int insertStatusHistory(StatusHistory statusHistory);
	
	// 단계 변경 이력 수정(status_histories 테이블)
	public int updateStatusHistory(StatusHistory statusHistory);
		
	// 요청의 현재 단계 최신화
	public void updateRequestStatus(@Param("rno") int rno, @Param("statusNo") int statusNo);
	
	// 단계 변경 이력에 파일 추가(status_histories_files 테이블)
	public int insertStatusHistoryFile(StatusHistoryFile statusHistoryFile);
	
	// 담당 업무 진행상황별 갯수(pm,developer,tester,usertester,distributor)
	public List<Status> selectMyWorkStatus(Member member);
	
	// 내 요청 진행상황별 갯수(user)
	public List<Status> selectMyRequestStatus(Member member);
	
	//7일 남은 리스트 출력
	public int selectListOf7daysLeftCount(Member member);
	
	//7일 남은 리스트 출력
	public List<Request> selectListOf7daysLeft(@Param("member") Member member, @Param("dPager")Pager dPager);
	
	//내 담당 모든 요청 개수 구하기
	public int selectAllMyRequests(Member member);
	
	//내 담당 요청건 중, 지연되었던 요청 개수 가져오기
	public int selectDelayRequests(Member member);
	
	//파일 다운로드
	public StatusHistoryFile selectFile(int fno);
	
	//PM의 최신 요청건 개수 알기
	public int selectRequestRecentPM();
	
	// 반려건 수 
	public int selectRequestReject();
	
	//직무별 요청리스트 출력
	public List<RequestProcess> selectRequestProcessList(@Param("member")Member member,@Param("checkbox") String checkbox, @Param("status") String status, @Param("pager") Pager pager);
	
	//직무별 요청리스트 행의 수 출력
	public int selectRequestProcessRows(@Param("member")Member member,@Param("checkbox") String checkbox, @Param("status") String status);

	//사용자 요청 리스트 행 가져오기
	public int selectUserRequestListCount(@Param("searchStatus") String searchStatus,@Param("member")  Member member);
	
	//사용자 요청 리스트 가져오기
	public List<Request> selectUserRequestList(@Param("searchStatus") String searchStatus, @Param("member") Member member, @Param("uPager") Pager uPager);

	//임시저장 객체 가져오기
	public StatusHistory selectTempStatusHistory(@Param("member") Member member, @Param("statusHistory") StatusHistory statusHistory);
	
	//개발자의 진척률 갱신하기
	public void updateDevProgress(RequestProcess rp);
	
	// 요청 처리 정보 수정
	public void updateRequestProcess(RequestProcess rp);
	
	// 단계 처리 이력 수정
	public void updateRealStatusHistory(StatusHistory sh);
	
	//pm의 requestProcess 리스트 가져오기
	public List<RequestProcess> selectPmRequestProcessList(@Param("status") String status, @Param("pager") Pager rpPager);
	
	//pm의 requestProcess 행 가져오기
	public int selectPmRequestProcessRows(@Param("status") String status);

	// 서비스 변경 사항 확인 여부 변경(확인)
	public int updateCheck(@Param("mtype")String mtype, @Param("rno")int rno);
	
	// 서비스 변경 사항 확인 여부 변경(미확인)
	public int updateNotCheck(@Param("mtype")String mtype, @Param("rno")int rno);
	
	// 서비스 변경 알림
	public List<Request> selectNewAlertList(Member member);
	
	// 단계 변경 이력 삭제 
	public int deleteStatusHistory(int hno);
	
	// 단계 변경 이력 파일 삭제 
	public int deleteStautsHistoryFiles(int hno);
	
	//완료일 null 로 업데이트
	public int updateCompDateNull(@Param("member") Member member, @Param("rp") RequestProcess rp);
}
