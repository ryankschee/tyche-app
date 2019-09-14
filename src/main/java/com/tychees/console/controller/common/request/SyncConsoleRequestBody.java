package com.tychees.console.controller.common.request;

import java.util.List;

import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.billing.BillingBucketBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.document.DocumentBean;
import com.tychees.core.bean.employee.EmployeeBean;
import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.user.UserBean;
import com.tychees.core.controller.AbstractWebRequestBody;

public class SyncConsoleRequestBody 
	extends AbstractWebRequestBody {

	// Persistence Objects
	public List<BillingBean> billingList;
	public List<BillingBucketBean> billingBucketList;
	public List<DocumentBean> documentList;
	public List<CustomerBean> customerList;
	public List<EmployeeBean> employeeList;
	public List<InventoryCategoryBean> categoryList;
	public List<InventoryItemBean> itemList;
	public List<InventoryTransactionBean> transactionList;
	public List<PlaceBean> placeList;
	public List<UserBean> userList;
}
