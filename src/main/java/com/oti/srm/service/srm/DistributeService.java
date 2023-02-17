package com.oti.srm.service.srm;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.srm.ICommonDao;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;

@Service
public class DistributeService implements IDistributeService {
	@Autowired
	ICommonDao commonDao;

	@Override
	@Transactional
	public List<StatusHistory> getDevToTesterHistories(int rno) {
		// 요청에 딸린 전체 단계 이력 가져오기
		List<StatusHistory> requestHistories = commonDao.getRequestHistories(rno);

		List<StatusHistory> devToTesterHistories = new ArrayList<StatusHistory>();

		for (StatusHistory sh : requestHistories) {
			// 개발자 -> 테스터 단계 이력만 담기
			if (sh.getNextStatus() == 5) {
				sh.setFileList(commonDao.getStatusHistoryFiles(sh.getHno()));
				devToTesterHistories.add(sh);
			}
		}

		return devToTesterHistories;
	}

	@Override
	@Transactional
	public Request getRequest(int rno) {
		Request request = commonDao.getRequest(rno);
		request.setFiles(commonDao.getRequestFiles(rno));
		return request;
	}

	@Override
	public RequestProcess getRequestProcess(int rno) {
		RequestProcess requestProcess = commonDao.getRequestProcess(rno);
		return requestProcess;
	}

}
