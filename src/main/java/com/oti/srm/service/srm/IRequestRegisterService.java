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

	
	// PM 조회
	public int getPmTotalRows(ListFilter listFilter, Member member);
	public List<SelectPM> getPmRequestList(Request request, ListFilter listFilter, Pager pager, Member member);


	
	
	
}
