package com.tychees.console.controller.billing.response;

import java.util.List;

import com.tychees.core.bean.billing.view.BillingCompactViewBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetBillingsByPlaceResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	//public List<BillingBean> billingList;
	//public List<InventoryTransactionBean> transactionList;
	//public List<BillingViewBean> billingList;
	public List<BillingCompactViewBean> billingList;
}
