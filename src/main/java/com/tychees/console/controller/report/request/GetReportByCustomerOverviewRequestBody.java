package com.tychees.console.controller.report.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetReportByCustomerOverviewRequestBody 
	extends AbstractWebRequestBody 
{
	public long beginTime = 0L;
	public long endTime = 0L;
	
	public String typeList = "";
	public String stateList = "";
	public String areaList = "";
	public String cityList = "";
}
