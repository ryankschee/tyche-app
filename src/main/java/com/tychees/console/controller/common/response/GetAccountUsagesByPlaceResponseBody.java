package com.tychees.console.controller.common.response;

import com.tychees.core.controller.AbstractWebResponseBody;

public class GetAccountUsagesByPlaceResponseBody 
	extends AbstractWebResponseBody 
{
	public long userUsageCount = 0L;
	public long customerUsageCount = 0L;
	public long employeeUsageCount = 0L;
	public long inventoryCategoryUsageCount = 0L;
	public long inventoryItemUsageCount = 0L;
	public double monthlyBillingUsageAmount = 0;
}
