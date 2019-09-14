package com.tychees.console.controller.inventory.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetItemByIdRequestBody 
	extends AbstractWebRequestBody 
{
	public String itemId;
	public boolean loadImages = false;
}
