package com.tychees.pws.controller.search.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class CommonSearchRequestBody 
	extends AbstractWebRequestBody 
{
	public String keywordList = "";
	public double latitude = 0.0;
	public double longitude = 0.0;
	
	public boolean searchCustomer = false;
	public boolean searchBilling = false;
	public boolean searchCategory = false;
	public boolean searchItem = false;
	public boolean searchPlace = false;
}
