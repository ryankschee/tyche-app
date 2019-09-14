package com.tychees.core.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Random;
import java.util.logging.Logger;

import org.apache.commons.text.RandomStringGenerator;
import org.springframework.stereotype.Component;

@Component
public class SecurityUtil {

	private static final Logger LOGGER = Logger.getLogger(SecurityUtil.class.getName());
	
	public String generateSalt(final int byteLength) {
		final Random random = new SecureRandom();
		byte[] sSalt = new byte[byteLength];
		random.nextBytes(sSalt);
		StringBuffer sSaltBuffer = new StringBuffer();
		for (byte saltCh : sSalt) {
			sSaltBuffer.append( (char) saltCh );
		}		
		return sSaltBuffer.toString();
	} // .end of generateSalt
	
	public String generateSecurePassword(final String password, final byte[] salt) {
		String generatedPassword = null;
        try {
            // Create MessageDigest instance for MD5
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            //Add password bytes to digest
            md.update(salt);
            //Get the hash's bytes 
            byte[] bytes = md.digest(password.getBytes());
            //This bytes[] has bytes in decimal format;
            //Convert it to hexadecimal format
            StringBuilder sb = new StringBuilder();
            for(int i=0; i< bytes.length ;i++)
            {
                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
            }
            //Get complete hashed password in hex format
            generatedPassword = sb.toString();
        } 
        catch (NoSuchAlgorithmException e) {
        	LOGGER.severe("Exception: " + e.getMessage());
        }
        return generatedPassword;
	} // .end of generateSecurePassword	
	
	public String generateRandomString(int characterCount) {
		// Generates a 'characterCount' code point string, using only the letters a-z
		 RandomStringGenerator generator = new RandomStringGenerator.Builder()
		     .withinRange('a', 'z').build();
		 return generator.generate(characterCount);
	} // .end of generateRandomString
}