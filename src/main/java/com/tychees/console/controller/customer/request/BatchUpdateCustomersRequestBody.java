package com.tychees.console.controller.customer.request;

import java.util.List;

import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.controller.AbstractWebRequestBody;

public class BatchUpdateCustomersRequestBody 
	extends AbstractWebRequestBody 
{
	public List<CustomerBean> listForInsert;
	public List<CustomerBean> listForUpdate;
	public List<CustomerBean> listForDelete;
}
