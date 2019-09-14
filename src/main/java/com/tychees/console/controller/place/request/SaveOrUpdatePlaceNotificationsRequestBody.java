package com.tychees.console.controller.place.request;

import java.util.List;

import com.tychees.core.bean.place.PlaceNotificationBean;
import com.tychees.core.controller.AbstractWebRequestBody;

public class SaveOrUpdatePlaceNotificationsRequestBody 
	extends AbstractWebRequestBody 
{
	public List<PlaceNotificationBean> notificationList;
}
