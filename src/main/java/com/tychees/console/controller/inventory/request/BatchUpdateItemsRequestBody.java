package com.tychees.console.controller.inventory.request;

import java.util.List;

import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.controller.AbstractWebRequestBody;

public class BatchUpdateItemsRequestBody 
	extends AbstractWebRequestBody 
{
	public List<InventoryItemBean> itemListForInsert;
	public List<InventoryItemBean> itemListForUpdate;
	public List<InventoryItemBean> itemListForDelete;
}
