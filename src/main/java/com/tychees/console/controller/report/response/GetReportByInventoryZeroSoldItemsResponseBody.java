package com.tychees.console.controller.report.response;

import java.util.List;

import com.tychees.core.bean.report.ReportByInventoryZeroSoldItemsBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetReportByInventoryZeroSoldItemsResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<ReportByInventoryZeroSoldItemsBean> resultList;
}
