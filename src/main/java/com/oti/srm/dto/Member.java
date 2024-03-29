package com.oti.srm.dto;

import java.util.Date;
import java.util.Map;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.ToString;

@Data
@ToString(exclude = "fileData")
public class Member {
	private String mid;    
	private String mtype; 
	private String mname; 
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birth; 
	private String gender; 
	private String address;
	private int sno;  
	private String email; 
	private String password; 
	private String organ;  
	private String phone; 
	private String position; 
	private byte[] fileData;
	private String fileType;
	private String fileName;
	private Date savedDate;
	
	//주소
	private int postcode;
	private String addr1;
	private String addr2;
	//파일
	private MultipartFile mfile;
	
	//담당 건수
	private Map<String, Integer> quota;
	
	//비밀번호 오류
	private String passConfirm;
	
}
