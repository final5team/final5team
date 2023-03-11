package com.oti.srm.service.srm;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
import com.oti.srm.dto.Member;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.Status;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class CommonService implements ICommonService {
	@Autowired
	ICommonDao commonDao;

	/*
	 * <이 메소드는 본인 맡은 업무에 맞게 서비스 메소드 따로 만들어야 함> 1. commonDao.getRequestHistories(rno)
	 * 통해 모든 단계 변경 이력을 긁어온 다음 2. 본인이 조회해야할 단계 변경 이력만 필터링
	 */
	// 개발완료 시 단계 변경 이력 가져오기
	@Override
	@Transactional
	public List<StatusHistory> getDevToTesterHistories(int rno) {
		List<StatusHistory> requestHistories = commonDao.selectRequestHistories(rno);

		List<StatusHistory> devToTesterHistories = new ArrayList<StatusHistory>();

		for (StatusHistory sh : requestHistories) {
			// 개발자 -> 테스터 단계 이력만 담기
			if (sh.getNextStatus() == 5) {
				sh.setFileList(commonDao.selectStatusHistoryFiles(sh.getHno()));
				if (sh.getReply() == null) {
					sh.setReply("내용이 없습니다.");
				}
				if (sh.getDistSource() == null) {
					sh.setDistSource("내용이 없습니다.");
				}

				devToTesterHistories.add(sh);
			}
		}

		return devToTesterHistories;
	}

	@Override
	@Transactional
	public List<StatusHistory> getUserTesterToDistributorHistories(int rno) {
		List<StatusHistory> requestHistories = commonDao.selectRequestHistories(rno);

		List<StatusHistory> UserTesterToDistributorHistories = new ArrayList<StatusHistory>();

		for (StatusHistory sh : requestHistories) {
			// 테스터 -> 배포자 단계 이력만 담기
			if (sh.getNextStatus() == 9) {
				if (sh.getReply() == null) {
					sh.setReply("내용이 없습니다.");
				}
				sh.setFileList(commonDao.selectStatusHistoryFiles(sh.getHno()));
				UserTesterToDistributorHistories.add(sh);
			}
		}

		return UserTesterToDistributorHistories;
	}

	@Override
	public List<StatusHistory> getDistributorToPmHistories(int rno) {
		List<StatusHistory> requestHistories = commonDao.selectRequestHistories(rno);

		List<StatusHistory> distributorToPmHistories = new ArrayList<StatusHistory>();

		for (StatusHistory sh : requestHistories) {
			// 배포자 -> pm 단계 이력만 담기
			if (sh.getNextStatus() == 11) {
				if (sh.getReply() == null) {
					sh.setReply("내용이 없습니다.");
				}
				sh.setFileList(commonDao.selectStatusHistoryFiles(sh.getHno()));
				distributorToPmHistories.add(sh);
			}
		}

		return distributorToPmHistories;
	}

	@Override
	public List<StatusHistory> getPmToAllHistories(int rno) {
		List<StatusHistory> requestHistories = commonDao.selectRequestHistories(rno);

		List<StatusHistory> pmToAllHistories = new ArrayList<StatusHistory>();

		for (StatusHistory sh : requestHistories) {
			// pm -> all 이력만 담기
			if (sh.getNextStatus() == 2) {
				if (sh.getReply() == null) {
					sh.setReply("내용이 없습니다.");
				}
				sh.setFileList(commonDao.selectStatusHistoryFiles(sh.getHno()));
				pmToAllHistories.add(sh);
			}
		}

		return pmToAllHistories;
	}

	// 요청정보 조회(+해당 요청에 첨부된 파일들까지)
	@Override
	@Transactional
	public Request getRequest(int rno) {
		Request request = commonDao.selectRequest(rno);
		request.setFiles(commonDao.selectRequestFiles(rno));
		return request;
	}

	// 요청 처리 정보 조회
	@Override
	public RequestProcess getRequestProcess(int rno) {
		RequestProcess requestProcess = commonDao.selectRequestProcess(rno);
		log.info(requestProcess);
		return requestProcess;
	}

	// 작업 시작
	/*
	 * 1. requests 테이블 => 현재 단계 갱신 2. request_process 테이블 => 완료 예정일(expect_date) 기입
	 * 3. status_histories 테이블 => 단계 변경 이력 추가
	 */
	@Override
	@Transactional
	public void startWork(StatusHistory statusHistory, Date expectDate, String mtype) {
		commonDao.updateRequestStatus(statusHistory.getRno(), statusHistory.getNextStatus());
		commonDao.updateExpectDate(statusHistory.getRno(), expectDate, mtype);
		commonDao.insertStatusHistory(statusHistory);
	}

	// 작업 완료 or 재검토
	/*
	 * 1. requests 테이블 => 현재 단계 갱신 2. request_process 테이블 => 완료일(comp_date) 기입 3.
	 * status_histories 테이블 => 단계 변경 이력 추가
	 */
	@Override
	@Transactional
	public void endWork(StatusHistory statusHistory, String mtype) {
		commonDao.updateRequestStatus(statusHistory.getRno(), statusHistory.getNextStatus());
		commonDao.updateCompDate(statusHistory.getRno(), mtype);
		commonDao.insertStatusHistory(statusHistory);
		if (statusHistory.getFileList() != null && statusHistory.getFileList().size() > 0) {
			for (StatusHistoryFile file : statusHistory.getFileList()) {
				file.setHno(statusHistory.getHno());
				commonDao.insertStatusHistoryFile(file);
			}
		}
		// 각 단계 담당자 업무 완료 시 그 사람의 해당 요청건 임시저장글 null처리
		StatusHistory tempHistoryChange = new StatusHistory();
		tempHistoryChange.setRno(statusHistory.getRno());
		tempHistoryChange.setWriter(statusHistory.getWriter());
		tempHistoryChange.setReply(null);
		tempHistoryChange.setDistSource(null);
		if (mtype.equals("developer")) {
			tempHistoryChange.setNextStatus(14);
			commonDao.updateStatusHistory(tempHistoryChange);
		} else if (mtype.equals("tester")) {
			tempHistoryChange.setNextStatus(15);
			commonDao.updateStatusHistory(tempHistoryChange);
			tempHistoryChange.setNextStatus(16);
			commonDao.updateStatusHistory(tempHistoryChange);
		} else if (mtype.equals("usertester")) {
			tempHistoryChange.setNextStatus(17);
			commonDao.updateStatusHistory(tempHistoryChange);
		} else if (mtype.equals("distributor")) {
			tempHistoryChange.setNextStatus(18);
			commonDao.updateStatusHistory(tempHistoryChange);
		}

	}

	@Override
	@Transactional
	public void reWork(StatusHistory statusHistory, String mtype) {
		commonDao.updateRequestStatus(statusHistory.getRno(), statusHistory.getNextStatus());
		commonDao.updateResetDate(statusHistory.getRno());
		commonDao.insertStatusHistory(statusHistory);
		if (statusHistory.getFileList() != null && statusHistory.getFileList().size() > 0) {
			for (StatusHistoryFile file : statusHistory.getFileList()) {
				file.setHno(statusHistory.getHno());
				commonDao.insertStatusHistoryFile(file);
			}
		}
		// 재검토 시 테스터의 해당 요청건 임시저장글(재검토 임시글/승인 임시글) null처리
		StatusHistory tempHistoryChange = new StatusHistory();
		tempHistoryChange.setRno(statusHistory.getRno());
		tempHistoryChange.setWriter(statusHistory.getWriter());
		tempHistoryChange.setReply(null);
		tempHistoryChange.setDistSource(null);
		tempHistoryChange.setNextStatus(15);
		commonDao.updateStatusHistory(tempHistoryChange);
		tempHistoryChange.setNextStatus(16);
		commonDao.updateStatusHistory(tempHistoryChange);
	}

//	(테스터 -> 개발자) 재검토 요청에 대한 단계 변경 이력
	@Override
	@Transactional
	public List<StatusHistory> getTesterToDevHistories(int rno) {
		List<StatusHistory> allHistories = commonDao.selectRequestHistories(rno);
		List<StatusHistory> testerToDevHistories = new ArrayList<>();
		for (StatusHistory tester : allHistories) {
			if (tester.getNextStatus() == 3 || tester.getNextStatus() == 7) {
				tester.setFileList(commonDao.selectStatusHistoryFiles(tester.getHno()));
				if (tester.getReply() == null) {
					tester.setReply("내용이 없습니다.");
				}
				testerToDevHistories.add(tester);
			}
		}

		return testerToDevHistories;
	}

	@Override
	public void uploadFile(StatusHistoryFile statusHistoryFile) {
		commonDao.insertStatusHistoryFile(statusHistoryFile);

	}

	/*
	 * 작성자: 장현 접수예정일 받는 메소드
	 */
	@Override
	public Date getReceiptDoneDate(int rno) {
		List<StatusHistory> requestHistories = commonDao.selectRequestHistories(rno);
		StatusHistory receiptDoneDate = new StatusHistory();

		for (StatusHistory sh : requestHistories) {
			if (sh.getNextStatus() == 2) {
				receiptDoneDate = sh;
				break;
			}
		}
		return receiptDoneDate.getChangeDate();
	}

	/*
	 * 작성자: 장현 최신 요청 개수, 진행중인 요청 개수, 진행 완료 개수, 개발자일 경우 재검토, pm일 경우 반려건 개수 출력
	 */
	@Override
	@Transactional
	public HashMap<String, Integer> getWorkingStatus(Member member) {
		HashMap<String, Integer> map = new HashMap<>();
		// 각 status별 초기값 세팅
		for (int i = 1; i <= 13; i++) {
			map.put(i + "", 0);
		}
		List<Status> statusList = commonDao.selectMyWorkStatus(member);
		for (Status status : statusList) {
			map.put(status.getStatusNo() + "", status.getCount());
		}
		return map;
	}

	/*
	 * 작성자: 장현 진행중인 요청건, 완료된 요청건 개수 구하기
	 */
	@Override
	public HashMap<String, Integer> getUserRequestStatusCount(Member member) {
		HashMap<String, Integer> map = new HashMap<>();
		// 각 status별 초기값 세팅
		for (int i = 1; i <= 13; i++) {
			map.put(i + "", 0);
		}
		List<Status> statusList = commonDao.selectMyRequestStatus(member);
		for (Status status : statusList) {
			map.put(status.getStatusNo() + "", status.getCount());
		}
		return map;
	}

	@Override
	public int getListOf7daysLeftCount(Member member) {
		return commonDao.selectListOf7daysLeftCount(member);
	}

	@Override
	public List<Request> getListOf7daysLeft(Member member, Pager dPager) {
		return commonDao.selectListOf7daysLeft(member, dPager);
	}

	@Override
	@Transactional
	public Map<String, Object> getWorkCompletionRate(Member member) {
		Map<String, Object> map = new HashMap<>();
		int allMyRequests = commonDao.selectAllMyRequests(member);
		int delayRequests = commonDao.selectDelayRequests(member);
		// 지연율 넣기
		double delayRate = 0;
		double normalRate = 100;

		if (allMyRequests != 0) {
			delayRate = delayRequests / allMyRequests * 100;
			normalRate = 100 - delayRate;
		}
		map.put("allMyRequests", allMyRequests);
		map.put("delayRequests", delayRequests);
		map.put("delayRate", delayRate);
		map.put("normalRate", normalRate);

		return map;
	}

	/*
	 * 작성자: 장현 파일 다운로드
	 */
	@Override
	public StatusHistoryFile getFile(int fno) {
		return commonDao.selectFile(fno);
	}

	@Override
	public List<RequestProcess> getRequestProcessList(Member member, String checkbox, String status, Pager pager) {
		List<RequestProcess> list = commonDao.selectRequestProcessList(member, checkbox, status, pager);
		return list;
	}

	@Override
	public int getRequestProcessRows(Member member, String checkbox, String status) {
		return commonDao.selectRequestProcessRows(member, checkbox, status);
	}

	@Override
	public int getUserRequestListCount(String searchStatus, Member member) {
		return commonDao.selectUserRequestListCount(searchStatus, member);
	}

	@Override
	public List<Request> getUserRequestList(String searchStatus, Member member, Pager uPager) {
		return commonDao.selectUserRequestList(searchStatus, member, uPager);
	}

	@Override
	public StatusHistory getTempStatusHistory(Member member, StatusHistory statusHistory) {
		return commonDao.selectTempStatusHistory(member, statusHistory);
	}

	@Override
	public void writeStatusHistory(StatusHistory statusHistory) {
		commonDao.insertStatusHistory(statusHistory);

	}

	@Override
	public void updateStatusHistory(StatusHistory statusHistory) {
		commonDao.updateStatusHistory(statusHistory);

	}

	@Override
	public void updateDevProgress(RequestProcess rp) {
		commonDao.updateDevProgress(rp);

	}

	@Override
	@Transactional
	public void updateHistory(RequestProcess rp, StatusHistory sh, Member member) {
		if (member.getMtype().equals("pm")) {
			commonDao.updateRequestProcess(rp);
			commonDao.updateRealStatusHistory(sh);
			if (sh.getFileList() != null) {
				List<StatusHistoryFile> fileList = sh.getFileList();
				for (StatusHistoryFile file : fileList) {
					file.setHno(sh.getHno());
					commonDao.insertStatusHistoryFile(file);
				}
			}

		} else {
			commonDao.updateRealStatusHistory(sh);

			if (sh.getFileList() != null) {
				List<StatusHistoryFile> fileList = sh.getFileList();
				for (StatusHistoryFile file : fileList) {
					file.setHno(sh.getHno());
					commonDao.insertStatusHistoryFile(file);
				}
			}
		}
	}

	@Override
	public int isThereTestReject(int rno) {
		List<StatusHistory> histories = commonDao.selectRequestHistories(rno);
		for (StatusHistory sh : histories) {
			if (sh.getNextStatus() == 3) {
				return 1;
			}
		}
		return 0;
	}

	@Override
	public int getPmRequestProcessRows(String status) {
		return commonDao.selectPmRequestProcessRows(status);
	}

	@Override
	public List<RequestProcess> getPmRequestProcessList(String status, Pager rpPager) {
		return commonDao.selectPmRequestProcessList(status, rpPager);
	}

	/**
	 * @author: KIM JI YOUNG 신규 알림(서비스 변경 사항 확인)
	 */

	// 서비스 변경 사항 확인
	@Override
	public int check(String mtype, int rno) {
		return commonDao.updateCheck(mtype, rno);
	}

	// 서비스 변경 사항 미확인
	@Override
	public int notCheck(String mtype, int rno) {
		return commonDao.updateNotCheck(mtype, rno);
	}

	// 신규 내역 알림
	@Override
	@Transactional
	public List<Request> getNewAlertList(Member member) {
		return commonDao.selectNewAlertList(member);
	}

	@Override
	public void rollBackStep(Member member, int hno) {
		// 1. 해당 요청건에 해당 담당자가 작성한 임시글이 있는지 확인한다.(tester의 경우 현재 상태가 재검토인지 테스트 완료인지 확인 추가
		// 필요)
		// 2. 있다면 해당 hno의 내용과 파일을 임시글에 옮기고 파일도 등록한다.

		if (member.getMtype().equals("developer")) {
			// 해당 단계 가장 최근 완료 히스토리
			StatusHistory mySh = commonDao.selectStatusHistory(hno);
			// 1. 해당 요청건에 해당 담당자가 작성한 임시글이 있는지 확인한다.
			StatusHistory searchParam = new StatusHistory();
			searchParam.setRno(mySh.getRno());
			searchParam.setWriter(member.getMid());
			searchParam.setNextStatus(14);
			StatusHistory tempSh = commonDao.selectTempStatusHistory(member, searchParam);
			if (tempSh == null) {
				// insert
				// 2. 없다면 해당 hno의 내용으로 임시글을 새로 만든 후 파일도 등록한다.
				StatusHistory newTempSh = new StatusHistory();
				newTempSh.setRno(mySh.getRno());
				newTempSh.setReply(mySh.getReply());
				newTempSh.setDistSource(mySh.getDistSource());
				newTempSh.setNextStatus(14);
				newTempSh.setWriter(member.getMid());
				commonDao.insertStatusHistory(newTempSh);
			} else {
				// 2. 있다면 해당 hno의 내용과 파일을 임시글에 옮기고 파일도 등록한다.
				// update
				tempSh.setDistSource(mySh.getDistSource());
				tempSh.setReply(mySh.getReply());
				commonDao.updateRealStatusHistory(tempSh);
			}
			// 3. 해당 hno의 statusHistory와 statusHistoryFile들을 지운다.
			commonDao.deleteStautsHistoryFiles(mySh.getHno());
			commonDao.deleteStatusHistory(mySh.getHno());
			// 4. 해당 요청건의 현재 상태를 ~완료에서 ~중으로 돌린다.
			commonDao.updateRequestStatus(mySh.getRno(), 4);
			// 5. 해당 단계 완료일 null로 초기화.
			RequestProcess rp = new RequestProcess();
			rp.setRno(mySh.getRno());
			commonDao.updateCompDateNull(member, rp);
		} else if (member.getMtype().equals("tester")) {
			// 해당 단계 가장 최근 완료 히스토리
			StatusHistory mySh = commonDao.selectStatusHistory(hno);
			// 1. 해당 요청건에 해당 담당자가 작성한 임시글이 있는지 확인한다.
			StatusHistory searchParam = new StatusHistory();
			searchParam.setRno(mySh.getRno());
			searchParam.setWriter(member.getMid());
			if(mySh.getNextStatus()== 3) {
				searchParam.setNextStatus(16);
			}
			else if(mySh.getNextStatus()== 7) {
				searchParam.setNextStatus(15);
			}
			StatusHistory tempSh = commonDao.selectTempStatusHistory(member, searchParam);
			if (tempSh == null) {
				// insert
				// 2. 없다면 해당 hno의 내용으로 임시글을 새로 만든 후 파일도 등록한다.
				StatusHistory newTempSh = new StatusHistory();
				newTempSh.setRno(mySh.getRno());
				newTempSh.setReply(mySh.getReply());
				newTempSh.setDistSource(mySh.getDistSource());
				if(mySh.getNextStatus()== 3) {
					newTempSh.setNextStatus(16);
				}
				else if(mySh.getNextStatus()== 7) {
					newTempSh.setNextStatus(15);
				}
				newTempSh.setWriter(member.getMid());
				commonDao.insertStatusHistory(newTempSh);
			} else {
				// 2. 있다면 해당 hno의 내용과 파일을 임시글에 옮기고 파일도 등록한다.
				// update
				tempSh.setDistSource(mySh.getDistSource());
				tempSh.setReply(mySh.getReply());
				commonDao.updateRealStatusHistory(tempSh);
			}
			// 3. 해당 hno의 statusHistory와 statusHistoryFile들을 지운다.
			commonDao.deleteStautsHistoryFiles(mySh.getHno());
			commonDao.deleteStatusHistory(mySh.getHno());
			// 4. 해당 요청건의 현재 상태를 ~완료에서 ~중으로 돌린다.
			commonDao.updateRequestStatus(mySh.getRno(), 6);
			// 5. 해당 단계 완료일 null로 초기화.
			RequestProcess rp = new RequestProcess();
			rp.setRno(mySh.getRno());
			commonDao.updateCompDateNull(member, rp);
		} else if (member.getMtype().equals("usertester")) {
			// 해당 단계 가장 최근 완료 히스토리
			StatusHistory mySh = commonDao.selectStatusHistory(hno);
			// 1. 해당 요청건에 해당 담당자가 작성한 임시글이 있는지 확인한다.
			StatusHistory searchParam = new StatusHistory();
			searchParam.setRno(mySh.getRno());
			searchParam.setWriter(member.getMid());
			searchParam.setNextStatus(17);
			StatusHistory tempSh = commonDao.selectTempStatusHistory(member, searchParam);
			if (tempSh == null) {
				// insert
				// 2. 없다면 해당 hno의 내용으로 임시글을 새로 만든 후 파일도 등록한다.
				StatusHistory newTempSh = new StatusHistory();
				newTempSh.setRno(mySh.getRno());
				newTempSh.setReply(mySh.getReply());
				newTempSh.setDistSource(mySh.getDistSource());
				newTempSh.setNextStatus(17);
				newTempSh.setWriter(member.getMid());
				commonDao.insertStatusHistory(newTempSh);
			} else {
				// 2. 있다면 해당 hno의 내용과 파일을 임시글에 옮기고 파일도 등록한다.
				// update
				tempSh.setDistSource(mySh.getDistSource());
				tempSh.setReply(mySh.getReply());
				commonDao.updateRealStatusHistory(tempSh);
			}
			// 3. 해당 hno의 statusHistory와 statusHistoryFile들을 지운다.
			commonDao.deleteStautsHistoryFiles(mySh.getHno());
			commonDao.deleteStatusHistory(mySh.getHno());
			// 4. 해당 요청건의 현재 상태를 ~완료에서 ~중으로 돌린다.
			commonDao.updateRequestStatus(mySh.getRno(), 8);
			// 5. 해당 단계 완료일 null로 초기화.
			RequestProcess rp = new RequestProcess();
			rp.setRno(mySh.getRno());
			commonDao.updateCompDateNull(member, rp);
		} else if (member.getMtype().equals("distributor")) {
			// 해당 단계 가장 최근 완료 히스토리
			StatusHistory mySh = commonDao.selectStatusHistory(hno);
			// 1. 해당 요청건에 해당 담당자가 작성한 임시글이 있는지 확인한다.
			StatusHistory searchParam = new StatusHistory();
			searchParam.setRno(mySh.getRno());
			searchParam.setWriter(member.getMid());
			searchParam.setNextStatus(18);
			StatusHistory tempSh = commonDao.selectTempStatusHistory(member, searchParam);
			if (tempSh == null) {
				// insert
				// 2. 없다면 해당 hno의 내용으로 임시글을 새로 만든 후 파일도 등록한다.
				StatusHistory newTempSh = new StatusHistory();
				newTempSh.setRno(mySh.getRno());
				newTempSh.setReply(mySh.getReply());
				newTempSh.setDistSource(mySh.getDistSource());
				newTempSh.setNextStatus(18);
				newTempSh.setWriter(member.getMid());
				commonDao.insertStatusHistory(newTempSh);
			} else {
				// 2. 있다면 해당 hno의 내용과 파일을 임시글에 옮기고 파일도 등록한다.
				// update
				tempSh.setDistSource(mySh.getDistSource());
				tempSh.setReply(mySh.getReply());
				commonDao.updateRealStatusHistory(tempSh);
			}
			// 3. 해당 hno의 statusHistory와 statusHistoryFile들을 지운다.
			commonDao.deleteStautsHistoryFiles(mySh.getHno());
			commonDao.deleteStatusHistory(mySh.getHno());
			// 4. 해당 요청건의 현재 상태를 ~완료에서 ~중으로 돌린다.
			commonDao.updateRequestStatus(mySh.getRno(), 10);
			// 5. 해당 단계 완료일 null로 초기화.
			RequestProcess rp = new RequestProcess();
			rp.setRno(mySh.getRno());
			commonDao.updateCompDateNull(member, rp);
		}

	}

	@Override
	public StatusHistory getStatusHistory(int hno) {
		return commonDao.selectStatusHistory(hno);
	}

}
