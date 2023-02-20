package com.oti.srm.service.srm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
import com.oti.srm.dao.srm.IPMDao;
import com.oti.srm.dto.Member;
import com.oti.srm.dto.StatusHistory;

import lombok.extern.log4j.Log4j2;

/**
 * @author KIM JI YOUNG
 *
 */
@Log4j2
@Service
public class PMService implements IPMService {
	@Autowired
	IPMDao pMDao;
	@Autowired
	ICommonDao commonDao;
	
	@Override
	public List<Member> getStaffBySno(int sno, String mtype) {
		// 태스크별 목록 구하기
		List<Member> staffList = pMDao.selectStaffBySno(sno, mtype);
		// 현재 담당 건수 구하기
		for(Member staff:staffList) {
			staff.setQuota(pMDao.selectQuota(staff.getMid(),staff.getMtype()));
		}
		return staffList;
	}

	@Override
	@Transactional
	public void receipt(StatusHistory statusHistory) {
		//접수 완료
		statusHistory.setNextStatus(2);
		commonDao.updateRequestStatus(statusHistory.getRno(), statusHistory.getNextStatus());		
		commonDao.insertStatusHistory(statusHistory);
		//commonDao.insertStatusHistoryFile(StatusHistoryFile statusHistoryFile);

		
		
	}
	
}
