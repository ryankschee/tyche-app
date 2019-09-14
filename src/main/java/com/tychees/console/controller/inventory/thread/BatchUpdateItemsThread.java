package com.tychees.console.controller.inventory.thread;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.place.PlaceNotificationBean;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.PlaceService;

public class BatchUpdateItemsThread 
    implements Runnable 
{
	Logger logger = Logger.getLogger(BatchUpdateItemsThread.class.getName());
	
	@Autowired 
	InventoryService inventoryService;  
	@Autowired 
	PlaceService placeService;  
	
	private String userId;
	private String placeId;
	private List<InventoryItemBean> itemListForInsert;
	private List<InventoryItemBean> itemListForUpdate;
	private List<InventoryItemBean> itemListForDelete;
   
   
	public BatchUpdateItemsThread(String userId, String placeId, List<InventoryItemBean> itemListForInsert, List<InventoryItemBean> itemListForUpdate, List<InventoryItemBean> itemListForDelete) 
	{
		logger.info("NEW > BatchUpdateItemsThread");
		
		this.userId = userId;
		this.placeId = placeId;
		this.itemListForInsert = itemListForInsert;
		this.itemListForUpdate = itemListForUpdate;
		this.itemListForDelete = itemListForDelete;
	}

	@Override
	public void run() 
	{		
		logger.info("START > BatchUpdateItemsThread");

		logger.info("PRE INSERT > itemListForInsert="+itemListForInsert.size());
		try {
			for (InventoryItemBean itemObj : itemListForInsert) 
			{
				inventoryService.saveOrUpdateItem(itemObj, userId);			
				logger.info("INSERT > " + itemObj.getName());
			}
		} catch (Exception e) {
			logger.info("e="+e.getMessage());
			logger.info("e="+e);
		}

		logger.info("PRE UPDATE > itemListForInsert="+itemListForUpdate.size());
		for (InventoryItemBean itemObj : itemListForUpdate) 
		{
			/*InventoryItemBean existingItemObj = inventoryService.getItemById(itemObj.getId(), true, false);
			existingItemObj.setItemType(itemObj.getItemType());
			existingItemObj.setGroupName(itemObj.getGroupName());
			existingItemObj.setName(itemObj.getName());
			existingItemObj.setLabels(itemObj.getLabels());
			existingItemObj.setPosVisible(itemObj.isPosVisible());
			existingItemObj.setPwsVisible(itemObj.isPwsVisible());
			existingItemObj.setMeasurementUnit(itemObj.getMeasurementUnit());
			existingItemObj.setQuantityOptional(itemObj.isQuantityOptional());
			existingItemObj.setMinimumQuantity(itemObj.getMinimumQuantity());
			existingItemObj.setQuantity(itemObj.getQuantity());
			existingItemObj.setUnitCost(itemObj.getUnitCost());
			existingItemObj.setUnitPrice(itemObj.getUnitPrice());
			
			inventoryService.saveOrUpdateItem(existingItemObj, userId);		*/	
			logger.info("UPDATE > " + itemObj.getName());
		}

		logger.info("PRE DELETE > itemListForDelete="+itemListForDelete.size());
		for (InventoryItemBean itemObj : itemListForDelete) 
		{
			/*itemObj.setDeletedBy(userId);
			itemObj.setDeletedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
			
			inventoryService.saveOrUpdateItem(itemObj, userId);		*/	
			logger.info("DELETE > " + itemObj.getName());
		}
		
		// Prepare summary
		int totalProcessCount = itemListForInsert.size() + itemListForUpdate.size() + itemListForDelete.size();
		// Set notification to user
		PlaceNotificationBean notificationObj = new PlaceNotificationBean();
		notificationObj.setUserId(userId);
		notificationObj.setPlaceId(placeId);
		notificationObj.setCreatedBy(userId);
		notificationObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
		notificationObj.setName("Batch Update Completed");
		notificationObj.setDescription("Batch Update (" + totalProcessCount + ") has been executed successfully.");
		notificationObj.setStatus("COMPLETED");
		//notificationObj.setRead(false);
		
		placeService.saveOrUpdatePlaceNotification(notificationObj, userId);
		logger.info("END > BatchUpdateItemsThread");
	} // .end of run
}
