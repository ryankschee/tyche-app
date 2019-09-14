package com.tychees.console.controller.place.response;

import java.util.List;

import com.tychees.core.bean.place.PlaceImageBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetPlaceImagesByPlaceIdResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<PlaceImageBean> imageList;
}
