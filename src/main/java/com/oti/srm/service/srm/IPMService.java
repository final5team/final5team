package com.oti.srm.service.srm;

import java.util.List;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.StatusHistory;

/**
 * @author KIM JI YOUNG
 *
 */
public interface IPMService {
	// 담당자 목록 구하기
	public List<Member> getStaffBySno(int sno, String mtype);

	public void receipt(StatusHistory statusHistory);


}
