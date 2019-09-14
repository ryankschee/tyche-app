package com.tychees.console.controller.security.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class RegisterUserRequestBody 
	extends AbstractWebRequestBody 
{
	public String firstName = "";
	public String lastName = "";
	public String email = "";
	public String password = "";
	public String salt = "";
	public String companyName = "";
	public String companyUid = "";
	public String businessType = "";
}
