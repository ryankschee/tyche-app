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
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.batch.BatchRequestDAO;
  
@Service("batchService")  
public class BatchService 
{ 
	@Autowired  
	BatchRequestDAO requestDao;
	
	//--------------------------------------------------------------------------
	
	@Transactional  
	public BatchRequestBean newBatchRequest(String placeId, String userId) 
	{  
		BatchRequestBean requestObj = new BatchRequestBean();
		requestObj.setPlaceId( placeId );
		requestObj.setUserId( userId );
		requestObj.setCreatedOn( new Timestamp(Calendar.getInstance().getTimeInMillis()) );
		requestObj.setCreatedBy( userId );
		
		return requestObj;
	} // .end of getRequestById  
		
	@Transactional  
	public BatchRequestBean getRequestById(String id, boolean fullBean) 
	{  
		try 
		{
			BatchRequestBean requestObj = requestDao.getBeanById(id);
			if (fullBean)
				return fillBean(requestObj);
			else
				return requestObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getRequestById  
	
	@Transactional  
	public List<BatchRequestBean> getRequestListByUser(String userId, String placeId, boolean fullBean) 
	{  
		try 
		{
			List<BatchRequestBean> requestList = requestDao.getBeansByUserId(userId, placeId);
			if (fullBean) {
				for (BatchRequestBean requestObj : requestList) {
					fillBean(requestObj);
				}
			}
			return requestList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<BatchRequestBean>();
		}
	} // .end of getRequestListByUser
	
	@Transactional  
	public void saveOrUpdateRequest(BatchRequestBean requestObj, String userId) 
	{  
		requestDao.saveOrUpdate(requestObj, userId);  
	} // .end of saveOrUpdateRequest 
  
	@Transactional  
	public void deleteRequest(BatchRequestBean requestObj) 
	{  
		requestDao.delete(requestObj);  
	} // .end of deleteRequest
	
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
