package com.tychees.console.controller.billing.response;

import java.util.List;

import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetBillingsByCustomerResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<BillingBean> billingList;
}
