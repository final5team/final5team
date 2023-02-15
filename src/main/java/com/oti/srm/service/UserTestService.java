package com.oti.srm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oti.srm.dao.ICommonDao;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;

@Service
public class UserTestService implements IUserTestService {
	@Autowired
	ICommonDao commonDao;

	@Override
	@Transactional
	public Map<String, List<StatusHistory>> getDevAndTesterHistories(int rno) {
		// 요청에 딸린 전체 단계 이력 가져오기
		List<StatusHistory> requestHistories = commonDao.getRequestHistories(rno);

		List<StatusHistory> devToTesterHistories = new ArrayList<StatusHistory>();
		List<StatusHistory> testerToDevHistories = new ArrayList<StatusHistory>();

		for (StatusHistory sh : requestHistories) {
			// 개발자 -> 테스터 단계 이력 담기
			if (sh.getNextStatus() == 5) {
				devToTesterHistories.add(sh);
			}
			// 테스터 -> 개발자 단계 이력 담기
			else if (sh.getNextStatus() == 13) {
				testerToDevHistories.add(sh);
			}
		}


		Map<String, List<StatusHistory>> devAndTesterHistories = new HashMap<String, List<StatusHistory>>();

		devAndTesterHistories.put("devToTesterHistories", devToTesterHistories);
		devAndTesterHistories.put("testerToDevHistories", testerToDevHistories);

		return devAndTesterHistories;
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
