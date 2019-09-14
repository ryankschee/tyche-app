package com.tychees.console.controller.customer.response;

import java.util.ArrayList;
import java.util.List;

import com.tychees.core.controller.AbstractWebResponseBody;

public class GetCustomerFilterCriteriaByPlaceResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<String> typeList = new ArrayList<String>();
	public List<String> stateList = new ArrayList<String>();
	public List<String> areaList = new ArrayList<String>();
	public List<String> cityList = new ArrayList<String>();
}
