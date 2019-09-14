package com.tychees.console.controller.inventory.response;

import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetTransactionByIdResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public InventoryTransactionBean transactionObj;
}
