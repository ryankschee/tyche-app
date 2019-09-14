package com.tychees.console.controller.inventory.response;

import java.util.List;

import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.inventory.view.InventoryCategoryViewBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetCategoriesByPlaceResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<InventoryCategoryBean> categoryList;
	public List<InventoryCategoryViewBean> viewList;
}
