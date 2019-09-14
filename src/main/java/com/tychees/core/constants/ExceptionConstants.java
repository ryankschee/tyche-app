package com.tychees.core.constants;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum ExceptionConstants 
	implements java.io.Serializable
{
	NO_EXCEPTION(0, "No Exception."),
	GENERAL_INVALID_INPUT_EXCEPTION(100, "Invalid input found."),
	DAO_UNKNOWN_EXCEPTION(1000, "Unknown exception found at data access."),
	DAO_SQL_EXCEPTION(2, "SQL exception found.");
	
	public final int code;
	public final String message;
	
	ExceptionConstants(int code, String message)
	{
		this.code = code;
		this.message = message;
	}
	
	public String getName() 
	{
        return this.name();
    }
}
