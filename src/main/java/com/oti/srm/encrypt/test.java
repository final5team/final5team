package com.oti.srm.encrypt;

public class test {

	public static void main(String[] args) {
		
		try {
			AesUtil aseUtil = new AesUtil();
			String encString = aseUtil.encrypt("pass1234");
			System.out.println("encString : " + encString);
			
			
			String decString = aseUtil.decrypt(encString);
			System.out.println("desString " + decString);
		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

}
