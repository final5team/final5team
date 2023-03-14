package com.oti.srm.service.srm;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
import com.oti.srm.dao.srm.IRequestDao;
import com.oti.srm.dto.ListFilter;
import com.oti.srm.dto.Member;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.SelectPM;
import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;
import com.oti.srm.dto.StatusNoFilter;

import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
public class RequestRegisterServiceImpl implements IRequestRegisterService {

	@Autowired
	private IRequestDao requestDao;
	@Autowired
	private ICommonDao commonDao;
	
	//요청 작성
	@Override
	@Transactional
	public int writeRequest(Request request, List<StatusHistoryFile> fileList) {

		try {
			int rows = requestDao.insertRequest(request);
			// 요청 성공후 결과값 가져오기
			if (rows == 1) {
				int requestRno = requestDao.selectRequest(request.getClient());

				// 상태 이력을 남기기 위한 DTO 생성
				StatusHistory statusHistory = new StatusHistory();

				// DTO에 필요한 값 넣기
				statusHistory.setRno(requestRno);
				statusHistory.setNextStatus(1);
				statusHistory.setReply("요청 작성 단계");
				statusHistory.setWriter(request.getClient());
				log.info(request.getClient());

				// 상태 변경 이력 작성하기
				int historyResult = commonDao.insertStatusHistory(statusHistory);
				if (historyResult == 1) {
					// 작성한 상태 변경 이력 가져오기
					List<StatusHistory> statusHistoryList = commonDao.selectRequestHistories(requestRno);
					StatusHistory newstatusHistory = statusHistoryList.get(0);

					// 파일 첨부하기
					if (fileList != null) {
						for (StatusHistoryFile file : fileList) {
							file.setHno(newstatusHistory.getHno());
							commonDao.insertStatusHistoryFile(file);
						}
					}
				}
				// DB 입력 실패
			} else {
				return REQUEST_FAIL;
			}

		} catch (Exception e) {
			log.error(e.toString());
		}
		return REQUEST_SUCCESS;
	}
	
	//요청 수정
	@Override
	@Transactional
	public int updateRequest(Request request, List<StatusHistoryFile> sFiles) {
		try {
			//요청 내용 수정
			log.info(request.toString());
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String formattedDate = dateFormat.format(request.getReqExpectDate());
			java.sql.Date sqlDate = java.sql.Date.valueOf(formattedDate);
			request.setReqDate(sqlDate);
			requestDao.updateRequest(request);
			if (sFiles != null && sFiles.size() > 0) {
				for (StatusHistoryFile file : sFiles) {
					file.setHno(requestDao.selectRequestDetail(request.getRno()).getHno());
					commonDao.insertStatusHistoryFile(file);
				}
			}
			log.info("수정 service");
		} catch (Exception e) {
			log.error(e.toString());
			return REQUEST_FAIL;
		}
		return REQUEST_SUCCESS;
	}
	
	// 요청 수정시 파일 추가
	@Override
	public int updateRequestFile(String rno, List<StatusHistoryFile> fileList) {
		
		log.info(Integer.parseInt(rno));
		int hno = requestDao.selectStatusHistory(Integer.parseInt(rno));
		log.info(hno);
		
		// 파일 첨부하기
		if (fileList != null) {
			for (StatusHistoryFile file : fileList) {
				file.setHno(hno);
				commonDao.insertStatusHistoryFile(file);
			}
		}
		return 0;
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

	// 담당 업무 열 개수 조회
	@Override
	public int getMyWorkRows(ListFilter listFilter, Member member) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("listFilter", statusFilterList(dateFilterList(listFilter)));
		map.put("member", member);
		int rows = requestDao.countRows(map);
		return rows;
	}

	// 담당 업무 리스트 조회
	@Override
	@Transactional
	public List<SelectPM> getMyWorkList(ListFilter listFilter, Pager pager, Member member) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		/*map.put("request", request);*/
		map.put("listFilter", statusFilterList(dateFilterList(sysName(listFilter))));
		map.put("pager", pager);
		map.put("member", member);
		List<SelectPM> result = requestDao.selectMyWorkList(map);
		return result;

	}
	// (사용자) 작성한 요청의 개수 가져오기
	@Override
	public int getRequestListRows(ListFilter listFilter, Member member) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("listFilter", myStatusFilterList(dateFilterList(listFilter)));
		map.put("member", member);
		
		int rows = requestDao.countRequestRows(map);
		log.info(rows);
		return rows;
	}
	//사용자가 작성한 요청목록 가져오기 
	@Override
	public List<SelectPM> getMyRequestList(ListFilter listFilter, Pager pager, Member member){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("listFilter", myStatusFilterList(dateFilterList(sysName(listFilter))));
		map.put("pager", pager);
		map.put("member", member);
		List<SelectPM> result = requestDao.selectMyRequest(map);
		log.info(result.size());
		return result;
	}
	// (담당자) 작성한 요청의 개수 가져오기
		@Override
		public int getWorkerRequestListRows(ListFilter listFilter, Member member) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("listFilter", statusFilterList(dateFilterList(listFilter)));
			map.put("member", member);
			
			int rows = requestDao.countWorkerRequestRows(map);
			log.info(rows);
			return rows;
		}
	
	
	//담당자의 요청 목록 가져오기
	@Override
	public List<SelectPM> getWorkerRequestList(ListFilter listFilter, Pager pager, Member member) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("listFilter", statusFilterList(dateFilterList(sysName(listFilter))));
		map.put("pager", pager);
		map.put("member", member);
		List<SelectPM> result = requestDao.selectWorkerRequest(map);
		log.info(result.size());
		return result;
	}
	
	//작성한 요청 상세 정보 가져오기
	@Override
	@Transactional
	public Request getRequestDetail(int rno) {
		//요청 제목, 내용 가져오기
		Request request = requestDao.selectRequestDetail(rno);
		int hno = request.getHno();
		log.info(hno);
		//요청시 첨부된 파일 가져오기
		request.setFileList(requestDao.selectRequestFile(hno));
		return request;
	}
	@Override
	public StatusHistoryFile getMyRequestFile(int fno) {
		StatusHistoryFile file = requestDao.selectFile(fno);
		return file;
	}
	
//	DB에 없거나, mapper에서 편하게 사용하기 위해 정의 내려준 메소드

	//날짜 필터링 메소드
	public ListFilter dateFilterList(ListFilter listFilter) {
		
		// 날짜 필터 조건 - 지정 안한 경우
		if (listFilter.getDateFirst().isEmpty() && listFilter.getDateLast().isEmpty()) {
			listFilter.setDateValue("zero");
			// 날짜 필터 조건 - 시작 날짜만 지정한 경우
		} else if (listFilter.getDateFirst().isEmpty()) {
			listFilter.setDateValue("first");
			try {
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
					Date date = format.parse(listFilter.getDateLast());
					listFilter.setDate_last(date);
				} catch (Exception e) {
				}
			// 날짜 필터 조건 - 종료 날짜만 지정한 경우
		} else if (listFilter.getDateLast().isEmpty()) {
			listFilter.setDateValue("last");
			try {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date date = format.parse(listFilter.getDateFirst());
				listFilter.setDate_first(date);
			} catch (Exception e) {
			}
			// 날짜 필터 조건 - 모두 지정한 경우
		} else {
			listFilter.setDateValue("both");
			try {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date date = format.parse(listFilter.getDateFirst());
				Date date2 = format.parse(listFilter.getDateLast());
				listFilter.setDate_first(date);
				listFilter.setDate_last(date2);
			} catch (Exception e) {
			}
		}
		return listFilter;
	}
	//업무 처리 단계 필터링 메소드
	public ListFilter statusFilterList(ListFilter listFilter) {
			//1 접수
		
		if(listFilter.getStatusNo() == 1) {
			listFilter.setStatusValue("접수");
			//2, 3, 4 개발단계
		} else if(listFilter.getStatusNo()  == 2 || listFilter.getStatusNo()  ==3 || listFilter.getStatusNo() == 4) {
			listFilter.setStatusValue("개발");
			//5, 6, 7 테스트 단계
		} else if (listFilter.getStatusNo()  == 5 || listFilter.getStatusNo()  ==6 || listFilter.getStatusNo() == 7) {
			listFilter.setStatusValue("테스트");
			//8 유저 테스트 단계
		} else if(listFilter.getStatusNo()  == 8) {
			listFilter.setStatusValue("유저테스트");
			//10 배포 단계
		} else if(listFilter.getStatusNo()  == 10) {
			listFilter.setStatusValue("배포");
			//11, 13 완료단계
		} else if(listFilter.getStatusNo()  == 11 || listFilter.getStatusNo()  == 13) {
			listFilter.setStatusValue("완료");
			//12 반려
		} else if(listFilter.getStatusNo() == 12) {
			listFilter.setStatusValue("반려");
		}
		
		return listFilter;
	}
	
	//내 요청 목록 단계 필터링 메소드
		public ListFilter myStatusFilterList(ListFilter listFilter) {
				//1 접수
			if(listFilter.getStatusNo() == 2) {
				listFilter.setStatusValue("진행중");
				
			} else if(listFilter.getStatusNo()  == 11 || listFilter.getStatusNo()  == 13) {
				listFilter.setStatusValue("완료");
				//12 반려
			} else if(listFilter.getStatusNo() == 12) {
				listFilter.setStatusValue("반려");
			}
			
			return listFilter;
		}
	
	
	// 서비스 이름명 주입
	public ListFilter sysName(ListFilter listFilter) {
		
		if(listFilter.getSno() == 1) {
			listFilter.setSystemName("가족관계정보");
		} else if(listFilter.getSno() == 2) {
			listFilter.setSystemName("쇼핑몰");
		} else if(listFilter.getSno() == 3) {
			listFilter.setSystemName("학사관리");
		} else if(listFilter.getSno() == 4) {
			listFilter.setSystemName("서비스요청");
		}
		
		return listFilter;
	}

	@Override
	public int getMainToWorkerListRows(StatusNoFilter statusNoFilter, Member member) {
		return requestDao.selectMainToWorkerListRows(statusNoFilter.getStatusNo(), member);
	}

	@Override
	public List<SelectPM> getMainToWorkerList(StatusNoFilter statusNoFilter, Member member, Pager pager) {
		return requestDao.selectMainToWorkerList(statusNoFilter.getStatusNo(), member, pager);
	}






	
	

	

	

	
	
	
}
