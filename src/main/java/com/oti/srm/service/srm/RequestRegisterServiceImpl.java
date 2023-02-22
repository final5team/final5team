package com.oti.srm.service.srm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
import com.oti.srm.dao.srm.IRequestDao;
import com.oti.srm.dto.ListFilter;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.SelectPM;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class RequestRegisterServiceImpl implements IRequestRegisterService {

	@Autowired
	private IRequestDao requestDao;
	@Autowired
	private ICommonDao commonDao;

	@Override
	@Transactional
	public int writeRequest(Request request, List<StatusHistoryFile> fileList) {
		log.info("작성 실행");
		
		try {
			int rows = requestDao.insertRequest(request);

			// 요청 성공후 결과값 가져오기
			if (rows == 1) {
				int requestRno = requestDao.selectRequest(request.getClient());
				
				// 상태 이력을 남기기 위한 DTO 생성
				StatusHistory statusHistory = new StatusHistory();
				
				// DTO에 필요한 값 넣기
				statusHistory.setRno(requestRno);
				statusHistory.setNextStatus(2);
				statusHistory.setReply("요청 작성 단계");
				statusHistory.setWriter(request.getClient());
				log.info(request.getClient());
				
				// 상태 변경 이력 작성하기
				int historyResult = commonDao.insertStatusHistory(statusHistory);
				if(historyResult == 1) {
					// 작성한 상태 변경 이력 가져오기
					List<StatusHistory> statusHistoryList = commonDao.selectRequestHistories(requestRno);
					StatusHistory newstatusHistory = statusHistoryList.get(0);
					
					//파일 첨부하기
					if(fileList != null) {
						for (StatusHistoryFile file : fileList) {
							file.setHno(newstatusHistory.getHno());
							commonDao.insertStatusHistoryFile(file);
						}
					}
				}
				//DB 입력 실패
			} else {
				return REQUEST_FAIL;
			}

		} catch (Exception e) {
			log.error(e.toString());
		}
		return REQUEST_SUCCESS;
	}

	@Override
	public List<Request> getRequestList(Request request, Pager pager) {
		List<Request> requestList = requestDao.getRequestList();
		return requestList;
	}

	@Override
	public int getPresentStep(int rno) {
		int result = requestDao.getPresentStep(rno);
		log.info("서비스" + result);
		return result;
	}

	// PM 리스트 전체 열 개수 조회
	@Override
	public int getPmTotalRows() {
		int rows = requestDao.countPm();
		return rows;
	}

	// PM 리스트 조회
	@Override
	public List<SelectPM> getPmRequestList(Request request, ListFilter listFilter, Pager pager) {
		request.setStartRowNo(pager.getStartRowNo());
		request.setEndRowNo(pager.getEndRowNo());
		request.setReqType(listFilter.getReqType());

		// 날짜 필터 조건 - 지정 안한 경우
		if (listFilter.getDateFirst().isEmpty() && listFilter.getDateLast().isEmpty()) {
			request.setDateValue("zero");

			// 날짜 필터 조건 - 시작 날짜만 지정한 경우
		} else if (listFilter.getDateFirst().isEmpty()) {
			request.setDateValue("first");
			request.setDateLast(listFilter.getDateLast());

			// 날짜 필터 조건 - 종료 날짜만 지정한 경우
		} else if (listFilter.getDateLast().isEmpty()) {
			request.setDateValue("last");
			request.setDateFirst(listFilter.getDateFirst());

			// 날짜 필터 조건 - 모두 지정한 경우
		} else {
			request.setDateValue("both");
			request.setDateFirst(listFilter.getDateFirst());
			request.setDateLast(listFilter.getDateLast());
		}

		List<SelectPM> result = requestDao.selectAll(request);
		log.info(result.size());

		return result;
	}

}
