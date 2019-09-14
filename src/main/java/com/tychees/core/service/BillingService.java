package com.tychees.core.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.billing.BillingBucketBean;
import com.tychees.core.bean.billing.BillingBucketLineBean;
import com.tychees.core.bean.billing.BillingDeliveryBean;
import com.tychees.core.bean.billing.BillingLineBean;
import com.tychees.core.bean.billing.BillingPaymentBean;
import com.tychees.core.bean.billing.BillingPaymentPropertiesBean;
import com.tychees.core.bean.billing.BillingPropertiesBean;
import com.tychees.core.bean.billing.BillingWorkflowBean;
import com.tychees.core.bean.billing.BillingWorkflowEventBean;
import com.tychees.core.bean.billing.view.BillingCompactViewBean;
import com.tychees.core.bean.billing.view.BillingViewBean;
import com.tychees.core.bean.common.CommonCalendarBean;
import com.tychees.core.bean.common.CommonCalendarEventBean;
import com.tychees.core.constants.BillingConstants;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.billing.BillingDAO;
import com.tychees.core.dao.billing.BillingDeliveryDAO;
import com.tychees.core.dao.billing.BillingLineDAO;
import com.tychees.core.dao.billing.BillingPaymentDAO;
import com.tychees.core.dao.billing.BillingPaymentPropertiesDAO;
import com.tychees.core.dao.billing.BillingPropertiesDAO;
import com.tychees.core.dao.billing.BillingBucketDAO;
import com.tychees.core.dao.billing.BillingBucketLineDAO;
import com.tychees.core.dao.billing.BillingWorkflowDAO;
import com.tychees.core.dao.billing.BillingWorkflowEventDAO;
import com.tychees.core.dao.common.CommonCalendarDAO;
import com.tychees.core.dao.common.CommonCalendarEventDAO;
import com.tychees.core.service.criteria.BillingBucketSearchCriteria;
import com.tychees.core.service.criteria.BillingSearchCriteria;
import com.tychees.core.util.BillingUtil;
import com.tychees.core.util.DateUtil;
  
@Service("billingService")  
public class BillingService 
{ 
	private final static Logger LOGGER = Logger.getLogger(BillingService.class.getName());

	@Autowired
	BillingConstants BILLING_CONSTANTS;
	@Autowired
	DateUtil dateUtil;
	@Autowired
	BillingUtil billingUtil;
	@Autowired  
	BillingDAO billingDao;  
	@Autowired  
	BillingDeliveryDAO billingDeliveryDao;
	@Autowired  
	BillingLineDAO billingLineDao;
	@Autowired  
	BillingPaymentDAO billingPaymentDao;
	@Autowired  
	BillingPaymentPropertiesDAO billingPaymentPropertiesDao;
	@Autowired  
	BillingPropertiesDAO billingPropertiesDao;
	@Autowired  
	BillingWorkflowDAO billingWorkflowDao;
	@Autowired  
	BillingWorkflowEventDAO billingWorkflowEventDao;
	@Autowired  
	CommonCalendarDAO calendarDao;
	@Autowired  
	CommonCalendarEventDAO calendarEventDao;
	@Autowired  
	BillingBucketDAO billingBucketDao;
	@Autowired  
	BillingBucketLineDAO billingBucketLineDao;
   
	//--------------------------------------------------------------------------
	
	@Transactional  
	public BillingBean getBillingById(String id, boolean fullBean) 
	{  
		try 
		{
			BillingBean billingObj = billingDao.getBeanById(id);  
			if (fullBean)
				return billingUtil.fillBean(billingObj);
			else
				return billingObj;
		} 
		catch (DAOException e) 
		{
			return null;
		}
	} // .end of getBillingById
	
	@Transactional  
	public List<BillingBean> getBillingListByIds(String ids) 
	{  
		try 
		{
			List<BillingBean> billingList = new ArrayList<BillingBean>();
			StringTokenizer tokenizer = new StringTokenizer(ids, ", ");
			while (tokenizer.hasMoreTokens()) {
				billingList.add( billingDao.getBeanById(tokenizer.nextToken()) );
			}	  
			return billingUtil.fillBeans(billingList);
		} catch (DAOException e)
		{
			return new ArrayList<BillingBean>();
		}
	} // .end of getBillingListByIds
	
	@Transactional  
	public BillingBean getBillingByBillingNo(String placeId, String billingNo, boolean fullBean) 
	{  
		try 
		{
			BillingBean billingObj = billingDao.getBeanByBillingNo(placeId, billingNo);  
			if (fullBean)
				return billingUtil.fillBean(billingObj);
			else
				return billingObj;
		}
		catch (DAOException e)
		{
			return null;
		}
	} // .end of getBillingByBillingNo

	@Transactional  
	public BillingBean getBillingByQuotationNo(String quotationNo, boolean fullBean) 
	{  
		try 
		{
			BillingBean billingObj = billingDao.getBeanByQuotationNo(quotationNo);  
			if (fullBean)
				return billingUtil.fillBean(billingObj);
			else
				return billingObj;
		}
		catch (DAOException e)
		{
			return null;
		}
	} // .end of getBillingByQuotationNo
	
	@Transactional
	public double getMonthlyBillingAmountByPlaceId(String placeId)
	{
		try
		{
			BillingSearchCriteria criteria = new BillingSearchCriteria(placeId);
			criteria.setBeginTime(dateUtil.getFirstDayOfThisMonth());
			criteria.setEndTime(dateUtil.getLastDayOfThisMonth());
			
			List<BillingBean> billingList = billingDao.getBeansByTimePeriod(criteria);		
			double totalAmount = 0;
			for (BillingBean billingObj : billingList)
				totalAmount += billingObj.getTotalAmount();
				
			return totalAmount;
		}
		catch (DAOException e)
		{
			return 0;
			
		}
	} // .end of getBillingsByPlaceId	

	@Transactional
	public List<BillingBean> getBillingsByPlaceId(BillingSearchCriteria criteria)
	{
		try
		{
			List<BillingBean> billingList = billingDao.getBeansByPlaceId(criteria);
				
			if (criteria.isFullBean())
			{
				for (BillingBean billingObj : billingList)
					billingUtil.fillBean( billingObj );
			}
			
			return billingList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingBean>();
		}
	} // .end of getBillingsByPlaceId	
	
	@Transactional
	public List<BillingBean> getBillingsByPlaceId_1(BillingSearchCriteria criteria)
	{
		try
		{
			List<BillingBean> billingList = billingDao.getBeansByPlaceId(criteria);
			LOGGER.info("BILLING SIZE: " + billingList.size());	
			int count = 0;
			for (BillingBean billingObj : billingList) {
				
				count++;
				
				LOGGER.info("READING: " + billingObj.getBillingNo() + " (" + count + " of " + billingList.size() + ")");
				
				billingUtil.fillBillingLines( billingObj );

				LOGGER.info("DONE: " + billingObj.getBillingNo() + " (" + count + " of " + billingList.size() + ")");
			}
			
			return billingList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingBean>();
		}
	} // .end of getBillingsByPlaceId	

	@Transactional
	public List<BillingViewBean> getBillingViewsByPlaceId(BillingSearchCriteria criteria)
	{
		try
		{
			List<BillingViewBean> viewList = new ArrayList<BillingViewBean>();
			List<BillingBean> billingList = billingDao.getBeansByPlaceId(criteria);
				
			for (BillingBean billingObj : billingList)
				viewList.add(new BillingViewBean(billingObj));
			
			return viewList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingViewBean>();
		}
	} // .end of getBillingsByPlaceId	

	@Transactional
	public List<BillingCompactViewBean> getBillingCompactViewsByPlaceId(BillingSearchCriteria criteria)
	{
		try
		{
			List<BillingCompactViewBean> viewList = new ArrayList<BillingCompactViewBean>();
			List<BillingBean> billingList = billingDao.getBeansByPlaceId(criteria);
				
			for (BillingBean billingObj : billingList)
				viewList.add(new BillingCompactViewBean(billingObj));
			
			return viewList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingCompactViewBean>();
		}
	} // .end of getBillingsByPlaceId	
	
	@Transactional
	public List<BillingBean> getBillingsByCustomerId(BillingSearchCriteria criteria)
	{
		try
		{
			List<BillingBean> billingList = billingDao.getBeansByCustomerId(criteria);
				
			if (criteria.isFullBean())
			{
				for (BillingBean billingObj : billingList)
					billingUtil.fillBean( billingObj );
			}
			
			return billingList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingBean>();
		}
	} // .end of getBillingsByCustomerId	  

	@Transactional
	public List<BillingCompactViewBean> getBillingCompactViewsByEmployeeId(String placeId, String employeeId)
	{
		try
		{
			List<BillingCompactViewBean> viewList = new ArrayList<BillingCompactViewBean>();
			List<BillingBean> billingList = billingDao.getBeansByEmployeeId(placeId, employeeId);
				
			for (BillingBean billingObj : billingList)
				viewList.add(new BillingCompactViewBean(billingObj));
			
			return viewList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingCompactViewBean>();
		}
	} // .end of getBillingsByPlaceId	
	
	@Transactional
	public List<BillingBean> getBillingsByBucketId(BillingSearchCriteria criteria)
	{
		try
		{
			List<BillingBean> billingList = billingDao.getBeansByBucketId(criteria);
				
			if (criteria.isFullBean())
			{
				for (BillingBean billingObj : billingList)
					billingUtil.fillBean( billingObj );
			}
			
			return billingList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingBean>();
		}
	} // .end of getBillingsByBucketId	  
	
	@Transactional
	public List<BillingBean> getBillingsByTimePeriod(BillingSearchCriteria criteria)
	{
		try
		{
			List<BillingBean> billingList = billingDao.getBeansByTimePeriod(criteria);
				
			if (criteria.isFullBean())
			{
				for (BillingBean billingObj : billingList)
					billingUtil.fillBean( billingObj );
			}
			
			return billingList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingBean>();
		}
	} // .end of getBillingsByPlaceId	

	@Transactional
	public List<BillingBean> getBillingsByPaymentTimePeriod(BillingSearchCriteria criteria)
	{
		try
		{
			Map<String, BillingBean> billingMap = new HashMap<String, BillingBean>();
			List<BillingPaymentBean> paymentList = billingPaymentDao.getBeansByTimePeriod(criteria);
			
			for (BillingPaymentBean paymentObj : paymentList) {
				if (billingMap.containsKey(paymentObj.getBillingId()))
					continue;
				if (BILLING_CONSTANTS.PAYMENT_STATUS_VOID.equals(paymentObj.getStatus()))
					continue;
				
				BillingBean billingObj = billingDao.getBeanById( paymentObj.getBillingId() );
				if (billingObj != null)
					billingMap.put(billingObj.getId(), billingObj);
			}
			
			List<BillingBean> billingList = new ArrayList<BillingBean>(billingMap.values());
				
			for (BillingBean billingObj : billingList) 
			{
				billingObj.paymentList = billingPaymentDao.getBeansByBillingId(billingObj.getId());
				for (BillingPaymentBean paymentObj : billingObj.paymentList) 
				{
					if (BILLING_CONSTANTS.PAYMENT_STATUS_VOID.equals(paymentObj.getStatus()))
						continue;
					
					paymentObj.propertiesList = 
						billingPaymentPropertiesDao.getBeansByPaymentId(paymentObj.getId());
				}		
			}
			
			return billingList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingBean>();
		}
	} // .end of getBillingsByPaymentTimePeriod	
	
	@Transactional
	public List<String> getBillingIdsByPlaceId(BillingSearchCriteria criteria)
	{
		try
		{
			List<String> billingIdList = billingDao.getBeanIdsByPlaceId(criteria);
				
			return billingIdList;
		}
		catch (DAOException e)
		{
			return new ArrayList<String>();
		}
	} // .end of getBillingsByPlaceId
	
	@Transactional  
	public void saveOrUpdateBilling(BillingBean billingObj, String userId) 
	{  
		// deliveryList
		for (BillingDeliveryBean beanObj : billingObj.deliveryList)
		{
			beanObj.setBillingId( billingObj.getId() );
			billingDeliveryDao.saveOrUpdate( beanObj, userId );
		}
		
		// lineList
		for (BillingLineBean beanObj : billingObj.lineList) 
		{
			beanObj.setBillingId( billingObj.getId() );
			billingLineDao.saveOrUpdate( beanObj, userId );
			
			// lineList
			for (BillingLineBean childBeanObj : beanObj.lineList) 
			{
				childBeanObj.setParentLineId( beanObj.getId() );
				billingLineDao.saveOrUpdate( childBeanObj, userId );
			}
			// mandatoryList
			for (BillingLineBean childBeanObj : beanObj.mandatoryList) 
			{
				childBeanObj.setParentLineId( beanObj.getId() );
				billingLineDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
		// paymentList
		for (BillingPaymentBean beanObj : billingObj.paymentList)
		{
			beanObj.setBillingId( billingObj.getId() );
			billingPaymentDao.saveOrUpdate( beanObj, userId );
			
			for (BillingPaymentPropertiesBean childBeanObj : beanObj.propertiesList) 
			{
				childBeanObj.setPaymentId( beanObj.getId() );
				billingPaymentPropertiesDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
		// propertiesList
		for (BillingPropertiesBean beanObj : billingObj.propertiesList)
		{
			beanObj.setBillingId( billingObj.getId() );
			billingPropertiesDao.saveOrUpdate( beanObj, userId );
		}
		
		// workflowList
		for (BillingWorkflowBean beanObj : billingObj.workflowList)
		{
			beanObj.setBillingId( billingObj.getId() );
			billingWorkflowDao.saveOrUpdate( beanObj, userId );
			
			for (BillingWorkflowEventBean childBeanObj : beanObj.eventList) 
			{
				childBeanObj.setWorkflowId( beanObj.getId() );
				billingWorkflowEventDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
		// calendarList
		for (CommonCalendarBean beanObj : billingObj.calendarList)
		{
			beanObj.setForeignId( billingObj.getId() );
			calendarDao.saveOrUpdate( beanObj, userId );
			
			for (CommonCalendarEventBean childBeanObj : beanObj.eventList) 
			{
				childBeanObj.setCalendarId( beanObj.getId() );
				calendarEventDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
		// Save Root bean
		billingDao.saveOrUpdate( billingObj, userId );  
		// Index bean
		if (billingObj.isDeleted())
			billingUtil.removeIndexBean( billingObj );
		else
			billingUtil.indexBean( billingObj );
	} // .end of saveOrUpdateBilling
  
	@Transactional  
	public void deleteBilling(BillingBean billingObj) 
	{  
		billingDao.delete(billingObj);  
	} // .end of deleteBilling	
	
	//----------------------------------------------------------------------------
	// BillingBucket
	
	@Transactional  
	public BillingBucketBean getBillingBucketById(String id, boolean fullBean) 
	{  
		try 
		{
			BillingBucketBean billingBucketObj = billingBucketDao.getBeanById(id);  
			if (fullBean)
				return billingUtil.fillBean(billingBucketObj);
			else
				return billingBucketObj;
		} 
		catch (DAOException e) 
		{
			return null;
		}
	} // .end of getBillingBucketById

	@Transactional
	public List<BillingBucketBean> getBillingBucketsByPlaceId(BillingBucketSearchCriteria criteria)
	{
		try
		{
			List<BillingBucketBean> bucketList = billingBucketDao.getBeansByPlaceId(criteria);
				
			if (criteria.isFullBean())
			{
				for (BillingBucketBean bucketObj : bucketList)
					billingUtil.fillBean( bucketObj );
			}
			
			return bucketList;
		}
		catch (DAOException e)
		{
			return new ArrayList<BillingBucketBean>();
		}
	} // .end of getBillingBucketsByPlaceId	

	@Transactional  
	public void saveOrUpdateBillingBucket(BillingBucketBean bucketObj, String userId) 
	{  
		// lineList
		for (BillingBucketLineBean beanObj : bucketObj.lineList) 
		{
			beanObj.setBucketId( bucketObj.getId() );
			billingBucketLineDao.saveOrUpdate( beanObj, userId );
		}		
		
		// Save Root bean
		billingBucketDao.saveOrUpdate( bucketObj, userId );  
		// Index bean
		//if (bucketObj.isDeleted())
		//	billingUtil.removeIndexBean( bucketObj );
		//else
		//	billingUtil.indexBean( bucketObj );
	} // .end of saveOrUpdateBillingBucket
  
}
