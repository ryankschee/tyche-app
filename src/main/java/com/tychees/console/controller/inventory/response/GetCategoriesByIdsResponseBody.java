package com.tychees.console.controller.inventory.response;

import java.util.List;

import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetCategoriesByIdsResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<InventoryCategoryBean> categoryList;
}
