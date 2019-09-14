package com.tychees.console.controller.report.response;

import java.util.List;

import com.tychees.core.bean.report.ReportByCustomerOverviewBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetReportByCustomerOverviewResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<ReportByCustomerOverviewBean> resultList;
}
