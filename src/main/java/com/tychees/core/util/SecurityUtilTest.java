package com.tychees.core.util;

public class SecurityUtilTest {

	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		SecurityUtil securityUtil = new SecurityUtil();
		
		String sSalt = securityUtil.generateSalt(32);
		
		String pwd = securityUtil.generateSecurePassword("d6797269f9bea2a08c35785a422efc392dd09a37efceb219bfb0839ee22eb044", sSalt.getBytes());

		System.err.println("sSalt="+sSalt);
		System.err.println("pwd="+pwd);
	}
}
