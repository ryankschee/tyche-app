package com.tychees.console.controller.inventory.response;

import java.util.List;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.view.InventoryItemViewBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetItemsByCategoryResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<InventoryItemBean> itemList;
	public List<InventoryItemViewBean> itemViewList;
}
