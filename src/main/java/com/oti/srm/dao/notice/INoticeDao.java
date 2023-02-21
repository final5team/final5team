package com.oti.srm.dao.notice;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.srm.dto.Notice;
import com.oti.srm.dto.NoticeFile;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.System;

@Mapper
// 공지사항 관련 dao 메소드
public interface INoticeDao {
	public List<Notice> selectNoticeList(@Param("searchType") String searchType, @Param("searchWord") String searchWord, @Param("mtype") String mtype, @Param("sno") int sno, @Param("pager") Pager pager);
	
	public int selectNoticeListCount(@Param("searchType") String searchType, @Param("searchWord") String searchWord, @Param("mtype") String mtype, @Param("sno") int sno);
	
	public Notice selectNotice(int nno);
	
	public int insertNotice(Notice notice);
	
	public void updateNotice(Notice notice);
	
	public void deleteNotice(int nno);
	
	public void deleteNoticeFiles(int nno);
	
	public List<NoticeFile> selectNoticeFiles(int nno);
	
	public int insertNoticeFile(NoticeFile noticeFile);
	
	public void deleteNoticeFile(int fno);

	public List<System> selectSystemList();
	
	public NoticeFile selectNoticeFile(int fno);
	
}
