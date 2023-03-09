package com.oti.srm.dto;

import java.util.Date;

import lombok.Data;

@Data
public class WorkingInfo {
	private int rno;
	private Date startDate;
	private Date endExpectDate;
}
