package com.tychees.console.controller.customer.request;

import java.util.List;

import com.tychees.core.bean.customer.CustomerEmailBean;
import com.tychees.core.controller.AbstractWebRequestBody;

public class BatchUpdateCustomerEmailsRequestBody 
	extends AbstractWebRequestBody 
{
	public List<CustomerEmailBean> listForInsert;
	public List<CustomerEmailBean> listForUpdate;
	public List<CustomerEmailBean> listForDelete;
}
