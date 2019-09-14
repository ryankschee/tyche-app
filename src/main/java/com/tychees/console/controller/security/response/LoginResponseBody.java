package com.tychees.console.controller.security.response;

import java.util.List;

import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.user.UserBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class LoginResponseBody 
	extends AbstractWebResponseBody 
{
	public boolean rememberMe;
	public UserBean currentUserObj;
	public UserSessionBean currentSessionObj;
	public List<PlaceBean> placeList;
}
