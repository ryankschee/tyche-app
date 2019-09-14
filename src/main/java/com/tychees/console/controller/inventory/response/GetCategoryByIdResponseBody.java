package com.tychees.console.controller.inventory.response;

import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetCategoryByIdResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public InventoryCategoryBean categoryObj;
}
