package com.oti.srm.dao;

import java.util.List;

import com.oti.srm.dto.StatusHistory;
import com.oti.srm.dto.StatusHistoryFile;

public interface IUserTestDao {
	public StatusHistory getRecentDevHistory(int rno);
	public List<StatusHistoryFile> getStatusHistoryFiles(int hno);
}
