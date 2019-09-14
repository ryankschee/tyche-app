package com.tychees.console.controller.billing.request;

import java.util.List;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetBillingBucketByLayoutComponentRequestBody 
	extends AbstractWebRequestBody 
{
	public String placeLayoutComponentId;
	public List<String> bucketStatusList;
}
