package com.tychees.console.controller.billing.response;

import java.util.List;

import com.tychees.core.bean.billing.view.BillingCompactViewBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetBillingsByEmployeeResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<BillingCompactViewBean> billingList;
}
