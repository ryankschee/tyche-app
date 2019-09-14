package com.tychees.core.util;

public class NumberUtil {
	
	public static double toSafeDouble(String doubleVal) {
		if (doubleVal==null || doubleVal.length()==0)
			return 0d;
		
		return Double.parseDouble(doubleVal);
	} // .end of toSafeDouble
}
