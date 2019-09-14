package com.tychees.core.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.tychees.core.bean.BeanSuperClass;
import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.billing.view.BillingViewBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.customer.view.CustomerViewBean;
import com.tychees.core.bean.index.IndexMasterBean;
import com.tychees.core.bean.index.IndexTermBean;
import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.view.InventoryCategoryViewBean;
import com.tychees.core.bean.inventory.view.InventoryItemViewBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.constants.BeanConstants;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.index.IndexMasterDAO;
import com.tychees.core.dao.index.IndexTermDAO;
import com.tychees.core.util.IndexUtil;
  
@Service("indexService")  
public class IndexService 
{ 
	@Autowired
	AppConstants appConstants;
	@Autowired
	BeanConstants beanConstants;
	@Autowired
	IndexUtil indexUtil;
	@Autowired
	IndexMasterDAO indexMasterDao;
	@Autowired
	IndexTermDAO indexTermDao;
   
	private final static Logger LOGGER = Logger.getLogger(IndexService.class.getName());
	
	//--------------------------------------------------------------------------
	
	@Transactional
	public boolean validateBean(String placeId, BeanSuperClass beanObj)
	{
		try 
		{
		    IndexMasterBean masterObj = indexMasterDao.getBeanByBeanId(beanObj.getId());
			
			// IF bean has never been indexed before, 
			// THEN (1) create a new entry at  master index.
			if (masterObj==null)
			{
				masterObj = indexUtil.newIndexMasterObj(placeId, beanObj);
				indexMasterDao.saveOrUpdate(masterObj, IndexUtil.USER_SYSTEM_INDEXER);
			}
			// IF bean has been indexed before,
			// THEN (1) remove all previously indexed term(s)
			//      (2) update entry at master index
			else
			{
			    // Step 1
				List<IndexTermBean> indexTermList = indexTermDao.getBeansByBeanId(beanObj.getId());
				for (IndexTermBean termObj : indexTermList) 
				{
					termObj.setDeletedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
					termObj.setDeletedBy(IndexUtil.USER_SYSTEM_INDEXER);
					indexTermDao.saveOrUpdate(termObj, IndexUtil.USER_SYSTEM_INDEXER);
				}
				
				// Step 2
				masterObj.setLastIndexedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				indexMasterDao.saveOrUpdate(masterObj, IndexUtil.USER_SYSTEM_INDEXER);
			}
			
			return true;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return false;
		}
	} // .end of validateBean
	
	@Transactional
	public List<IndexTermBean> search(String placeId, List<String> keywordList, boolean searchByCustomer, boolean searchByBilling, boolean searchByCategory, boolean searchByItem, boolean searchByPlace)
	{
		try 
		{
			//return indexTermDao.getBeansByTerm_exactMatch(placeId, keywordList, false, searchByCustomer, searchByBilling, searchByCategory, searchByItem, searchByPlace);
			
			List<IndexTermBean> result = new ArrayList<>();
			for (String keyword : keywordList) {
				List<IndexTermBean> partialResult = indexTermDao.getBeansByTerm_wildcardMatch(
						placeId, keyword, false, searchByCustomer, searchByBilling, searchByCategory, searchByItem, searchByPlace);
				
				result.addAll(partialResult);
			}
			
			return result;
			
			/*
		    Map<String, IndexTermBean> indexMap = new HashMap<String, IndexTermBean>();
			for (String term : keywordList) 
			{
			    if (indexUtil.isTermIndexable(term))
			    {

					long t1 = Calendar.getInstance().getTimeInMillis(); 
					
			    	List<IndexTermBean> list = indexTermDao.getBeansByTerm_wildcardMatch(placeId, term, false, searchByCustomer, searchByBilling, searchByCategory, searchByItem, searchByPlace);
			    	for (IndexTermBean resultObj : list)
			    	{
			    		if (indexMap.containsKey(resultObj.getBeanId()))
			    			continue;
			    			
			    		indexMap.put(resultObj.getBeanId(), resultObj);
			    	}
			    }
			}
			
			List<IndexTermBean> indexList = new ArrayList<IndexTermBean>();
			if (indexMap!=null)
				indexList = new ArrayList<IndexTermBean>(indexMap.values()); 
			return indexList;
			*/
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<IndexTermBean>();
		}
	} // .end of search
	
	/**
	 * Save term as index object.
	 * If found existing one with same beanId & term, then update; else create.
	 */ 
	@Transactional
	public void saveTermsAsIndex(BeanSuperClass beanObj, String synopsysKey, String terms)
	{
		try 
		{
			if (terms == null)
				return;
			if (synopsysKey == null)
				synopsysKey = "";
			
			// Split terms into multiple token, if any. e.g. "Xyz Eds" -> "Xyz", "Eds"
			StringTokenizer tokenizer = new StringTokenizer(terms, " ");
			
			while (tokenizer.hasMoreTokens()) 
			{
				String term = tokenizer.nextToken();
				if (indexUtil.isTermIndexable(term))
				{
					IndexTermBean indexObj = indexTermDao.getBeanByCompositeId(beanObj.getId(), term);
					
					if (indexObj==null) 
					{
						indexObj = indexUtil.newIndexTermObj();
						indexObj.setBeanId(beanObj.getId());
						indexObj.setBeanClassName(beanObj.getBeanName());
						indexObj.setBeanDisplayName(beanObj.getDisplayName());
						indexObj.setTerm(term);
						indexObj.setFrequency(0);
						indexObj.setPosition("");
						indexObj.addSynopsys(synopsysKey + ":" + term);
						
						Gson gson = new Gson();
						
						if (beanConstants.BEAN_CLASS_NAME_BILLING.equalsIgnoreCase(beanObj.getBeanName()))
						{
							BillingViewBean viewObj = new BillingViewBean( (BillingBean) beanObj );
							indexObj.setPlaceId( ((BillingBean) beanObj).getPlaceId() );
							indexObj.setViewBean( gson.toJson(viewObj) );
						}
						
						if (beanConstants.BEAN_CLASS_NAME_CUSTOMER.equalsIgnoreCase(beanObj.getBeanName()))
						{
							CustomerViewBean viewObj = new CustomerViewBean( (CustomerBean) beanObj );
							indexObj.setPlaceId( ((CustomerBean) beanObj).getPlaceId() );
							indexObj.setViewBean( gson.toJson(viewObj) );
						}
						
						if (beanConstants.BEAN_CLASS_NAME_INVENTORY_CATEGORY.equalsIgnoreCase(beanObj.getBeanName()))
						{
							InventoryCategoryViewBean viewObj = new InventoryCategoryViewBean( (InventoryCategoryBean) beanObj );
							indexObj.setPlaceId( ((InventoryCategoryBean) beanObj).getPlaceId() );
							indexObj.setViewBean( gson.toJson(viewObj) );
						}
						
						if (beanConstants.BEAN_CLASS_NAME_INVENTORY_ITEM.equalsIgnoreCase(beanObj.getBeanName()))
						{
							InventoryItemViewBean viewObj = new InventoryItemViewBean( (InventoryItemBean) beanObj );
							indexObj.setPlaceId( ((InventoryItemBean) beanObj).getPlaceId() );
							indexObj.setViewBean( gson.toJson(viewObj) );
						}
					} 
					else 
					{
						indexObj.setFrequency(indexObj.getFrequency()+1);
					}
					
					indexTermDao.saveOrUpdate(indexObj, IndexUtil.USER_SYSTEM_INDEXER);
				}
			}
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
		}
	} // .end of saveTermsAsIndex
	
	/**
	 * Remove all terms by bean id.
	 */ 
	@Transactional
	public void removeTermsByBean(BeanSuperClass beanObj)
	{
		try 
		{
			List<IndexTermBean> termList = indexTermDao.getBeansByBeanId(beanObj.getId());
			for (IndexTermBean termObj : termList)
			{
				termObj.setDeletedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				termObj.setDeletedBy(IndexUtil.USER_SYSTEM_INDEXER);
				
				indexTermDao.saveOrUpdate(termObj, IndexUtil.USER_SYSTEM_INDEXER);
			}
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
		}
	} // .end of removeTermsByBean
}
