package com.tychees.console.controller.opportunity.response;

import java.util.List;

import com.tychees.core.bean.opportunity.OpportunityBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetOpportunitiesByEmployeeResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<OpportunityBean> opportunityList;
}
