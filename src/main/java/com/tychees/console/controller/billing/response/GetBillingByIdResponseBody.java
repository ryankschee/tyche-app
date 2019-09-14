package com.tychees.console.controller.billing.response;

import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetBillingByIdResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public BillingBean billingObj;
	public InventoryTransactionBean transactionObj;
}
