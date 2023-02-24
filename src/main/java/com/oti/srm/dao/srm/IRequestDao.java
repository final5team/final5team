package com.oti.srm.dao.srm;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.srm.dto.ListFilter;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.SelectPM;
import com.oti.srm.dto.StatusHistoryFile;

@Mapper
public interface IRequestDao {
	//요청 작성 : 모든 유저
	public int insertRequest(Request request);
	public List<Request> getRequestList();
	public int getPresentStep(int rno);
	
	//작성한 요청글의 rno 조회
	public int selectRequest(String client);
	
	//내 업무 리스트 조회
	public int countRows(HashMap<String, Object> map);
	public List<SelectPM> selectMyWorkList(HashMap<String, Object> map);
	
	//내 요청 리스트 조회
	public int countRequestRows(HashMap<String, Object> map);
	public List<SelectPM> selectMyRequest(HashMap<String, Object> map);
	
	//내 요청 상세보기
	public Request selectRequestDetail(int rno);
	public List<StatusHistoryFile> setRequestFiles(int rno);
	public StatusHistoryFile selectRequestFile(int fno);
	
	
	
}
