package com.tychees.console.controller.security.response;

import com.tychees.core.bean.user.UserBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class AuthenticateResponseBody 
	extends AbstractWebResponseBody 
{
	public UserBean currentUserObj;
	public UserSessionBean currentSessionObj;
}
