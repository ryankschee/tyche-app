package com.tychees.core.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.opportunity.OpportunityBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.opportunity.OpportunityDAO;
import com.tychees.core.service.criteria.OpportunitySearchCriteria;
import com.tychees.core.util.OpportunityUtil;
  
@Service("opportunityService")  
public class OpportunityService 
{ 
	@Autowired
	OpportunityUtil opportunityUtil;
	@Autowired  
	OpportunityDAO opportunityDao;
	
	//--------------------------------------------------------------------------
	
	@Transactional  
	public OpportunityBean getOpportunityById(String id, boolean fullBean) 
	{  
		try 
		{
			OpportunityBean opportunityObj = opportunityDao.getBeanById(id);  
			if (fullBean)
				return opportunityUtil.fillBean(opportunityObj);
			else
				return opportunityObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getOpportunityById
	
	@Transactional
	public List<OpportunityBean> getOpportunitiesByCustomerId(OpportunitySearchCriteria criteria)
	{
		try 
		{
			List<OpportunityBean> opportunityList = opportunityDao.getBeansByCustomerId(criteria);
				
			if (criteria.isFullBean())
			{
				for (OpportunityBean opportunityObj : opportunityList)
					opportunityUtil.fillBean( opportunityObj );
			}
			
			return opportunityList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<OpportunityBean>();
		}
	} // .end of getOpportunitiesByCustomerId	  

	@Transactional
	public List<OpportunityBean> getOpportunitiesByEmployeeId(String placeId, String employeeId)
	{
		try 
		{
			List<OpportunityBean> opportunityList = opportunityDao.getBeansByEmployeeId(placeId, employeeId);
				
			return opportunityList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<OpportunityBean>();
		}
	} // .end of getOpportunitiesByEmployeeId	  
	
	@Transactional  
	public void saveOrUpdateOpportunity(OpportunityBean opportunityObj, String userId) 
	{  
		// Save Root bean
		opportunityDao.saveOrUpdate(opportunityObj, userId);  
		// Index bean
		opportunityUtil.indexBean(opportunityObj);
	} // .end of saveOrUpdateOpportunity
  
	@Transactional  
	public void deleteOpportunity(OpportunityBean opportunityObj) 
	{  
		opportunityDao.delete(opportunityObj);  
	} // .end of deleteOpportunity
}
