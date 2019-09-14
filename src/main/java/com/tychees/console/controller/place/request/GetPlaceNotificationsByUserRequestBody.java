package com.tychees.console.controller.place.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetPlaceNotificationsByUserRequestBody 
	extends AbstractWebRequestBody 
{
	public String userId = "";
	public int notificationCount = 30;
}
