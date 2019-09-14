package com.tychees.console.controller.billing.response;

import com.tychees.core.bean.billing.BillingBucketBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetBillingBucketByIdResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public BillingBucketBean billingBucketObj;
}
