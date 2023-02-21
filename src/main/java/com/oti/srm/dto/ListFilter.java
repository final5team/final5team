package com.oti.srm.dto;

import java.util.Date;

import lombok.Data;
@Data
public class ListFilter {
	private String req_type;
	private Date date_first;
	private Date date_last;
	private int sno;
	
}
