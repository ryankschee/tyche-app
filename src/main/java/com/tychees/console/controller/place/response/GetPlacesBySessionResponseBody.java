package com.tychees.console.controller.place.response;

import java.util.List;

import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetPlacesBySessionResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<PlaceBean> placeList;
}
