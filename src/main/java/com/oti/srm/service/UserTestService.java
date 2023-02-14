package com.oti.srm.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.IUserTestDao;
import com.oti.srm.dto.StatusHistory;

@Service
public class UserTestService implements IUserTestService{
	@Autowired
	IUserTestDao userTestDao;
	
	@Override
	@Transactional
	public StatusHistory getRecentDevHistory(int rno) {
		// 개발 -> 테스트 최신 단계 변경 이력
		StatusHistory statusHistory= userTestDao.getRecentDevHistory(rno);
		// 개발 -> 테스트 최신 첨부 파일
		statusHistory.setFileList(userTestDao.getStatusHistoryFiles(statusHistory.getHno()));
		return statusHistory;
	}

}
