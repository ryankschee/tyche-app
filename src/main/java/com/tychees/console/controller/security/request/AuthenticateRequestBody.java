package com.tychees.console.controller.security.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class AuthenticateRequestBody 
	extends AbstractWebRequestBody 
{
	public String email;
	public String password;
}
