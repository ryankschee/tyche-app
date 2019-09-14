package com.tychees.console.controller.common.response;

import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.user.UserBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class SyncSessionResponseBody 
	extends AbstractWebResponseBody 
{
	public PlaceBean placeObj;
	public UserBean userObj;
}
