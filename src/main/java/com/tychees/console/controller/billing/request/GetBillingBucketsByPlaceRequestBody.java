package com.tychees.console.controller.billing.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetBillingBucketsByPlaceRequestBody 
	extends AbstractWebRequestBody 
{
	// nothing, all inherit
	public boolean filterByBucketStatus = false;
	public String bucketStatus = "";
}
