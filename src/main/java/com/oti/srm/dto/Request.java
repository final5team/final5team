package com.oti.srm.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Request {
	private int rno;
	private int sno;
	private String systemName;
	@DateTimeFormat(pattern = "yyyy-mm-dd")
	private Date reqDate;
	private String reqTitle;
	private String reqContent;
	private int statusNo;
	private String statusName;
	private String client;
	private String clientName;
	@DateTimeFormat(pattern = "yyyy-mm-dd")
	private Date reqExpectDate;
	private List<StatusHistoryFile> files;
	private String organ;

	// 검색 필요 정보
	private String mid;
	private String mtype;
	private int startRowNo;
	private int endRowNo;

	// 리스트 필더 값
	private String reqType;
	private String dateFirst;
	private String dateLast;

	// 리스트 날짜 상태 저장
	private String dateValue;
	// zero 둘 다 없음
	// first 시작일 없음
	// last 종료일 없음
	// both 날짜 둘 다 있음
}
