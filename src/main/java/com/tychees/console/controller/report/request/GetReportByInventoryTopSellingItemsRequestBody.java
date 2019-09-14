package com.tychees.console.controller.report.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetReportByInventoryTopSellingItemsRequestBody 
	extends AbstractWebRequestBody 
{
	public long beginTime = 0L;
	public long endTime = 0L;
	public int itemCount = 10;
	public String itemTypeList;
}
