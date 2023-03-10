package com.oti.srm.service.srm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
import com.oti.srm.dao.srm.IPMDao;
import com.oti.srm.dto.Member;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.Status;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;
import com.oti.srm.dto.WorkingInfo;

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
	@Transactional
	public List<Member> getStaffBySno(int sno, String mtype) {
		// 태스크별 목록 구하기
		List<Member> staffList = pMDao.selectStaffBySno(sno, mtype);
		// 현재 담당 건수 구하기
		for (Member staff : staffList) {
			List<Status> statusList = commonDao.selectMyWorkStatus(staff);
			HashMap<String, Integer> map = new HashMap<>();
			map.put("대기", 0);
			map.put("진행중", 0);
			for (Status status : statusList) {
				if (staff.getMtype().equals("developer")) {
					if (status.getStatusNo() < 4) {
						map.put("대기", map.get("대기") + status.getCount());
					}
					else if (status.getStatusNo() == 4) {
						map.put("진행중", map.get("진행중") + status.getCount());
					}
				}
				else if (staff.getMtype().equals("tester")) {
					if (status.getStatusNo() < 6) {
						map.put("대기", map.get("대기") + status.getCount());
					}
					else if (status.getStatusNo() == 6) {
						map.put("진행중", map.get("진행중") + status.getCount());
					}
				}
				else if (staff.getMtype().equals("usertester")) {
					if (status.getStatusNo() < 8) {
						map.put("대기", map.get("대기") + status.getCount());
					}
					else if (status.getStatusNo() == 8) {
						map.put("진행중", map.get("진행중") + status.getCount());
					}
				}
				else if (staff.getMtype().equals("distributor")) {
					if (status.getStatusNo() < 10) {
						map.put("대기", map.get("대기") + status.getCount());
					}
					else if (status.getStatusNo() == 10) {
						map.put("진행중", map.get("진행중") + status.getCount());
					}
				}
			}
			staff.setQuota(map);
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
			List<StatusHistoryFile> fileList = statusHistory.getFileList();
			if (fileList != null) {
				for (StatusHistoryFile file : fileList) {
					file.setHno(statusHistory.getHno());
					commonDao.insertStatusHistoryFile(file);
				}
			}
			// 서비스 요청 처리 프로세스
			// 접수 완료
			if (statusHistory.getNextStatus() == 2) {
				// 서비스 처리 내역 생성
				int result = pMDao.insertRequestProcess(requestProcess);
				// 서비스 변경 여부(개발자 미확인 상태 변경)
				result = commonDao.updateNotCheck("developer", statusHistory.getRno());
				return (result == 1) ? 1 : 0;
				// 반려 처리
			} else if (statusHistory.getNextStatus() == 12) {
				// 서비스 변경 여부(사용자 미확인 상태 변경)
				return commonDao.updateNotCheck("user", statusHistory.getRno());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	@Transactional
	public StatusHistory getStatusHistory(int rno, String string) {
		StatusHistory reject = null;
		// 전체 요청 처리 내역
		List<StatusHistory> histories = commonDao.selectRequestHistories(rno);
		// 처리 내역 확인
		for (StatusHistory sh : histories) {
			if (sh.getNextStatus() == 12) {
				sh.setFileList(commonDao.selectStatusHistoryFiles(sh.getHno()));
				reject = sh;
				break;
			}
		}
		return reject;
	}

	@Override
	public List<WorkingInfo> getWorkingInfo(Member member) {
		return pMDao.selectWorkingInfo(member);
		
	}

}
