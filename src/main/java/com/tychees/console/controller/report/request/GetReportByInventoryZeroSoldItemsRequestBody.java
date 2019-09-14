package com.tychees.console.controller.report.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetReportByInventoryZeroSoldItemsRequestBody 
	extends AbstractWebRequestBody 
{
	public long beginTime = 0L;
	public long endTime = 0L;
	public int itemCount = 9999;
	public String itemTypeList;
}
