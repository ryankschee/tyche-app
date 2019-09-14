package com.tychees.console.controller.inventory.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetDependentItemsByItemRequestBody 
	extends AbstractWebRequestBody 
{
	public String itemId = "";
	public boolean filterByPosVisible = false;
	public boolean posVisible = false;
}
