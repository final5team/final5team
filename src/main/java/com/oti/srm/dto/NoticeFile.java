package com.oti.srm.dto;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeFile {
	private int fno;
	private Date savedDate;
	private String fileName;
	private String fileType;
	private byte[] fileData;
	private int nno;
}
