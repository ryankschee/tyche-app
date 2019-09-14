package com.tychees.console.controller.search.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class CommonSearchRequestBody 
	extends AbstractWebRequestBody 
{
	public String keywordList = "";
	
	public boolean searchCustomer = false;
	public boolean searchBilling = false;
	public boolean searchCategory = false;
	public boolean searchItem = false;
	public boolean searchPlace = false;
}
