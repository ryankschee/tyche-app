package com.tychees.console.controller.customer.response;

import java.util.List;

import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetCustomersByIdsResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<CustomerBean> customerList;
}
