package com.oti.srm.service.notice;

import java.util.List;

import com.oti.srm.dto.Notice;
import com.oti.srm.dto.NoticeFile;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.System;

public interface INoticeService {
	public List<Notice> getNoticeList(String searchType, String searchWord, String mtype, Pager pager);
	
	public int getNoticeListCount(String searchType, String searchWord, String mtype);
	
	public Notice getNotice(int nno);

	public List<System> getSystemList();
	
	public void noticeWrite(Notice notice);

	public void deleteNotice(int nno);

	public NoticeFile downloadNoticeFile(int fno);

	
	public void noticeUpdate(Notice notice);

	public void deleteNoticeFile(int fno);

	public List<NoticeFile> getNoticeFileList(int nno);
}
