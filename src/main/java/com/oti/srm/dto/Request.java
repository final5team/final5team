package com.oti.srm.dto;

import java.util.Date;

import lombok.Data;
@Data
public class Request {
	private int rno;
	private int sno;
	private Date reqDate;
	private String reqTitle;
	private String reqContent;
	private int statusNo;
	private String client;
	private Date reqExpectDate;
	
}
