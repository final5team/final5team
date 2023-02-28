package com.oti.srm.service.srm;

import java.util.List;

import com.oti.srm.dto.ListFilter;
import com.oti.srm.dto.Member;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.SelectPM;
import com.oti.srm.dto.StatusHistoryFile;

public interface IRequestRegisterService {
	public enum RequestResult {
		SUCCESS, FAIL;
	}
	public static final int REQUEST_SUCCESS = 1;
	public static final int REQUEST_FAIL = 0;
	
	public int writeRequest(Request request, List<StatusHistoryFile> fileList);

	public List<Request> getRequestList(Request request, Pager pager);

	public int getPresentStep(int rno);

	
	// 내 업무 조회
	public int getMyWorkRows(ListFilter listFilter, Member member);
	public List<SelectPM> getMyWorkList( ListFilter listFilter, Pager pager, Member member);

	// 내 요청 조회
	public int getRequestListRows(ListFilter listFilter, Member member);
	public List<SelectPM> getMyRequestList(ListFilter listFilter, Pager pager, Member member);

	public Request getRequestDetail(int rno);

	public StatusHistoryFile getMyRequestFile(int fno);

	public ListFilter dateFilterList(ListFilter listFilter);
	
	
}
