package com.tychees.core.util;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tychees.core.bean.opportunity.OpportunityBean;
import com.tychees.core.dao.opportunity.OpportunityDAO;
import com.tychees.core.service.IndexService;

@Component
public class OpportunityUtil {

    @Autowired  
	OpportunityDAO opportunityDao;  
    @Autowired  
	IndexService indexService; 
	
	public List<OpportunityBean> fillBeans(List<OpportunityBean> opportunityList) 
	{
		for (OpportunityBean opportunityObj : opportunityList)
		{
			fillBean(opportunityObj);
		}
		
		return opportunityList;
	} // .end of fillBeans
	
	/**
	 * Full Structure of OpportunityBean
	 * -----------------------------
	 * OpportunityBean
	 * |- xxxx
	 */ 
	public OpportunityBean fillBean(OpportunityBean opportunityObj) 
	{  
		if (opportunityObj != null)
		{
			// Set fullBeanLoaded state
			opportunityObj.setFullBeanLoaded( true );
			opportunityObj.setHasChanged( false );
			
		}
		
		return opportunityObj;
	} // .end of fillBean
	
	/**
	 * Perform indexing on OpportunityBean.
	 */ 
	public void indexBean(OpportunityBean opportunityObj) 
	{
		if (indexService.validateBean(opportunityObj.getPlaceId(), opportunityObj))
		{
			// Indexing Starts
			indexService.saveTermsAsIndex(opportunityObj, "opportunityNo", opportunityObj.getOpportunityNo());
			indexService.saveTermsAsIndex(opportunityObj, "name", opportunityObj.getName());
			indexService.saveTermsAsIndex(opportunityObj, "state", opportunityObj.getStateDesc());
		}
	} // .end of indexBean
	
	/**
	 * Remove indexing on OpportunityBean.
	 */ 
	public void removeIndexBean(OpportunityBean opportunityObj) 
	{
		indexService.removeTermsByBean(opportunityObj);
	} // .end of removeIndexBean
}