package com.tychees.console.controller.billing.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetBillingsByPaymentTimePeriodRequestBody 
	extends AbstractWebRequestBody 
{
	public boolean transactionBean = false;
	public long beginTime = 0L;
	public long endTime = 0L;
}
