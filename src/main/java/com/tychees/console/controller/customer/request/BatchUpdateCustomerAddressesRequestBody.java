package com.tychees.console.controller.customer.request;

import java.util.List;

import com.tychees.core.bean.customer.CustomerAddressBean;
import com.tychees.core.controller.AbstractWebRequestBody;

public class BatchUpdateCustomerAddressesRequestBody 
	extends AbstractWebRequestBody 
{
	public List<CustomerAddressBean> listForInsert;
	public List<CustomerAddressBean> listForUpdate;
	public List<CustomerAddressBean> listForDelete;
}
