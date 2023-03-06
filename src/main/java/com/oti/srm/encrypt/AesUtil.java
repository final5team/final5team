package com.oti.srm.encrypt;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.util.Base64Utils;


public class AesUtil {
	 private static final String SECRET_KEY = "0123456789abcdef"; // 16 bytes key
	    private static final String INIT_VECTOR = "abcdef0123456789"; // 16 bytes IV

	    public static String encrypt(String value) {
	        try {
	            IvParameterSpec iv = new IvParameterSpec(INIT_VECTOR.getBytes("UTF-8"));
	            SecretKeySpec keySpec = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), "AES");

	            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
	            cipher.init(Cipher.ENCRYPT_MODE, keySpec, iv);

	            byte[] encrypted = cipher.doFinal(value.getBytes());
	            return Base64Utils.encodeToString(encrypted);
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }

	        return null;
	    }

	    public static String decrypt(String encrypted) {
	        try {
	            IvParameterSpec iv = new IvParameterSpec(INIT_VECTOR.getBytes("UTF-8"));
	            SecretKeySpec keySpec = new SecretKeySpec(SECRET_KEY.getBytes("UTF-8"), "AES");

	            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
	            cipher.init(Cipher.DECRYPT_MODE, keySpec, iv);

	            byte[] original = cipher.doFinal(Base64Utils.decodeFromString(encrypted));
	            return new String(original);
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }

	        return null;
	    }
    
}
