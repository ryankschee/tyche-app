package com.tychees.core.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.batch.BatchRequestBean;
import com.tychees.core.bean.patch.PatchCustomerBean;
import com.tychees.core.bean.patch.PatchMeasureBean;
import com.tychees.core.bean.patch.PatchMeasureBillingBean;
import com.tychees.core.bean.patch.PatchPaymentBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao._patch.PatchCustomerDAO;
import com.tychees.core.dao._patch.PatchMeasureBillingDAO;
import com.tychees.core.dao._patch.PatchMeasureDAO;
import com.tychees.core.dao._patch.PatchPaymentDAO;
import com.tychees.core.dao.batch.BatchRequestDAO;
  
@Service("patchService")  
public class PatchService 
{ 
	@Autowired  
	PatchCustomerDAO patchCustomerDao;
	@Autowired  
	PatchMeasureDAO patchMeasureDao;
	@Autowired  
	PatchMeasureBillingDAO patchMeasureBillingDao;
	@Autowired  
	PatchPaymentDAO patchPaymentDao;
	
	//--------------------------------------------------------------------------
	
	@Transactional
	public List<PatchCustomerBean> getAllCustomers()
	{
		try {
			List<PatchCustomerBean> customerList = patchCustomerDao.getAll();
			
			return customerList;
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Transactional
	public PatchCustomerBean getCustomerById(String id)
	{
		try {
			return patchCustomerDao.getBeanById(id);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	

	@Transactional
	public List<PatchMeasureBean> getAllMeasures()
	{
		try {
			List<PatchMeasureBean> measureList = patchMeasureDao.getAll();
			
			return measureList;
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
		

	@Transactional
	public List<PatchMeasureBillingBean> getMeasureBillingsByMeasureId(String id)
	{
		try {
			return patchMeasureBillingDao.getBeansByMeasureId(id);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	

	@Transactional
	public List<PatchPaymentBean> getPaymentsByMeasureId(String id)
	{
		try {
			return patchPaymentDao.getBeansByMeasureId(id);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	//--------------------------------------------------------------------------
	
	/**
	 * Full Structure of BatchRequestBean
	 * -----------------------------
	 * BatchRequestBean
	 */ 
	private BatchRequestBean fillBean(BatchRequestBean requestObj) 
	{  
		if (requestObj != null)
		{
			// Set state: fullBeanLoaded
			requestObj.setFullBeanLoaded( true );
		}
		
		return requestObj;
	} // .end of fillBean
}
