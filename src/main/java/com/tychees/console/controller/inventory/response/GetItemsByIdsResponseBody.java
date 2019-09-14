package com.tychees.console.controller.inventory.response;

import java.util.List;

import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetItemsByIdsResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<InventoryItemBean> itemList;
}
