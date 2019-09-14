package com.tychees.console.controller.customer.response;

import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetCustomerByIdResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public CustomerBean customerObj;
}
