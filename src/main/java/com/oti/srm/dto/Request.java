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
	private @DateTimeFormat(pattern = "yyyy-MM-dd")Date reqDate;
	private String reqTitle;
	private String reqContent;
	private int statusNo;
	private String statusName;
	private String client;
	private String clientName;
	private @DateTimeFormat(pattern = "yyyy-MM-dd")Date reqExpectDate;
	private List<StatusHistoryFile> files;
	private String organ;

	// d-day 완료일
	private Date ddayExpectDate;
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
	//파일 첨부
	private List<StatusHistoryFile> fileList;
}
