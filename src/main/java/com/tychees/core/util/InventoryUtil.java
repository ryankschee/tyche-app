package com.tychees.core.util;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.InventoryItemComponentBean;
import com.tychees.core.bean.inventory.InventoryItemImageBean;
import com.tychees.core.bean.inventory.InventoryItemPropertiesBean;
import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.constants.InventoryConstants;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.inventory.InventoryCategoryDAO;
import com.tychees.core.dao.inventory.InventoryCategoryPropertiesDAO;
import com.tychees.core.dao.inventory.InventoryItemComponentDAO;
import com.tychees.core.dao.inventory.InventoryItemDAO;
import com.tychees.core.dao.inventory.InventoryItemImageDAO;
import com.tychees.core.dao.inventory.InventoryItemPropertiesDAO;
import com.tychees.core.dao.inventory.InventoryItemRuleDAO;
import com.tychees.core.dao.inventory.InventoryItemTransactionDAO;
import com.tychees.core.dao.inventory.InventoryTransactionDAO;
import com.tychees.core.dao.inventory.InventoryTransactionLineDAO;
import com.tychees.core.service.IndexService;

@Component
public class InventoryUtil {

	@Autowired
	InventoryConstants inventoryConstants;
	@Autowired
	IndexUtil indexUtil;
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
	@Autowired
	IndexService indexService;
	
	/**
	 * Full Structure of InventoryCategoryBean
	 * -----------------------------
	 * InventoryCategoryBean
	 *  |- propertiesList
	 */ 
	public InventoryCategoryBean fillBean(InventoryCategoryBean categoryObj) 
	{  
		try
		{
			if (categoryObj != null)
			{
				// Set state: fullBeanLoaded
				categoryObj.setFullBeanLoaded( true );
				
				categoryObj.propertiesList = 
					inventoryCategoryPropertiesDao.getBeansByCategoryId(categoryObj.getId());
			}
			
			return categoryObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return categoryObj;
		}
	} // .end of fillBean
	
	/**
	 * Full Structure of InventoryItemBean
	 * -----------------------------
	 * InventoryItemBean
	 *  |- componentList
	 *  |- imageList
	 *  |- labelList
	 *  |- propertiesList
	 *  |- ruleList
	 *  |- transactionList
	 */ 
	public InventoryItemBean fillBean(InventoryItemBean itemObj, boolean loadImages) 
	{  
		try
		{
			if (itemObj != null)
			{
				// Set state: fullBeanLoaded
				itemObj.setFullBeanLoaded( true );
				
				itemObj.componentList = inventoryItemComponentDao.getBeansByItemId(itemObj.getId());
				itemObj.propertiesList = inventoryItemPropertiesDao.getBeansByItemId(itemObj.getId());				
				itemObj.ruleList = inventoryItemRuleDao.getBeansByItemId(itemObj.getId());			
				itemObj.transactionList = inventoryItemTransactionDao.getBeansByItemId(itemObj.getId());
					
				List<InventoryItemImageBean> imageList = inventoryItemImageDao.getBeansByItemId(itemObj.getId());
				itemObj.setImageCount( imageList.size() );
				
				if (loadImages)
					itemObj.imageList = inventoryItemImageDao.getBeansByItemId(itemObj.getId());	
			}
			
			return itemObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return itemObj;
		}
	} // .end of fillBean 
	
	/**
	 * Full Structure of InventoryTransactionBean
	 * -----------------------------
	 * InventoryTransactionBean
	 *  |- lineList
	 */ 
	public InventoryTransactionBean fillBean(InventoryTransactionBean transactionObj) 
	{  
		try
		{
			if (transactionObj != null)
			{
				// Set state: fullBeanLoaded
				transactionObj.setFullBeanLoaded( true );
				
				transactionObj.lineList = 
					inventoryTransactionLineDao.getBeansByTransactionId(transactionObj.getId());
			}
			
			return transactionObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return transactionObj;
		}
	} // .end of fillBean
	
	public static String getPropValueByKey(InventoryItemBean itemObj, String key) 
	{
		if (key==null || 
			itemObj==null || 
			itemObj.propertiesList==null || 
			itemObj.propertiesList.size()==0)
			return "";
		
		String propValue = "";
		for (InventoryItemPropertiesBean propObj : itemObj.propertiesList) {
			if (propObj != null) {
				if (propObj.getPropKey().equals(key))
					propValue = propObj.getPropValue();
			}
		}
		
		return propValue;
	} // .end of getPropValueByKey
	
	public boolean isItemBelongsToCategories(InventoryItemBean itemObj, List<String> categoryIdList)
	{
		if (categoryIdList.size()==0)
			return true;
		
		for (String categoryId : categoryIdList)
		{
			if ( categoryId.equals(itemObj.getCategoryId()) )
				return true;
		}
		
		return false;
	} // .end of isItemBelongsToCategories
	
	public void applyRelevantChanges(InventoryItemBean pi_itemObj)
	{
		try
		{
			if (pi_itemObj==null)
				return;
			
			// Validation 
			// Step #1: IF   current item is optional for quantity (means alaways available), 
			//          THEN it will not bring impact to any of it's referenced items
			if (pi_itemObj.isQuantityOptional()) {
				pi_itemObj.setAvailability( inventoryConstants.QUANTITY_AVAILABLE );
				return;
			}
			
			// Validation
			// Step #2: IF   current item's new quantity has no impact on availability,
			//          THEN discard subsequent process.
			double minQuantity = pi_itemObj.getMinimumQuantity();
			double curQuantity = pi_itemObj.getQuantity();
			
			boolean availabilityNoChange = false; 
			
			if (curQuantity >= minQuantity) {
				if (inventoryConstants.QUANTITY_AVAILABLE.equals(pi_itemObj.getAvailability())) {
					availabilityNoChange = true;			
				} else {
					availabilityNoChange = false;
				}
			} else
			if (curQuantity > 0) {
				if (inventoryConstants.QUANTITY_LOW_STOCK.equals(pi_itemObj.getAvailability())) {
					availabilityNoChange = true;			
				} else {
					availabilityNoChange = false;
				}
			} else {
				if (inventoryConstants.QUANTITY_NO_STOCK.equals(pi_itemObj.getAvailability())) {
					availabilityNoChange = true;			
				} else {
					availabilityNoChange = false;
				}
			}
			
			// If no change on availability, then no impact on others.
			if (availabilityNoChange) {
				return;
			}
					
			// Set own availability
			pi_itemObj.setAvailability( this.isItemAvailable(pi_itemObj, new ArrayList<String>()) );
			
			// Find items that refer to current item (by id)
			List<InventoryItemComponentBean> componentList1 = inventoryItemComponentDao.getDependentBeansByItemIds( pi_itemObj.getId() );
			for (InventoryItemComponentBean componentObj : componentList1) {
				InventoryItemBean itemObj = inventoryItemDao.getBeanById(componentObj.getItemId());
				if (itemObj != null) {
					String availability = this.isItemAvailable(itemObj, new ArrayList<String>());
					itemObj.setAvailability( availability );
				}
			}
			
			// Find items that refer to current item (by tag)
			List<InventoryItemComponentBean> componentList2 = new ArrayList<InventoryItemComponentBean>();
			StringTokenizer tokenizer = new StringTokenizer(pi_itemObj.getLabels(), ",");
			while(tokenizer.hasMoreTokens()) {
				componentList2.addAll( 
					inventoryItemComponentDao.getDependentBeansByTag( tokenizer.nextToken() ) );
			}
			
			for (InventoryItemComponentBean componentObj : componentList2) {
				InventoryItemBean itemObj = inventoryItemDao.getBeanById(componentObj.getItemId());
				if (itemObj != null) {
					itemObj.setAvailability( this.isItemAvailable(itemObj, null) );
				}
			}
		}
		catch (DAOException e)
		{
			e.printStackTrace();
		}
	} // .end of applyRelevantChanges	

	public String isItemAvailable(String pi_itemId, List<String> pi_itemInChain)
	{
		try
		{
			// Get current item object
			InventoryItemBean itemObj = inventoryItemDao.getBeanById(pi_itemId);
			if (itemObj == null)
				return inventoryConstants.QUANTITY_INVALID_ITEM_FOUND;
	
			return isItemAvailable(itemObj, pi_itemInChain);
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of isItemAvailable
	
	public String isItemAvailable(InventoryItemBean pi_itemObj, List<String> pi_itemInChain)
	{
		if (pi_itemObj==null)
			return inventoryConstants.QUANTITY_INVALID_ITEM_FOUND;
					
		// Get Full Bean, if any
		if (pi_itemObj.isFullBeanLoaded()==false)
			this.fillBean( pi_itemObj, false );			
		
		// Item Type: Tax or Discount
		if (pi_itemObj.getItemType().equals(inventoryConstants.ITEM_TYPE_TAX))
			return inventoryConstants.QUANTITY_AVAILABLE;
		if (pi_itemObj.getItemType().equals(inventoryConstants.ITEM_TYPE_DISCOUNT))
			return inventoryConstants.QUANTITY_AVAILABLE;
		
		// Check if loop of items found. (e.g. item-A -> item-B -> item-A)
		if (pi_itemInChain==null)
			pi_itemInChain = new ArrayList<String>();
		
		boolean circularLoopFound = false;
		for (String chainItemId : pi_itemInChain) 
		{
			if (chainItemId != null && chainItemId.equals(pi_itemObj.getId()))
				circularLoopFound = false;
		}
		
		if (circularLoopFound)
			return inventoryConstants.QUANTITY_ERROR_LOOP_FOUND;
		
		pi_itemInChain.add( pi_itemObj.getId() );

	    // Scenario #1. 
	    // No child component -> use own quantity as decisive point.
		if (pi_itemObj.componentList==null || pi_itemObj.componentList.size()==0)
		{
			if (pi_itemObj.isQuantityOptional())
				return inventoryConstants.QUANTITY_AVAILABLE;
			else
			{
				double quantity = pi_itemObj.getQuantity();
				double minimumQuantity = pi_itemObj.getMinimumQuantity();
				
				if (quantity > minimumQuantity)
					return inventoryConstants.QUANTITY_AVAILABLE;
				if (quantity > 0)
					return inventoryConstants.QUANTITY_LOW_STOCK;
				
				return inventoryConstants.QUANTITY_NO_STOCK;
			}
		}
	    // Scenario #2. 
	    // Has child component(s) -> decide availability from child's quantity
		else
		{
			String availability = inventoryConstants.QUANTITY_AVAILABLE;
			for (InventoryItemComponentBean componentObj : pi_itemObj.componentList)
			{
	    		// Child component is SELECTABLE, means > OPTIONAL
	    		// -> Therefore it's quantity doesn't affect parent's availability.
				if (componentObj.isSelectable())
				{
					// do nothing to change availability
				}
	    		// Child component is NOT SELECTABLE, means > MANDATORY
	    		// -> Therefore it's quantity will affect parent's availability.
				else
				{
					StringTokenizer tokenizer = new StringTokenizer(componentObj.getItemIds(), ",");
					while (tokenizer.hasMoreTokens()) 
					{
						String componentItemId = tokenizer.nextToken();
						if (componentItemId != null && componentItemId.length() > 0)
						{
							String itemAvailability = this.isItemAvailable(componentItemId, pi_itemInChain);
							if (itemAvailability.equals(inventoryConstants.QUANTITY_NO_STOCK))
								availability = inventoryConstants.QUANTITY_NO_STOCK;
							else
							if (itemAvailability.equals(inventoryConstants.QUANTITY_ERROR_LOOP_FOUND))
								availability = inventoryConstants.QUANTITY_ERROR_LOOP_FOUND;
						}
					}
				}
			}
			
			return availability;
		}
	} // .end of isItemAvailable	
	
	public void indexBean(InventoryCategoryBean categoryObj) 
	{
		if (indexService.validateBean(categoryObj.getPlaceId(), categoryObj))
		{
			// Indexing Starts
			indexService.saveTermsAsIndex(categoryObj, "name", categoryObj.getName());
			indexService.saveTermsAsIndex(categoryObj, "remarks", categoryObj.getRemarks());
		}
	} // .end of indexBean

	public void removeIndexBean(InventoryCategoryBean categoryObj) 
	{
		indexService.removeTermsByBean(categoryObj);
	} // .end of removeIndexBean
	
	public void indexBean(InventoryItemBean itemObj) 
	{
		if (indexService.validateBean(itemObj.getPlaceId(), itemObj))
		{
			// Indexing Starts
			//indexService.saveTermsAsIndex(itemObj, "categoryId", itemObj.getCategoryId());
			//indexService.saveTermsAsIndex(itemObj, "categoryName", itemObj.getCategoryName());
			indexService.saveTermsAsIndex(itemObj, "groupName", itemObj.getGroupName());
			indexService.saveTermsAsIndex(itemObj, "remarks", itemObj.getRemarks());
			indexService.saveTermsAsIndex(itemObj, "name", itemObj.getName());
			
			StringTokenizer tokenizer = new StringTokenizer(itemObj.getLabels(), ",");
			while (tokenizer.hasMoreTokens()) {
				indexService.saveTermsAsIndex(itemObj, "keyword", tokenizer.nextToken());
			}
		}
	} // .end of indexBean
	
	public void removeIndexBean(InventoryItemBean itemObj) 
	{
		indexService.removeTermsByBean(itemObj);
	} // .end of removeIndexBean
}
