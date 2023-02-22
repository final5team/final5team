package com.oti.srm.service.srm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
import com.oti.srm.dao.srm.IPMDao;
import com.oti.srm.dto.Member;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;

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
	public int receipt(StatusHistory statusHistory, RequestProcess requestProcess) {
		try {
			// 서비스 요청->접수 완료
			commonDao.updateRequestStatus(statusHistory.getRno(), statusHistory.getNextStatus());	
			// 접수 완료 이력 작성
			commonDao.insertStatusHistory(statusHistory);
			// 첨부 파일 등록
			List<StatusHistoryFile> fileList =statusHistory.getFileList();
			if(fileList !=null) {
				for(StatusHistoryFile file: fileList) {
					file.setHno(statusHistory.getHno());
					commonDao.insertStatusHistoryFile(file);
				}
			}			
			// 서비스 요청 처리 프로세스
			// 접수 완료
			if(statusHistory.getNextStatus()==2) {
				int result=pMDao.insertRequestProcess(requestProcess);
				return (result==1)?1:0;	
			//반려 처리	
			} else if(statusHistory.getNextStatus()==12){
				return 1;
			}			
		} catch(Exception e) {
			e.printStackTrace();			
		}
		return 0;		
	}

	@Override
	public StatusHistory getStatusHistory(int rno, String string) {
		// 전체 요청 처리 내역
		commonDao.selectRequestHistories(rno);
		// 해당 태스크별 처리 내역		
		
		return null;
	}

}
