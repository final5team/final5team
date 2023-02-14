package com.oti.srm;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class JDBCEncryptor {

	public static void main(String[] args) {
		StandardPBEStringEncryptor enc = new StandardPBEStringEncryptor();
		enc.setPassword("rktdudgns");
		System.out.println(enc.encrypt("oracle.jdbc.driver.OracleDriver"));
		System.out.println(enc.encrypt("jdbc:oracle:thin:@kosa402.iptime.org:50051:orcl"));
		System.out.println(enc.encrypt("song"));
		System.out.println(enc.encrypt("oracle"));
	}

}
