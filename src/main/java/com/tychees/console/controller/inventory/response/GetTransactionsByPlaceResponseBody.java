package com.tychees.console.controller.inventory.response;

import java.util.List;
import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetTransactionsByPlaceResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<InventoryTransactionBean> transactionList;
}
