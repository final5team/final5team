package com.oti.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
@Data
public class Member {
	private String mid;
	private String mtype;
	private String mname;
	@DateTimeFormat(pattern="yyyy-mm-dd")
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
}
