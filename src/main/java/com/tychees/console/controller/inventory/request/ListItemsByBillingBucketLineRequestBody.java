package com.tychees.console.controller.inventory.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class ListItemsByBillingBucketLineRequestBody 
	extends AbstractWebRequestBody 
{
	public String billingBucketId = "";
	public String billingBucketLineId = "";
	public boolean filterByPosVisible = false;
	public boolean posVisible = false;
	public boolean viewBean = false;
}
