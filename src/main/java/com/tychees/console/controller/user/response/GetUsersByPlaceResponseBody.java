package com.tychees.console.controller.user.response;

import java.util.List;

import com.tychees.core.bean.user.UserBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetUsersByPlaceResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<UserBean> userList;
}
