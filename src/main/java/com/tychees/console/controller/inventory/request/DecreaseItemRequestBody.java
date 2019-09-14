package com.tychees.console.controller.inventory.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class DecreaseItemRequestBody 
	extends AbstractWebRequestBody 
{
	public String itemId = "";
	public double quantity = 0;
	public String billingId = "";
	public String billingLineId = "";
	public String reason = "";
	public String remarks = "";
}
