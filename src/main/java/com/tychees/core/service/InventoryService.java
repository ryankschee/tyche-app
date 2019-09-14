package com.tychees.core.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.inventory.InventoryCategoryPropertiesBean;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.InventoryItemComponentBean;
import com.tychees.core.bean.inventory.InventoryItemPropertiesBean;
import com.tychees.core.bean.inventory.InventoryItemRuleBean;
import com.tychees.core.bean.inventory.InventoryItemTransactionBean;
import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.bean.inventory.InventoryTransactionLineBean;
import com.tychees.core.bean.inventory.view.InventoryCategoryViewBean;
import com.tychees.core.bean.inventory.view.InventoryItemCompactViewBean;
import com.tychees.core.bean.inventory.view.InventoryItemViewBean;
import com.tychees.core.constants.InventoryConstants;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.inventory.InventoryCategoryDAO;
import com.tychees.core.dao.inventory.InventoryCategoryPropertiesDAO;
import com.tychees.core.dao.inventory.InventoryItemDAO;
import com.tychees.core.dao.inventory.InventoryItemComponentDAO;
import com.tychees.core.dao.inventory.InventoryItemImageDAO;
import com.tychees.core.dao.inventory.InventoryItemPropertiesDAO;
import com.tychees.core.dao.inventory.InventoryItemRuleDAO;
import com.tychees.core.dao.inventory.InventoryItemTransactionDAO;
import com.tychees.core.dao.inventory.InventoryTransactionDAO;
import com.tychees.core.dao.inventory.InventoryTransactionLineDAO;
import com.tychees.core.service.criteria.InventorySearchCriteria;
import com.tychees.core.util.InventoryUtil;
  
@Service("inventoryService")  
public class InventoryService 
{ 
	@Autowired
	InventoryConstants inventoryConstants;
	@Autowired
	InventoryUtil inventoryUtil;
	@Autowired  
	InventoryCategoryDAO inventoryCategoryDao;  
	@Autowired  
	InventoryCategoryPropertiesDAO inventoryCategoryPropertiesDao;  
	@Autowired  
	InventoryItemDAO inventoryItemDao;
	@Autowired  
	InventoryItemComponentDAO inventoryItemComponentDao;
	@Autowired  
	InventoryItemImageDAO inventoryItemImageDao;
	@Autowired  
	InventoryItemRuleDAO inventoryItemRuleDao;
	@Autowired  
	InventoryItemPropertiesDAO inventoryItemPropertiesDao;
	@Autowired  
	InventoryItemTransactionDAO inventoryItemTransactionDao;
	@Autowired  
	InventoryTransactionDAO inventoryTransactionDao;
	@Autowired  
	InventoryTransactionLineDAO inventoryTransactionLineDao;
   
	private final static Logger LOGGER = Logger.getLogger(InventoryService.class.getName());

	//--------------------------------------------------------------------------
	
	@Transactional  
	public void patchItem(int from, int to) 
	{  
		try
		{
			List<InventoryItemBean> itemList = inventoryItemDao.getAllBeans();
			for (int i=from ; i<to ; i++) {
				InventoryItemBean itemObj = itemList.get(i);
				
				inventoryUtil.fillBean(itemObj, false);
				
				this.saveOrUpdateItem(itemObj, "ryanchee");
			}
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
		}
	} // .end of patchItem
	
	//--------------------------------------------------------------------------
	
	@Transactional  
	public InventoryCategoryBean getCategoryById(String id, boolean fullBean) 
	{  
		try 
		{
			InventoryCategoryBean categoryObj = inventoryCategoryDao.getBeanById(id);  
			if (fullBean) 
			{
				categoryObj.itemGroupList = this.getItemGroupsByCategoryId(categoryObj.getId());
				inventoryUtil.fillBean(categoryObj);
			}
			
			return categoryObj;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return null;
		}
	} // .end of getCategoryById

	@Transactional  
	public List<InventoryCategoryBean> getCategoryListByIds(String ids) 
	{  
		try 
		{
			List<InventoryCategoryBean> categoryList = new ArrayList<InventoryCategoryBean>();
			StringTokenizer tokenizer = new StringTokenizer(ids, ", ");
			while (tokenizer.hasMoreTokens()) {
				categoryList.add(
					inventoryUtil.fillBean(
						this.inventoryCategoryDao.getBeanById(tokenizer.nextToken())) );
			}	  
			return categoryList;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<InventoryCategoryBean>();
		}
	} // .end of getCategoryListByIds

	@Transactional
	public Long getCategoryCountByPlaceId(String placeId)
	{
		try 
		{
			return inventoryCategoryDao.getBeanCountByPlaceId(placeId);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return 0L;
		}
	} // .end of getCategoryCountByPlaceId

	@Transactional
	public List<InventoryCategoryBean> getCategoriesByPlaceId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<InventoryCategoryBean> categoryList = inventoryCategoryDao.getBeansByPlaceId(criteria);
				
			for (InventoryCategoryBean categoryObj : categoryList)
			{
				if (criteria.isFullBean())
					inventoryUtil.fillBean( categoryObj );
				
				InventorySearchCriteria categoryCriteria = criteria.clone();
				categoryCriteria.setCategoryId(categoryObj.getId());
				
				categoryObj.itemSize = this.getItemCountByCategoryId(categoryCriteria);
				categoryObj.itemGroupList = this.getItemGroupsByCategoryId(categoryObj.getId());			
			}
			
			return categoryList;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<InventoryCategoryBean>();
		}
	} // .end of getCategoriesByPlaceId
	
	@Transactional
	public List<InventoryCategoryViewBean> getCategoryViewsByPlaceId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<InventoryCategoryViewBean> viewList = new ArrayList<InventoryCategoryViewBean>();
			List<InventoryCategoryBean> categoryList = inventoryCategoryDao.getBeansByPlaceId(criteria);
				
			for (InventoryCategoryBean categoryObj : categoryList)
			{
				viewList.add(new InventoryCategoryViewBean(categoryObj));		
			}
			
			return viewList;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<InventoryCategoryViewBean>();
		}
	} // .end of getCategoryViewsByPlaceId

	@Transactional
	public List<InventoryCategoryBean> getCategoriesByParentCategory(InventorySearchCriteria criteria)
	{
		try 
		{
			List<InventoryCategoryBean> categoryList = inventoryCategoryDao.getBeansByParentCategoryId(criteria);
				
			for (InventoryCategoryBean categoryObj : categoryList)
			{
				if (criteria.isFullBean())
					inventoryUtil.fillBean( categoryObj );
				
				InventorySearchCriteria categoryCriteria = criteria.clone();
				categoryCriteria.setCategoryId(categoryObj.getId());
				
				categoryObj.itemSize = this.getItemCountByCategoryId(categoryCriteria);
				categoryObj.itemGroupList = this.getItemGroupsByCategoryId(categoryObj.getId());			
			}
			
			return categoryList;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<InventoryCategoryBean>();
		}
	} // .end of getCategoriesByParentCategory

	@Transactional
	public List<String> getCategoryIdsByPlaceId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<String> categoryList = inventoryCategoryDao.getBeanIdsByPlaceId(criteria);
			return categoryList;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<String>();
		}
	} // .end of getCategoryIdsByPlaceId
	  
	@Transactional  
	public void saveOrUpdateCategory(InventoryCategoryBean categoryObj, String userId) 
	{  
		for (InventoryCategoryPropertiesBean beanObj : categoryObj.propertiesList)
		{
			beanObj.setCategoryId( categoryObj.getId() );
			inventoryCategoryPropertiesDao.saveOrUpdate( beanObj, userId );
		}
		
		// Save Root Bean
		inventoryCategoryDao.saveOrUpdate(categoryObj, userId); 
		// Index Bean
		if (categoryObj.isDeleted())
			inventoryUtil.removeIndexBean(categoryObj);
		else
			inventoryUtil.indexBean(categoryObj);
	} // .end of saveOrUpdateCategory
    
	@Transactional  
	public void deleteCategory(InventoryCategoryBean categoryObj) 
	{  
		inventoryCategoryDao.delete(categoryObj);  
	} // .end of deleteCategory
	
	@Transactional  
	public InventoryItemBean getItemById(String id, boolean fullBean, boolean loadImages) 
	{  
		try 
		{
			InventoryItemBean itemObj = inventoryItemDao.getBeanById(id); 
			if (itemObj == null)
				return null;
				
			if (itemObj.getAvailability()==null || "".equals(itemObj.getAvailability()))
				itemObj.setAvailability( inventoryUtil.isItemAvailable(itemObj.getId(), null) );
			
			if (fullBean == true)
				return inventoryUtil.fillBean(itemObj, loadImages);
			else
				return itemObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getItemById

	@Transactional  
	public InventoryItemBean getItemByName(String name, boolean fullBean, boolean loadImages) 
	{  
		try 
		{
			InventoryItemBean itemObj = inventoryItemDao.getBeanByName(name); 
			if (itemObj == null)
				return null;
				
			if (itemObj.getAvailability()==null || "".equals(itemObj.getAvailability()))
				itemObj.setAvailability( inventoryUtil.isItemAvailable(itemObj.getId(), null) );
			
			if (fullBean == true)
				return inventoryUtil.fillBean(itemObj, loadImages);
			else
				return itemObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getItemById

	@Transactional
	public Long getItemCountByPlaceId(String placeId)
	{
		try 
		{
			return inventoryItemDao.getBeanCountByPlaceId(placeId);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return 0L;
		}
	} // .end of getItemCountByPlaceId

	@Transactional  
	public List<InventoryItemBean> getItemListByIds(String ids) 
	{  
		try 
		{
			List<InventoryItemBean> itemList = new ArrayList<InventoryItemBean>();
			StringTokenizer tokenizer = new StringTokenizer(ids, ", ");
			while (tokenizer.hasMoreTokens()) {
				itemList.add(
					inventoryUtil.fillBean(
						this.inventoryItemDao.getBeanById(tokenizer.nextToken()), false));
				//itemList.add( this.inventoryItemDao.getBeanById(tokenizer.nextToken()) );
			}	
			
			for (InventoryItemBean itemObj : itemList) 
			{
				if (itemObj.getAvailability()==null || "".equals(itemObj.getAvailability()))
					itemObj.setAvailability( inventoryUtil.isItemAvailable(itemObj, null) );
			}
			
			return itemList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryItemBean>();
		}
	} // .end of getItemListByIds
	
	@Transactional
	public List<InventoryItemBean> getItemsByCategoryId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<InventoryItemBean> itemList = inventoryItemDao.getBeansByCategoryId(criteria);
	
			for (InventoryItemBean itemObj : itemList) 
			{
				if (itemObj.getAvailability()==null || "".equals(itemObj.getAvailability()))
					itemObj.setAvailability( inventoryUtil.isItemAvailable(itemObj, null) );
				if (criteria.isFullBean())
					inventoryUtil.fillBean(itemObj, false);
			}
			
			// Add dependent child item(s), from component.ids
			addComponentItems(criteria, itemList);
			
			return itemList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryItemBean>();
		}
	} // .end of getItemsByCategoryId
	
	@Transactional
	public List<InventoryItemViewBean> getItemViewsByCategoryId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<InventoryItemViewBean> itemViewList = new ArrayList<InventoryItemViewBean>();
			List<InventoryItemBean> itemList = inventoryItemDao.getBeansByCategoryId(criteria);
			for (InventoryItemBean itemObj : itemList) {
				itemViewList.add(new InventoryItemViewBean(itemObj));
			}
			return itemViewList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryItemViewBean>();
		}
	} // .end of getItemViewsByCategoryId
	
	@Transactional
	public List<InventoryItemBean> getItemsByPlaceId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<InventoryItemBean> itemList = inventoryItemDao.getBeansByPlaceId(criteria);
	
			for (InventoryItemBean itemObj : itemList) {
				if (itemObj.getAvailability()==null || "".equals(itemObj.getAvailability()))
					itemObj.setAvailability( inventoryUtil.isItemAvailable(itemObj, null) );
	
				if (criteria.isFullBean())
				{
					inventoryUtil.fillBean(itemObj, false);				
				}
			}
			
			// Add dependent child item(s), from component.ids
			addComponentItems(criteria, itemList);
			
			return itemList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryItemBean>();
		}
	} // .end of getItemsByPlaceId

	@Transactional
	public List<InventoryItemViewBean> getItemViewsByPlaceId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<InventoryItemViewBean> viewList = new ArrayList<InventoryItemViewBean>();
			List<InventoryItemBean> itemList = inventoryItemDao.getBeansByPlaceId(criteria);
	
			for (InventoryItemBean itemObj : itemList) {
				viewList.add(new InventoryItemViewBean(itemObj));
			}
			
			return viewList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryItemViewBean>();
		}
	} // .end of getItemViewsByPlaceId
	
	@Transactional
	public List<InventoryItemBean> listComponentItemsByItemId(InventorySearchCriteria criteria)
	{
		try 
		{
			// Result list
			List<InventoryItemBean> itemList = new ArrayList<InventoryItemBean>();
			// Get current item object
			InventoryItemBean itemObj = inventoryItemDao.getBeanById(criteria.getItemId());
			if (itemObj==null)
				return itemList;
			
			List<InventoryItemComponentBean> componentList = inventoryItemComponentDao.getBeansByItemId(itemObj.getId());
			for (InventoryItemComponentBean componentObj : componentList) 
			{		
				// SKIP, if request DO NOT WANT mandatory && current component is mandatory
				if (criteria.isMandatory()==false && componentObj.isSelectable()==false)
					continue;
				// SKIP, if request DO NOT WANT optional && current component is optional
				if (criteria.isOptional()==false && componentObj.isSelectable()==true)
					continue;
							
				// ids
				StringTokenizer idsTokenizer = new StringTokenizer(componentObj.getItemIds(), ",");
				while (idsTokenizer.hasMoreTokens()) 
				{
					itemList.add( inventoryItemDao.getBeanById(idsTokenizer.nextToken()) );
				}
				
				// tags
				StringTokenizer tagsTokenizer = new StringTokenizer(componentObj.getTags(), ",");
				while (tagsTokenizer.hasMoreTokens()) 
				{
					itemList.addAll( inventoryItemDao.getBeansByLabel(tagsTokenizer.nextToken()) );
				}
			}		
			/*
			for (InventoryItemBean obj : itemList) {
	
				if (obj.getAvailability()==null || "".equals(obj.getAvailability()))
					obj.setAvailability( inventoryUtil.isItemAvailable(obj, null) );
				if (criteria.isFullBean() && !obj.isFullBeanLoaded())
					inventoryUtil.fillBean( obj );
			}*/
			
			return itemList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryItemBean>();
		}
	} // .end of listComponentItemsByItemId
	
	@Transactional
	public List<InventoryItemCompactViewBean> listComponentItemViewsByItemId(InventorySearchCriteria criteria)
	{
		try 
		{
			// Result list
			List<InventoryItemCompactViewBean> itemList = new ArrayList<InventoryItemCompactViewBean>();
			// Get current item object
			InventoryItemBean itemObj = inventoryItemDao.getBeanById(criteria.getItemId());
			if (itemObj==null)
				return itemList;
			
			List<InventoryItemComponentBean> componentList = inventoryItemComponentDao.getBeansByItemId(itemObj.getId());
			for (InventoryItemComponentBean componentObj : componentList) 
			{		
				// ids
				StringTokenizer idsTokenizer = new StringTokenizer(componentObj.getItemIds(), ",");
				while (idsTokenizer.hasMoreTokens()) 
				{
					String itemId = idsTokenizer.nextToken();
					if (itemId != null && !"".equals(itemId.trim()))
					{
						InventoryItemBean itemObj1 = inventoryItemDao.getBeanById( itemId );
						if (itemObj1 != null)
							itemList.add( new InventoryItemCompactViewBean( itemObj1 ) );
					}
				}
				
				// tags
				StringTokenizer tagsTokenizer = new StringTokenizer(componentObj.getTags(), ",");
				while (tagsTokenizer.hasMoreTokens()) 
				{
					String tag = tagsTokenizer.nextToken();
					if (tag != null && !"".equals(tag.trim())) 
					{
						List<InventoryItemCompactViewBean> list = inventoryItemDao.getCompactViewBeansByLabel( tag );
						itemList.addAll( list );
					}
				}
			}	
			
			return itemList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryItemCompactViewBean>();
		}
	} // .end of listComponentItemsByItemId
	
	@Transactional
	public List<InventoryItemBean> getDependentItemsByItemId(InventorySearchCriteria criteria)
	{
		try 
		{
			// Result list
			List<InventoryItemBean> itemList = new ArrayList<InventoryItemBean>();
			// Get current item object
			InventoryItemBean itemObj = inventoryItemDao.getBeanById(criteria.getItemId());
			
			if (itemObj!=null)
			{
				//List<InventoryItemComponentBean> componentList =
				//		new ArrayList<InventoryItemComponentBean>();			
				List<InventoryItemComponentBean> componentList1 = 
						inventoryItemComponentDao.getDependentBeansByItemIds(itemObj.getId());
				List<InventoryItemComponentBean> componentList2 =
						new ArrayList<InventoryItemComponentBean>();
				
				// Get list of dependent component, by tag
				StringTokenizer tokenizer = new StringTokenizer(itemObj.getLabels(), ",");
				while(tokenizer.hasMoreTokens()) {
					componentList2.addAll( 
						inventoryItemComponentDao.getDependentBeansByTag( tokenizer.nextToken() ) );
				}
				
				// Filter #1
				for (InventoryItemComponentBean componentObj : componentList1) {
					
					if (componentObj==null)
						continue;
					
					boolean itemInList = false;
					for (InventoryItemBean itemObjInList : itemList) {
						if (itemObjInList==null || itemObjInList.getId()==null)
							continue;
						
						if (itemObjInList.getId().equals(componentObj.getItemId())) {
							itemInList = true;
							break;
						}
					}
					
					if (itemInList==false)
						itemList.add( inventoryItemDao.getBeanById(componentObj.getItemId()) );
				}
				
				// Filter #2			
				for (InventoryItemComponentBean componentObj : componentList2) {
					
					boolean itemInList = false;
					for (InventoryItemBean itemObjInList : itemList) {
						if (itemObjInList.getId().equals(componentObj.getItemId())) {
							itemInList = true;
							break;
						}
					}
					
					if (itemInList==false) 
					{
						InventoryItemBean itemObj1 = inventoryItemDao.getBeanById(componentObj.getItemId());
						if (itemObj1 != null)
							itemList.add(itemObj1);
					}
				}
			}
			
			for (InventoryItemBean itemObj1 : itemList) 
			{
				if (itemObj1.getAvailability()==null || "".equals(itemObj1.getAvailability()))
					itemObj1.setAvailability( inventoryUtil.isItemAvailable(itemObj1.getId(), null) );
			}
					
			return itemList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryItemBean>();
		}
	} // .end of getDependentItemsByItemId

	@Transactional
	public Long getItemCountByPlaceId(InventorySearchCriteria criteria)
	{
		try 
		{
			return inventoryItemDao.getBeanCountByPlaceId(criteria);
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return 0L;
		}
	} // .end of getItemCountByPlaceId
	
	@Transactional
	public Long getItemCountByCategoryId(InventorySearchCriteria criteria)
	{
		try 
		{
			return inventoryItemDao.getBeanCountByCategoryId(criteria);
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return 0L;
		}
	} // .end of getItemCountByCategoryId
	
	@Transactional
	public List<String> getItemGroupsByCategoryId(String categoryId)
	{
		try 
		{
			return inventoryItemDao.getBeanGroupsByCategoryId(categoryId);
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<String>();
		}
	} // .end of getItemGroupsByCategoryId
	
	@Transactional
	public List<String> getItemIdsByPlaceId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<String> itemList = inventoryItemDao.getBeanIdsByPlaceId(criteria);
			return itemList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<String>();
		}
	} // .end of getItemsByPlaceId
	  
	/**
     * If criteria.loadComponentItems is <code>true</code>:
     * - Add item(s) from item.component.itemIds 
     *
     * @param   criteria   	InventorySearchCriteria
     * @param   itemList	
     */
	private void addComponentItems(InventorySearchCriteria criteria, List<InventoryItemBean> itemList)
	{
		if (criteria.isLoadComponentItems()==false)
			return;
		
		List<InventoryItemBean> newList = new ArrayList<InventoryItemBean>();		
		for (InventoryItemBean itemObj : itemList) 
		{
			for (InventoryItemComponentBean componentObj : itemObj.componentList)
			{
				StringTokenizer tokenizer = new StringTokenizer(componentObj.getItemIds(), ",");
				while (tokenizer.hasMoreTokens())
				{
					InventoryItemBean childItemObj = this.getItemById(tokenizer.nextToken(), itemObj.isFullBeanLoaded(), false);
					
					// Check if this childItemObj has been added.
					boolean beanExist = false;
					for (InventoryItemBean tmpObj : itemList) 
					{
						if (tmpObj.getId().equals(childItemObj.getId()))
						{
							beanExist = true;
							break;
						}
					}
										
					if (beanExist==false)
					{
						newList.add( childItemObj );
					}
				}
			}
		}
		
		itemList.addAll(newList);
	} // .end of addComponentItems
	
	@Transactional  
	public void saveOrUpdateItem(InventoryItemBean itemObj, String userId) 
	{  
		for (InventoryItemComponentBean beanObj : itemObj.componentList)
		{
			beanObj.setItemId( itemObj.getId() );
			inventoryItemComponentDao.saveOrUpdate(beanObj, userId);
		}
		
		//for (InventoryItemImageBean beanObj : itemObj.imageList)
		//{
		//	beanObj.setItemId( itemObj.getId() );
		//	inventoryItemImageDao.saveOrUpdate(beanObj, userId);
		//}
		
		for (InventoryItemPropertiesBean beanObj : itemObj.propertiesList)
		{
			beanObj.setItemId( itemObj.getId() );
			inventoryItemPropertiesDao.saveOrUpdate(beanObj, userId);
		}

		for (InventoryItemRuleBean beanObj : itemObj.ruleList)
		{
			beanObj.setItemId( itemObj.getId() );
			inventoryItemRuleDao.saveOrUpdate(beanObj, userId);
		}
		
		for (InventoryItemTransactionBean beanObj : itemObj.transactionList)
		{
			beanObj.setItemId( itemObj.getId() );
			inventoryItemTransactionDao.saveOrUpdate(beanObj, userId);
		}
		
		// apply relavant changes to other item objects
		inventoryUtil.applyRelevantChanges(itemObj);
		// Save root bean	
		inventoryItemDao.saveOrUpdate(itemObj, userId); 
		// Index Bean
		if (itemObj.isDeleted())
			inventoryUtil.removeIndexBean(itemObj);
		else
			inventoryUtil.indexBean(itemObj);
		
	} // .end of saveOrUpdateItem
    
	@Transactional  
	public void deleteItem(InventoryItemBean itemObj) 
	{  
		inventoryItemDao.delete(itemObj);  
	} // .end of deleteItem 
	
	@Transactional  
	public InventoryTransactionBean getTransactionById(String id, boolean fullBean) 
	{  
		try 
		{
			InventoryTransactionBean transactionObj = inventoryTransactionDao.getBeanById(id);  
			if (fullBean)
				return inventoryUtil.fillBean(transactionObj);
			else
				return transactionObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getTransactionById

	@Transactional  
	public List<InventoryTransactionBean> getTransactionListByIds(String ids) 
	{  
		try 
		{
			List<InventoryTransactionBean> transactionList = new ArrayList<InventoryTransactionBean>();
			StringTokenizer tokenizer = new StringTokenizer(ids, ", ");
			while (tokenizer.hasMoreTokens()) {
				transactionList.add(
					inventoryUtil.fillBean(
						this.inventoryTransactionDao.getBeanById(tokenizer.nextToken())) );
			}	  
			return transactionList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryTransactionBean>();
		}
	} // .end of getTransactionListByIds
	
	@Transactional  
	public InventoryTransactionBean getTransactionByThirdPartyId(String id, boolean fullBean) 
	{  
		try 
		{
			InventoryTransactionBean transactionObj = inventoryTransactionDao.getBeanByThirdPartyId(id);  
			if (fullBean)
				return inventoryUtil.fillBean(transactionObj);
			else
				return transactionObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getTransactionById
	
	@Transactional
	public List<InventoryTransactionBean> getTransactionsByPlaceId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<InventoryTransactionBean> transactionList = inventoryTransactionDao.getBeansByPlaceId(criteria);
				
			if (criteria.isFullBean())
			{
				for (InventoryTransactionBean transactionObj : transactionList)
				{
					inventoryUtil.fillBean( transactionObj );
				}
			}
			
			return transactionList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<InventoryTransactionBean>();
		}
	} // .end of getTransactionsByPlaceId

	@Transactional
	public List<String> getTransactionIdsByPlaceId(InventorySearchCriteria criteria)
	{
		try 
		{
			List<String> transactionList = inventoryTransactionDao.getBeanIdsByPlaceId(criteria);
			return transactionList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<String>();
		}
	} // .end of getTransactionIdsByPlaceId
	  
	@Transactional  
	public void saveOrUpdateTransaction(InventoryTransactionBean transactionObj, String userId) 
	{  
		for (InventoryTransactionLineBean beanObj : transactionObj.lineList)
		{
			beanObj.setTransactionId( transactionObj.getId() );
			inventoryTransactionLineDao.saveOrUpdate(beanObj, userId);
		}
		
		// Save root bean
		inventoryTransactionDao.saveOrUpdate(transactionObj, userId);
	} // .end of saveOrUpdateTransaction  
    
	@Transactional  
	public void deleteTransaction(InventoryTransactionBean transactionObj) 
	{  
		inventoryTransactionDao.delete(transactionObj);  
	} // .end of deleteTransaction
}
