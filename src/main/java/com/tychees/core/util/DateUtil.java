package com.tychees.core.util;

import java.util.Calendar;

import org.springframework.stereotype.Component;

@Component
public class DateUtil {

	public long getFirstDayOfThisMonth()
	{
		return getFirstDayOfMonth(Calendar.getInstance().getTimeInMillis());
	} // .end of getFirstDayOfThisMonth
	
	public long getFirstDayOfMonth(long anytimeInMonth) 
	{
		Calendar anytime = Calendar.getInstance();
		anytime.setTimeInMillis(anytimeInMonth);
		
		// Set to day 1
		anytime.set(Calendar.DAY_OF_MONTH, 1);
		anytime.set(Calendar.HOUR_OF_DAY, 0);
		anytime.set(Calendar.MINUTE, 0);
		anytime.set(Calendar.SECOND, 1);
		
		return anytime.getTimeInMillis();
	} // .end of getFirstDayOfMonth
	
	public long getLastDayOfThisMonth()
	{
		return getLastDayOfMonth(Calendar.getInstance().getTimeInMillis());
	} // .end of getLastDayOfThisMonth
	
	public long getLastDayOfMonth(long anytimeInMonth) 
	{
		Calendar anytime = Calendar.getInstance();
		anytime.setTimeInMillis(anytimeInMonth);
		
		int month = anytime.get(Calendar.MONTH);
		int year = anytime.get(Calendar.YEAR);
		
		// Set to day 1
		anytime.set(Calendar.DAY_OF_MONTH, getDayCountInMonth(month, year));
		anytime.set(Calendar.HOUR_OF_DAY, 23);
		anytime.set(Calendar.MINUTE, 59);
		anytime.set(Calendar.SECOND, 59);
		
		return anytime.getTimeInMillis();
	} // .end of getFirstDayOfMonth
	
	public int getDayCountInMonth(int month, int year)
	{
		switch(month) {
			case Calendar.JANUARY: return 31;
			case Calendar.FEBRUARY: 
				if ((year%4)!=0)
					return 28;
				else
					return 29;
			case Calendar.MARCH: return 31;
			case Calendar.APRIL: return 30;
			case Calendar.MAY: return 31;
			case Calendar.JUNE: return 30;
			case Calendar.JULY: return 31;
			case Calendar.AUGUST: return 31;
			case Calendar.SEPTEMBER: return 30;
			case Calendar.OCTOBER: return 31;
			case Calendar.NOVEMBER: return 30;
			case Calendar.DECEMBER: return 31;
			default: return 0;
		}
	} // .end of getDayCountInMonth
}
