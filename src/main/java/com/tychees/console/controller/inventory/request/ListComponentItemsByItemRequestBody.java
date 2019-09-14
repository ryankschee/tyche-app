package com.tychees.console.controller.inventory.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class ListComponentItemsByItemRequestBody 
	extends AbstractWebRequestBody 
{
	public String itemId = "";
	public boolean mandatory = true;
	public boolean optional = true;
	public boolean filterByPosVisible = false;
	public boolean posVisible = false;
	public boolean viewBean = false;
}
