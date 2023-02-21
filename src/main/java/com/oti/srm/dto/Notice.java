package com.oti.srm.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class Notice {
	private int nno;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeDate;
	private String mid;
	private int sno;
	private String systemName;
	private String userShow;
	private String devShow;
	private String testerShow;
	private String distributorShow;
	private String userTesterShow;
	private List<NoticeFile> fileList;
	
}
