package com.tychees.console.controller.inventory.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetCategoriesByPlaceRequestBody 
	extends AbstractWebRequestBody 
{
	public boolean filterByPosVisible = false;
	public boolean posVisible = false;
}
