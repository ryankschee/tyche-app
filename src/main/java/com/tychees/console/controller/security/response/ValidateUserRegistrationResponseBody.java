package com.tychees.console.controller.security.response;

import com.tychees.core.controller.AbstractWebResponseBody;

public class ValidateUserRegistrationResponseBody 
	extends AbstractWebResponseBody 
{
	public boolean emailExists = false;
	public boolean companyUidExists = false;
}
