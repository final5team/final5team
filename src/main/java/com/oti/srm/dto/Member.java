package com.oti.srm.dto;

import java.util.Date;

import lombok.Data;
@Data
public class Member {
	private String mid;
	private String mtype;
	private String mname;
	private Date birth;
	private String gender;
	private String address;
	private int sno;
	private String email;
	private String password;
	private String organ;
	private String phone;
	private byte[] fileData;
	private String fileType;
	private String fileName;
	private Date savedDate;
}
