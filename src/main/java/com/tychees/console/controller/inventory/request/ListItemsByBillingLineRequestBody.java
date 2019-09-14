package com.tychees.console.controller.inventory.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class ListItemsByBillingLineRequestBody 
	extends AbstractWebRequestBody 
{
	public String billingId = "";
	public String billingLineId = "";
	public boolean filterByPosVisible = false;
	public boolean posVisible = false;
	public boolean viewBean = false;
}
