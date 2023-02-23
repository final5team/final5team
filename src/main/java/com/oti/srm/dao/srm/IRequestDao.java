package com.oti.srm.dao.srm;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.srm.dto.ListFilter;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.SelectPM;

@Mapper
public interface IRequestDao {
	//요청 작성 : 모든 유저
	public int insertRequest(Request request);
	public List<Request> getRequestList();
	public int getPresentStep(int rno);
	
	//작성한 요청글의 rno 조회
	public int selectRequest(String client);
	
	//PM 조회
	public int countRows(HashMap<String, Object> map);
	/*public List<SelectPM> selectPmRequestList(@Param("request") Request request, @Param("listFilter")ListFilter listFilter, @Param("pager")Pager pager);*/
	
	public List<SelectPM> selectPmRequestList(HashMap<String, Object> map);
	//담당자 조회
	public int countWorkerList(int workerSno);
	
	

	
	
}
