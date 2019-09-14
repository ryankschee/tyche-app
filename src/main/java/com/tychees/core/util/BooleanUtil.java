package com.tychees.core.util;

public class BooleanUtil {
	
	public static boolean toSafeBoolean(String boolVal) {
		if (boolVal==null || boolVal.length()==0)
			return false;
		
		String boolUpperCaseVal = boolVal.toUpperCase();
		if ("Y".equals(boolUpperCaseVal))
			return true;
		if ("1".equals(boolUpperCaseVal))
			return true;
		
		return Boolean.parseBoolean(boolVal);
	} // .end of toSafeDouble
}
