package com.oti.srm.dto;

import java.util.Date;

import lombok.Data;
@Data
public class ListFilter{
	private String reqType;
	private String dateFirst;
	private String dateLast;
	private int sno;
	private int statusNo;
	// 업무 목록 조회를 요청한 유저의 타입
	private String mtype;
	// 시스템 이름
	private String systemName;
	
	
	private String dateValue;
	private String statusValue;
	
	
	//날짜 변환
	private Date date_first;
	private Date date_last;
	
	//pageNo 저장
	private int pageNo;
	
}
