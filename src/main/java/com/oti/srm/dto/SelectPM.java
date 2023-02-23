package com.oti.srm.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

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
	
//	request_Process 항목
	private String reqType;
	private String developer;
	private String tester;
	private String pm;
	private String userTester;
	private String distributor;
	
	

}
