package com.tychees.console.controller.inventory.response;

import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetItemByIdResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public InventoryItemBean itemObj;
}
