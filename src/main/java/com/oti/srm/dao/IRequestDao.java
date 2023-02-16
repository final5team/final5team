package com.oti.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.oti.srm.dto.Request;

@Mapper
public interface IRequestDao {
	public int request(Request request);
	public List<Request> getRequestList();
	public int getPresentStep(int rno);
	
	
	
}
