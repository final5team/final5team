package com.oti.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.ToString;

@Data
public class SelectPM {
//	member 항목
	private String mtype; 
	
// request 항목
	private int rno;
	private int sno;
	private String systemName;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date reqDate;
	private String reqTitle;
	private String reqContent;
	private int statusNo;
	private String statusName;
	private String client;
	private String clientName;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date reqExpectDate;
	private String organ;
	
	// 서비스 변경 여부 (신규 알림) 확인
	private int pmCheck;
	private int devCheck;
	private int tesCheck;
	private int uttCheck;
	private int disCheck;
	private int usrCheck;
	
//	request_Process 항목
	private String reqType;
	private String developer;
	private String tester;
	private String pm;
	private String userTester;
	private String distributor;
	private int devProgress;
	
	

}
