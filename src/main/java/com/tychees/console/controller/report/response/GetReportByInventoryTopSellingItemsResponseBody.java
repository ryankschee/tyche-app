package com.tychees.console.controller.report.response;

import java.util.List;

import com.tychees.core.bean.report.ReportByInventoryTopSellingItemsBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetReportByInventoryTopSellingItemsResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<ReportByInventoryTopSellingItemsBean> resultList;
}
