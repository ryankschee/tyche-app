package com.tychees.core.util;

import java.math.BigDecimal;
import java.math.RoundingMode;

import org.springframework.stereotype.Component;

@Component
public class MathUtil {

	public double round(double value, int decimal) 
	{
		if (decimal < 0) throw new IllegalArgumentException();

	    BigDecimal bd = new BigDecimal(value);
	    bd = bd.setScale(decimal, RoundingMode.HALF_UP);
	    return bd.doubleValue();
	} // .end of round	
}
