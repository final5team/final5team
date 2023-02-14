package com.oti.srm.service;

import java.util.Map;

import com.oti.srm.dto.StatusHistory;

public interface IUserTestService {
	public StatusHistory getRecentDevHistory(int rno);
}
