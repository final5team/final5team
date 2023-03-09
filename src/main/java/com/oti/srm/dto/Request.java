package com.oti.srm.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(exclude= {"files","fileList"})
public class Request implements Serializable{
	private int rno;
	private int sno;
	private String priority;
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
	private Date allExpectDate;
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
	
	//파일을 가져오기 위한 status_histories hno 값
	private int hno;
	
	//요청자 정보
	private String rname; 
	private String rphone; 
	private String rposition; 
	private String rorgan; 
	private String remail;
	
	// 서비스 변경 여부(신규 알림) 확인
	private int usrCheck;
	private int pmCheck;
	private int devCheck;
	private int tesCheck;
	private int uttCheck;
	private int disCheck;	
	
}
