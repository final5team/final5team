package com.oti.srm.dao.srm;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.oti.srm.dto.Member;
import com.oti.srm.dto.RequestProcess;
import com.oti.srm.dto.WorkingInfo;

/**
 * @author KIM JI YOUNG
 *
 */

// PM 관련 dao 메소드 
@Mapper
public interface IPMDao {
	// 담당자 목록 구하기
	public List<Member> selectStaffBySno(@Param("sno")int sno, @Param("mtype")String mtype);

	public int selectQuota(@Param("mid")String mid, @Param("mtype")String mtype);

	public int insertRequestProcess(RequestProcess requestProcess);

	public List<WorkingInfo> selectWorkingInfo(Member member);
	
	
	
	
}
