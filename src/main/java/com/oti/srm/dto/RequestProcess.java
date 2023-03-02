package com.oti.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
@Data
public class RequestProcess {
	private int rno;
	private String reqType;
	private String priority;
	
	private Date devExpectDate;
	private Date testExpectDate;
	private Date distExpectDate;
	private Date userTestExpectDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date allExpectDate;
	private String allExpectDateStr;
	
	private Date devCompDate;
	private Date testCompDate;
	private Date distCompDate;
	private Date userTestCompDate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date allCompDate;
	
	private String developer;
	private String tester;
	private String pm;
	private String userTester;
	private String distributor;
	private int devProgress;
	
	private Date reqDate;
	private String reqTitle;
	private String mname;
	private String statusName;
}
