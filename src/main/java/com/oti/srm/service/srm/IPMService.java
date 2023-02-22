package com.oti.srm.service.srm;

import java.util.List;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.StatusHistory;

/**
 * @author KIM JI YOUNG
 *
 */
public interface IPMService {
	// 담당자 목록 구하기
	public List<Member> getStaffBySno(int sno, String mtype);
	// 접수 완료/ 반려 처리
	public int receipt(StatusHistory statusHistory, RequestProcess requestProcess);
	// 서비스 요청 처리 정보 얻기
	public StatusHistory getStatusHistory(int rno, String string);


}
