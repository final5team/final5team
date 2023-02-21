package com.oti.srm.service.notice;

import java.util.List;

import com.oti.srm.dto.Notice;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.System;

public interface INoticeService {
	public List<Notice> getNoticeList(String searchType, String searchWord, String mtype, Pager pager, int sno);
	
	public int getNoticeListCount(String searchType, String searchWord, String mtype, int sno);
	
	public Notice getNotice(int nno);

	public List<System> getSystemList();
	
	public void noticeWrite(Notice notice);
}
