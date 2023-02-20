package com.oti.srm.dao.srm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.srm.dto.Request;
import com.oti.srm.dto.SelectPM;

@Mapper
public interface IRequestDao {
	//요청 작성 : 모든 유저
	public int insertRequest(Request request);
	public List<Request> getRequestList();
	public int getPresentStep(int rno);
	
	//PM 조회
	public int countPm();
	public List<SelectPM> selectAll(Request request);
	
	
	
}
