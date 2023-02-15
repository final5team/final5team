package com.oti.srm.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class Request {
	private int rno;
	private int sno;
	private String systemName;
	private Date reqDate;
	private String reqTitle;
	private String reqContent;
	private int statusNo;
	private String statusName;
	private String client;
	private String clientName;
	private Date reqExpectDate;
	private List<StatusHistoryFile> files;
	
}
