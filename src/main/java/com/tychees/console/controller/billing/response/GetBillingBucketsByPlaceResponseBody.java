package com.tychees.console.controller.billing.response;

import java.util.List;

import com.tychees.core.bean.billing.BillingBucketBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetBillingBucketsByPlaceResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<BillingBucketBean> billingBucketList;
}
