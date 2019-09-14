package com.tychees.console.controller.inventory.response;

import java.util.List;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.view.InventoryItemCompactViewBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class ListItemsByBillingLineResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<InventoryItemBean> itemList;
	public List<InventoryItemCompactViewBean> itemViewList;
}
