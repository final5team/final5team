package com.oti.srm.dao;

import org.apache.ibatis.annotations.Mapper;

import com.oti.srm.dto.Request;

@Mapper
public interface IRequestDao {
	public int request(Request request);
	
}
