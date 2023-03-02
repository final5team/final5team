package com.oti.srm.service.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.notice.INoticeDao;
import com.oti.srm.dto.Notice;
import com.oti.srm.dto.NoticeFile;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.System;

import lombok.extern.log4j.Log4j2;
@Log4j2
@Service
public class NoticeService implements INoticeService {
	@Autowired
	INoticeDao noticeDao;

	@Override
	public List<Notice> getNoticeList(String searchType, String searchWord, String mtype, Pager pager) {
		return noticeDao.selectNoticeList(searchType, searchWord, mtype, pager);
	}

	@Override
	public int getNoticeListCount(String searchType, String searchWord, String mtype) {
		return noticeDao.selectNoticeListCount(searchType, searchWord, mtype);
	}

	@Override
	@Transactional
	public Notice getNotice(int nno) {
		Notice notice = noticeDao.selectNotice(nno);
		notice.setFileList(noticeDao.selectNoticeFiles(nno));
		return notice;
	}

	@Override
	public List<System> getSystemList() {
		return noticeDao.selectSystemList();
	}

	@Override
	@Transactional
	public void noticeWrite(Notice notice) {
		int rows = noticeDao.insertNotice(notice);
		log.info(rows);
		log.info(notice.getFileList().size());
		for(NoticeFile noticeFile : notice.getFileList()) {
			noticeFile.setNno(notice.getNno());
			noticeDao.insertNoticeFile(noticeFile);
		}
	}

	@Override
	@Transactional
	public void deleteNotice(int nno) {
		noticeDao.deleteNoticeFiles(nno);
		noticeDao.deleteNotice(nno);
	}

	@Override
	public NoticeFile downloadNoticeFile(int fno) {
		return noticeDao.selectNoticeFile(fno);
	}

	@Override
	@Transactional
	public void noticeUpdate(Notice notice) {
		noticeDao.updateNotice(notice);
		log.info(notice.getNno());
		for(NoticeFile noticeFile : notice.getFileList()) {
			noticeFile.setNno(notice.getNno());
			noticeDao.insertNoticeFile(noticeFile);
		}
		
	}

	@Override
	public void deleteNoticeFile(int fno) {
		noticeDao.deleteNoticeFile(fno);
	}

	@Override
	public List<NoticeFile> getNoticeFileList(int nno) {
		return noticeDao.selectNoticeFiles(nno);
	}

}
