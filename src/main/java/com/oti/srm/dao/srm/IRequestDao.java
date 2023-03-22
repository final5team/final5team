package com.oti.srm.dao.srm;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.SelectPM;
import com.oti.srm.dto.StatusHistoryFile;
import com.oti.srm.dto.StatusNoFilter;

@Mapper
public interface IRequestDao {
	// 작성자 : 강지성	
	// 요청 작성 : 모든 유저
	public int insertRequest(Request request);
	// 요청 수정 
	public int updateRequest(Request request);
	// status History Hno 찾기
	public int selectStatusHistory(int rno);
	
	public List<Request> getRequestList();
	public int getPresentStep(int rno);
	
	//작성한 요청글의 rno 조회
	public int selectRequest(String client);
	
	//내 업무 리스트 조회
	public int countRows(HashMap<String, Object> map);
	public List<SelectPM> selectMyWorkList(HashMap<String, Object> map);
	
	//사용자 요청 리스트 개수 조회
	public int countRequestRows(HashMap<String, Object> map);
	//사용자의 요청 리스트 조회
	public List<SelectPM> selectMyRequest(HashMap<String, Object> map);
	//업무 담당자의 요청 리스트 개수 조회
	public int countWorkerRequestRows(HashMap<String, Object> map);
	//업무 담당자의 요청 리스트 조회
	public List<SelectPM> selectWorkerRequest(HashMap<String, Object> map);
	
	//내 요청 상세보기
	public Request selectRequestDetail(int rno);
	public List<StatusHistoryFile> setRequestFiles(int rno);
	public List<StatusHistoryFile> selectRequestFile(int fno);
	public StatusHistoryFile selectFile(int fno);
	// ---------------------------------------------------------------------------------------------------
	
	// 메인에서 업무현황 클릭 후 담당목록 조회
	public int selectMainToWorkerListRows(@Param("statusNoFilter") List<Integer> statusNoFilter, @Param("member") Member member);
	public List<SelectPM> selectMainToWorkerList(@Param("statusNoFilter") List<Integer>  statusNoFilter, @Param("member") Member member, @Param("pager") Pager pager);
	
	// 요청 취소
	public int deleteRequest(int rno);
	public int deleteStatusHistories(int rno);
	public int deleteStatusHistoryFiles(int rno);
	
	
}
