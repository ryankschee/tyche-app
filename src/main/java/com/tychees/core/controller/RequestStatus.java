package com.tychees.core.controller;

import com.fasterxml.jackson.annotation.JsonFormat;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum RequestStatus 
	implements java.io.Serializable
{
	REQUEST_SUCCESS(0, "Request success."),
	UNKNOWN_EXCEPTION(1, "Unknown exception found."),
	AUTHENTICATION_FAILURE(2, "Authentication failure."),
	LOGOUT_FAILURE(3, "Logout failure."),
	INVALID_SESSION(4, "Invalid session found."),
	INVALID_USER(5, "Invalid user found.");
	
	public final int code;
	public final String message;
	
	RequestStatus(int code, String message)
	{
		this.code = code;
		this.message = message;
	}
	
	public String getName() 
	{
        return this.name();
    }
}
