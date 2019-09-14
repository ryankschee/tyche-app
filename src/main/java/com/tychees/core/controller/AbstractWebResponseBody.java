package com.tychees.core.controller;

public abstract class AbstractWebResponseBody 
{
	public RequestStatus status; 
	public String sessionId = "";
	public String userId = "";
	public String placeId = "";
	public long elapsedTimeInMillis;
	
	public boolean resetPasswordRequired = false;
	public boolean logoutRequired = false;
}