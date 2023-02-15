package com.oti.srm.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class StatusHistory {
	private int hno;
	private int rno;
	private int nextStatus;
	private String statusName;
	private Date changeDate;
	private String reply;
	private String distSource;
	private List<StatusHistoryFile> fileList;
}
