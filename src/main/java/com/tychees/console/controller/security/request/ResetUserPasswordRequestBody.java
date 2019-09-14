package com.tychees.console.controller.security.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class ResetUserPasswordRequestBody 
	extends AbstractWebRequestBody 
{
	public String userId = "";
	public String password = "";
	public String salt = "";
	public boolean resetPasswordRequired = false;
}
