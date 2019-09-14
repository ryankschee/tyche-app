package com.tychees.console.controller.customer.response;

import java.util.List;

import com.tychees.core.bean.customer.view.CustomerCompactViewBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetCustomersByPlaceResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	//public List<CustomerBean> customerList;
	//public List<CustomerViewBean> customerList;
	public List<CustomerCompactViewBean> customerList;
}
