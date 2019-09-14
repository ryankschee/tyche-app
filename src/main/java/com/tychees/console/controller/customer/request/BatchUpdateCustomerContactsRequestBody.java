package com.tychees.console.controller.customer.request;

import java.util.List;

import com.tychees.core.bean.customer.CustomerContactBean;
import com.tychees.core.controller.AbstractWebRequestBody;

public class BatchUpdateCustomerContactsRequestBody 
	extends AbstractWebRequestBody 
{
	public List<CustomerContactBean> listForInsert;
	public List<CustomerContactBean> listForUpdate;
	public List<CustomerContactBean> listForDelete;
}
