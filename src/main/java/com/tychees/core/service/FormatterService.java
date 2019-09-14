package com.tychees.core.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.springframework.stereotype.Service;
  
@Service("formatterService")  
public class FormatterService {  

	// e.g. 12.13.52 or 3:30pm
	public final static DateFormat DATE_FORMAT_SHORT = DateFormat.getDateInstance(DateFormat.SHORT);
	
	// e.g. Jan 12, 1952
	public final static DateFormat DATE_FORMAT_MEDIUM = DateFormat.getDateInstance(DateFormat.MEDIUM);
	
	// e.g. January 12, 1952 or 3:30:32pm
	public final static DateFormat DATE_FORMAT_LONG = DateFormat.getDateInstance(DateFormat.LONG);
	
	// e.g. Tuesday, April 12, 1952 AD or 3:30:42pm PST.
	public final static DateFormat DATE_FORMAT_FULL = new SimpleDateFormat("yyyy.MM.dd G 'at' HH:mm:ss z");
	
	
}
