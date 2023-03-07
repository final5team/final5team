package com.oti.srm.service.srm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.oti.srm.dto.ListFilter;
import com.oti.srm.dto.Member;
import com.oti.srm.dto.Pager;
import com.oti.srm.dto.Request;
import com.oti.srm.dto.SelectPM;
import com.oti.srm.dto.StatusHistoryFile;
import com.oti.srm.dto.StatusNoFilter;

public interface IRequestRegisterService {
	public enum RequestResult {
		SUCCESS, FAIL;
	}
	public static final int REQUEST_SUCCESS = 1;
	public static final int REQUEST_FAIL = 0;
	
	public int writeRequest(Request request, List<StatusHistoryFile> fileList);
	public int updateRequest(Request request);

	public List<Request> getRequestList(Request request, Pager pager);

	public int getPresentStep(int rno);

	
	// 내 업무 조회
	public int getMyWorkRows(ListFilter listFilter, Member member);
	public List<SelectPM> getMyWorkList( ListFilter listFilter, Pager pager, Member member);

	// 내 요청 개수 조회
	public int getRequestListRows(ListFilter listFilter, Member member);
	//사용자의 요청 리스트 조회
	public List<SelectPM> getMyRequestList(ListFilter listFilter, Pager pager, Member member);
	// 업무 담당자 요청 개수 조회
	public int getWorkerRequestListRows(ListFilter listFilter, Member member);
	//업무 담당자의 요청 리스트 조회
	public List<SelectPM> getWorkerRequestList(ListFilter listFilter, Pager pager, Member member);
	
	public Request getRequestDetail(int rno);

	public StatusHistoryFile getMyRequestFile(int fno);

	public ListFilter dateFilterList(ListFilter listFilter);
	public int getMainToWorkerListRows(StatusNoFilter statusNoFilter, Member member);
	public List<SelectPM> getMainToWorkerList(StatusNoFilter statusNoFilter, Member member, Pager pager);
	
}
