package com.oti.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.oti.srm.dto.Notice;
import com.oti.srm.dto.NoticeFile;
import com.oti.srm.dto.Pager;

public interface INoticeDao {
	public List<Notice> getNoticeList(@Param("userType") String userType, @Param("searchWord") String searchWord, @Param("pager") Pager pager);
	
	public int getNoticeListCount(@Param("userType") String userType, @Param("searchWord") String searchWord);
	
	public Notice getNotice(int nno);
	
	public int insertNotice(Notice notice);
	
	public void updateNotice(Notice notice);
	
	public void deleteNotice(int nno);
	
	public void deleteNoticeFiles(int nno);
	
	public List<NoticeFile> getNoticeFiles(int nno);
	
	public int insertNoticeFile(NoticeFile noticeFile);
	
	public void deleteNoticeFile(int fno);
	
}
