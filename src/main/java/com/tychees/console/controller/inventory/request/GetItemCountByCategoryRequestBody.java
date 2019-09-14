package com.tychees.console.controller.inventory.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetItemCountByCategoryRequestBody 
	extends AbstractWebRequestBody 
{
	public String categoryId;
	public String groupName;

	public boolean filterByGroupName = false;
	public boolean filterByPosVisible = false;
	public boolean posVisible = false;
}
