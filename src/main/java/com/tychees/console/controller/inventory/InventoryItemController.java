package com.tychees.console.controller.inventory;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;  
import org.springframework.web.bind.annotation.RestController;

import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.billing.BillingBucketBean;
import com.tychees.core.bean.billing.BillingBucketLineBean;
import com.tychees.core.bean.billing.BillingLineBean;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.InventoryItemPropertiesBean;
import com.tychees.core.bean.inventory.InventoryItemTransactionBean;
import com.tychees.core.bean.inventory.view.InventoryItemCompactViewBean;
import com.tychees.core.bean.place.PlaceNotificationBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.constants.InventoryConstants;
import com.tychees.core.controller.RequestStatus;
import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.taskqueue.TaskOptions;
import com.google.appengine.api.taskqueue.TaskOptions.Method;
import com.google.gson.Gson;
import com.tychees.console.controller.inventory.request.BatchDownloadItemsRequestBody;
import com.tychees.console.controller.inventory.request.BatchUpdateItemsRequestBody;
import com.tychees.console.controller.inventory.request.DecreaseItemRequestBody;
import com.tychees.console.controller.inventory.request.GetDependentItemsByItemRequestBody;
import com.tychees.console.controller.inventory.request.GetItemByIdRequestBody;
import com.tychees.console.controller.inventory.request.GetItemCountByCategoryRequestBody;
import com.tychees.console.controller.inventory.request.GetItemCountByPlaceRequestBody;
import com.tychees.console.controller.inventory.request.GetItemsByCategoryRequestBody;
import com.tychees.console.controller.inventory.request.GetItemsByIdsRequestBody;
import com.tychees.console.controller.inventory.request.GetItemsByPlaceRequestBody;
import com.tychees.console.controller.inventory.request.IncreaseItemRequestBody;
import com.tychees.console.controller.inventory.request.ListComponentItemsByItemRequestBody;
import com.tychees.console.controller.inventory.request.ListItemsByBillingBucketLineRequestBody;
import com.tychees.console.controller.inventory.request.ListItemsByBillingLineRequestBody;
import com.tychees.console.controller.inventory.response.BatchDownloadItemsResponseBody;
import com.tychees.console.controller.inventory.response.BatchUpdateItemsResponseBody;
import com.tychees.console.controller.inventory.response.DecreaseItemResponseBody;
import com.tychees.console.controller.inventory.response.GetDependentItemsByItemResponseBody;
import com.tychees.console.controller.inventory.response.GetItemByIdResponseBody;
import com.tychees.console.controller.inventory.response.GetItemCountByCategoryResponseBody;
import com.tychees.console.controller.inventory.response.GetItemCountByPlaceResponseBody;
import com.tychees.console.controller.inventory.response.GetItemsByCategoryResponseBody;
import com.tychees.console.controller.inventory.response.GetItemsByIdsResponseBody;
import com.tychees.console.controller.inventory.response.GetItemsByPlaceResponseBody;
import com.tychees.console.controller.inventory.response.IncreaseItemResponseBody;
import com.tychees.console.controller.inventory.response.ListComponentItemsByItemResponseBody;
import com.tychees.console.controller.inventory.response.ListItemsByBillingBucketLineResponseBody;
import com.tychees.console.controller.inventory.response.ListItemsByBillingLineResponseBody;
import com.tychees.core.service.BatchService;
import com.tychees.core.service.BillingService;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.PlaceService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.InventorySearchCriteria;
  
@RestController  
public class InventoryItemController {  

	@Autowired 
	InventoryConstants INVENTORY_CONSTANTS;
	@Autowired 
	InventoryService inventoryService;  	
	@Autowired 
	BillingService billingService;  	
	@Autowired
	PlaceService placeService;	
	@Autowired
	UserService userService;	
	@Autowired
	BatchService batchService;

	private final static Logger LOGGER = Logger.getLogger(InventoryItemController.class.getName());
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getItemByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemByIdResponseBody getItemByIdTest(HttpServletRequest request, @RequestBody GetItemByIdRequestBody requestBody) 
	{  
		return getItemById(request, requestBody);
	} // .end of getItemByIdyTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getItemById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemByIdResponseBody getItemById(HttpServletRequest request, @RequestBody GetItemByIdRequestBody requestBody) 
	{  
		GetItemByIdResponseBody responseBody = new GetItemByIdResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item list, by given category ID
			//responseBody.itemList = inventoryService.getItemsByCategoryId( requestBody.categoryId, true, requestBody.lastSyncedTime.longValue() );
			responseBody.itemObj = inventoryService.getItemById(requestBody.itemId, requestBody.fullBean, requestBody.loadImages);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getItemById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getItemsByIdsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemsByIdsResponseBody getItemByIdTest(HttpServletRequest request, @RequestBody GetItemsByIdsRequestBody requestBody) 
	{  
		return getItemsByIds(request, requestBody);
	} // .end of getItemsByIdsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getItemsByIds", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemsByIdsResponseBody getItemsByIds(HttpServletRequest request, @RequestBody GetItemsByIdsRequestBody requestBody) 
	{  
		GetItemsByIdsResponseBody responseBody = new GetItemsByIdsResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item list, by given category ID
			//responseBody.itemList = inventoryService.getItemsByCategoryId( requestBody.categoryId, true, requestBody.lastSyncedTime.longValue() );
			responseBody.itemList = inventoryService.getItemListByIds( requestBody.itemIdList );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getItemsByIds
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getItemsByCategoryTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemsByCategoryResponseBody getItemsByCategoryTest(HttpServletRequest request, @RequestBody GetItemsByCategoryRequestBody requestBody) 
	{  
		return getItemsByCategory(request, requestBody);
	} // .end of getItemsByCategoryTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getItemsByCategory", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemsByCategoryResponseBody getItemsByCategory(HttpServletRequest request, @RequestBody GetItemsByCategoryRequestBody requestBody) 
	{  
		GetItemsByCategoryResponseBody responseBody = new GetItemsByCategoryResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item list, by given category ID
			InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setLoadComponentItems( requestBody.loadComponentItems );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			criteria.setCategoryId( requestBody.categoryId );
			criteria.setFilterByGroupName( requestBody.filterByGroupName );
			criteria.setGroupName( requestBody.groupName );
			
			if (requestBody.viewBean)
				responseBody.itemViewList = inventoryService.getItemViewsByCategoryId( criteria );
			else
				responseBody.itemList = inventoryService.getItemsByCategoryId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getItemsByCategory
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getItemsByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemsByPlaceResponseBody getItemsByPlaceTest(HttpServletRequest request, @RequestBody GetItemsByPlaceRequestBody requestBody) 
	{  
		return getItemsByPlace(request, requestBody);
	} // .end of getItemsByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getItemsByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemsByPlaceResponseBody getItemsByPlace(HttpServletRequest request, @RequestBody GetItemsByPlaceRequestBody requestBody) 
	{  
		GetItemsByPlaceResponseBody responseBody = new GetItemsByPlaceResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item list, by given category ID
			InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			criteria.setFilterByPosVisible( requestBody.filterByPosVisible );
			criteria.setPosVisible( requestBody.posVisible );			
			
			if (requestBody.viewBean)
				responseBody.viewList = inventoryService.getItemViewsByPlaceId( criteria );
			else
				responseBody.itemList = inventoryService.getItemsByPlaceId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getItemsByPlace
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getItemCountByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemCountByPlaceResponseBody getItemCountByPlaceTest(HttpServletRequest request, @RequestBody GetItemCountByPlaceRequestBody requestBody) 
	{  
		return getItemCountByPlace(request, requestBody);
	} // .end of getItemsByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getItemCountByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemCountByPlaceResponseBody getItemCountByPlace(HttpServletRequest request, @RequestBody GetItemCountByPlaceRequestBody requestBody) 
	{  
		GetItemCountByPlaceResponseBody responseBody = new GetItemCountByPlaceResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item list, by given category ID
			InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			criteria.setFilterByPosVisible( requestBody.filterByPosVisible );
			criteria.setPosVisible( requestBody.posVisible );			
			
			responseBody.itemCount = inventoryService.getItemCountByPlaceId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getItemCountByPlace
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getItemCountByCategoryTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemCountByCategoryResponseBody getItemCountByCategoryTest(HttpServletRequest request, @RequestBody GetItemCountByCategoryRequestBody requestBody) 
	{  
		return getItemCountByCategory(request, requestBody);
	} // .end of getItemsByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getItemCountByCategory", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetItemCountByCategoryResponseBody getItemCountByCategory(HttpServletRequest request, @RequestBody GetItemCountByCategoryRequestBody requestBody) 
	{  
		GetItemCountByCategoryResponseBody responseBody = new GetItemCountByCategoryResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item list, by given category ID
			InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			criteria.setFilterByPosVisible( requestBody.filterByPosVisible );
			criteria.setPosVisible( requestBody.posVisible );		
			criteria.setCategoryId( requestBody.categoryId );
			criteria.setFilterByGroupName( requestBody.filterByGroupName );
			criteria.setGroupName( requestBody.groupName );
			
			responseBody.itemCount = inventoryService.getItemCountByCategoryId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getItemCountByCategory
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/listComponentItemsByItemTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public ListComponentItemsByItemResponseBody getDependentItemsByItemTest(HttpServletRequest request, @RequestBody ListComponentItemsByItemRequestBody requestBody) 
	{  
		return getDependentItemsByItem(request, requestBody);
	} // .end of getDependentItemsByItemTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/listComponentItemsByItem", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public ListComponentItemsByItemResponseBody getDependentItemsByItem(HttpServletRequest request, @RequestBody ListComponentItemsByItemRequestBody requestBody) 
	{  
		ListComponentItemsByItemResponseBody responseBody = new ListComponentItemsByItemResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item list, by given category ID
			InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			criteria.setFilterByPosVisible( requestBody.filterByPosVisible );
			criteria.setPosVisible( requestBody.posVisible );	
			criteria.setItemId( requestBody.itemId );
			criteria.setViewBean( requestBody.viewBean );
			criteria.setMandatory( requestBody.mandatory );
			criteria.setOptional( requestBody.optional );
			
			if (requestBody.viewBean)
				responseBody.itemViewList = inventoryService.listComponentItemViewsByItemId( criteria );
			else
				responseBody.itemList = inventoryService.listComponentItemsByItemId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getItemsByPlace
		
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/listItemsByBillingLineTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public ListItemsByBillingLineResponseBody listItemsByBillingLineTest(HttpServletRequest request, @RequestBody ListItemsByBillingLineRequestBody requestBody) 
	{  
		return listItemsByBillingLine(request, requestBody);
	} // .end of listItemsByBillingLineTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/listItemsByBillingLine", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public ListItemsByBillingLineResponseBody listItemsByBillingLine(HttpServletRequest request, @RequestBody ListItemsByBillingLineRequestBody requestBody) 
	{  
		ListItemsByBillingLineResponseBody responseBody = new ListItemsByBillingLineResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			responseBody.itemViewList = new ArrayList<InventoryItemCompactViewBean>();
			responseBody.itemList = new ArrayList<InventoryItemBean>();
			List<String> itemIdList = new ArrayList<String>();
			
			BillingBean billingObj = 
				billingService.getBillingById(requestBody.billingId, true);
			if (billingObj != null)
			{
				for (BillingLineBean billingLineObj : billingObj.lineList) 
				{
					if (billingLineObj.getId().equals(requestBody.billingLineId))
					{
						for (BillingLineBean childLineObj : billingLineObj.lineList)
						{
							itemIdList.add( childLineObj.getItemId() );
						}
					}
				}
			}
			
			for (String itemId : itemIdList)
			{
				// TASK #1: Get item obj, by given item ID
				InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
				criteria.setFullBean( requestBody.fullBean );
				criteria.setFilterByLastSyncedTime( false );
				criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
				criteria.setFilterByPosVisible( requestBody.filterByPosVisible );
				criteria.setPosVisible( requestBody.posVisible );	
				criteria.setItemId( itemId );
				criteria.setViewBean( requestBody.viewBean );

				if (requestBody.viewBean)
					responseBody.itemViewList.addAll( inventoryService.listComponentItemViewsByItemId( criteria ) );
				else
					responseBody.itemList.addAll( inventoryService.listComponentItemsByItemId( criteria ) );
			}
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of listItemsByBillingLine	
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/listItemsByBillingBucketLineTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public ListItemsByBillingBucketLineResponseBody listItemsByBillingBucketLineTest(HttpServletRequest request, @RequestBody ListItemsByBillingBucketLineRequestBody requestBody) 
	{  
		return listItemsByBillingBucketLine(request, requestBody);
	} // .end of listItemsByBillingBucketLineTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/listItemsByBillingBucketLine", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public ListItemsByBillingBucketLineResponseBody listItemsByBillingBucketLine(HttpServletRequest request, @RequestBody ListItemsByBillingBucketLineRequestBody requestBody) 
	{  
		ListItemsByBillingBucketLineResponseBody responseBody = new ListItemsByBillingBucketLineResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			responseBody.itemViewList = new ArrayList<InventoryItemCompactViewBean>();
			responseBody.itemList = new ArrayList<InventoryItemBean>();
			List<String> itemIdList = new ArrayList<String>();
			
			BillingBucketBean billingBucketObj = billingService.getBillingBucketById(requestBody.billingBucketId, true);
			if (billingBucketObj != null)
			{
				for (BillingBucketLineBean billingBucketLineObj : billingBucketObj.lineList) 
				{
					if (billingBucketLineObj.getId().equals(requestBody.billingBucketLineId))
					{
						for (BillingBucketLineBean childLineObj : billingBucketLineObj.lineList)
						{
							itemIdList.add( childLineObj.getItemId() );
						}
					}
				}
			}
			
			for (String itemId : itemIdList)
			{
				// TASK #1: Get item obj, by given item ID
				InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
				criteria.setFullBean( requestBody.fullBean );
				criteria.setFilterByLastSyncedTime( false );
				criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
				criteria.setFilterByPosVisible( requestBody.filterByPosVisible );
				criteria.setPosVisible( requestBody.posVisible );	
				criteria.setItemId( itemId );
				criteria.setViewBean( requestBody.viewBean );

				if (requestBody.viewBean)
					responseBody.itemViewList.addAll( inventoryService.listComponentItemViewsByItemId( criteria ) );
				else
					responseBody.itemList.addAll( inventoryService.listComponentItemsByItemId( criteria ) );
			}
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of listItemsByBillingBucketLine	
		
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getDependentItemsByItemTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetDependentItemsByItemResponseBody getDependentItemsByItemTest(HttpServletRequest request, @RequestBody GetDependentItemsByItemRequestBody requestBody) 
	{  
		return getDependentItemsByItem(request, requestBody);
	} // .end of getDependentItemsByItemTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getDependentItemsByItem", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetDependentItemsByItemResponseBody getDependentItemsByItem(HttpServletRequest request, @RequestBody GetDependentItemsByItemRequestBody requestBody) 
	{  
		GetDependentItemsByItemResponseBody responseBody = new GetDependentItemsByItemResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item list, by given category ID
			InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			criteria.setFilterByPosVisible( requestBody.filterByPosVisible );
			criteria.setPosVisible( requestBody.posVisible );	
			criteria.setItemId( requestBody.itemId );
			
			responseBody.itemList = inventoryService.getDependentItemsByItemId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getDependentItemsByItem
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/increaseItemTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public IncreaseItemResponseBody increaseItemTest(HttpServletRequest request, @RequestBody IncreaseItemRequestBody requestBody) 
	{  
		return increaseItem(request, requestBody);
	} // .end of increaseItemTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/increaseItem", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public IncreaseItemResponseBody increaseItem(HttpServletRequest request, @RequestBody IncreaseItemRequestBody requestBody) 
	{  
		IncreaseItemResponseBody responseBody = new IncreaseItemResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item object
			InventoryItemBean itemObj = inventoryService.getItemById(requestBody.itemId, true, false);
			
			// Task #2: 
			if (itemObj != null) {
				// Update quantity
				itemObj.setQuantity( itemObj.getQuantity() + requestBody.quantity );
				// Create transaction log
				InventoryItemTransactionBean transactionObj = new InventoryItemTransactionBean();
				transactionObj.setCreatedBy(sessionObj.getUserId());
				transactionObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				transactionObj.setItemId(requestBody.itemId);
				transactionObj.setBillingId(requestBody.billingId);
				transactionObj.setBillingLineId(requestBody.billingLineId);
				transactionObj.setOperator(INVENTORY_CONSTANTS.TRANSACTION_LINE_OPERATOR_ADD);
				transactionObj.setQuantity(requestBody.quantity);
				transactionObj.setReason(requestBody.reason);
				transactionObj.setRemarks(requestBody.remarks);
				
				if (itemObj.transactionList == null)
					itemObj.transactionList = new ArrayList<InventoryItemTransactionBean>();
				itemObj.transactionList.add(transactionObj);
				
				// Save item
				inventoryService.saveOrUpdateItem(itemObj, sessionObj.getUserId());
			}			
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of increaseItem
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/decreaseItemTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public DecreaseItemResponseBody decreaseItemTest(HttpServletRequest request, @RequestBody DecreaseItemRequestBody requestBody) 
	{  
		return decreaseItem(request, requestBody);
	} // .end of decreaseItemTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/decreaseItem", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public DecreaseItemResponseBody decreaseItem(HttpServletRequest request, @RequestBody DecreaseItemRequestBody requestBody) 
	{  
		DecreaseItemResponseBody responseBody = new DecreaseItemResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get item object
			InventoryItemBean itemObj = inventoryService.getItemById(requestBody.itemId, true, false);
			
			// Task #2: 
			if (itemObj != null) {
				// Update quantity
				itemObj.setQuantity( itemObj.getQuantity() - requestBody.quantity );
				// Create transaction log
				InventoryItemTransactionBean transactionObj = new InventoryItemTransactionBean();
				transactionObj.setCreatedBy(sessionObj.getUserId());
				transactionObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				transactionObj.setItemId(requestBody.itemId);
				transactionObj.setBillingId(requestBody.billingId);
				transactionObj.setBillingLineId(requestBody.billingLineId);
				transactionObj.setOperator(INVENTORY_CONSTANTS.TRANSACTION_LINE_OPERATOR_SUB);
				transactionObj.setQuantity(requestBody.quantity);
				transactionObj.setReason(requestBody.reason);
				transactionObj.setRemarks(requestBody.remarks);
				
				if (itemObj.transactionList == null)
					itemObj.transactionList = new ArrayList<InventoryItemTransactionBean>();
				itemObj.transactionList.add(transactionObj);
				
				// Save item
				inventoryService.saveOrUpdateItem(itemObj, sessionObj.getUserId());
			}			
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of decreaseItem
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchUpdateItemsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateItemsResponseBody batchUpdateItemsTest(HttpServletRequest request, @RequestBody BatchUpdateItemsRequestBody requestBody) 
	{  
		return batchUpdateItems(request, requestBody);
	} // .end of batchUpdateItemsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchUpdateItems", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateItemsResponseBody batchUpdateItems(HttpServletRequest request, @RequestBody BatchUpdateItemsRequestBody requestBody) 
	{  
		BatchUpdateItemsResponseBody responseBody = new BatchUpdateItemsResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			for (InventoryItemBean itemObj : requestBody.itemListForInsert) 
			{
				inventoryService.saveOrUpdateItem(itemObj, sessionObj.getUserId());	
			}
			
			for (InventoryItemBean itemObj : requestBody.itemListForUpdate) 
			{
				InventoryItemBean existingItemObj = inventoryService.getItemById(itemObj.getId(), true, false);
				if (existingItemObj == null)
					continue;
				
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
				
				for (InventoryItemPropertiesBean existingPropObj : existingItemObj.propertiesList) 
				{
					for (InventoryItemPropertiesBean updatedPropObj : itemObj.propertiesList) 
					{
						if (existingPropObj.getPropKey().equals(updatedPropObj.getPropKey()))
						{
							existingPropObj.setPropValue(updatedPropObj.getPropValue());
						}
					}
				}
				
				inventoryService.saveOrUpdateItem(existingItemObj, sessionObj.getUserId());		
			}
			
			for (InventoryItemBean itemObj : requestBody.itemListForDelete) 
			{
				itemObj.setDeletedBy(sessionObj.getUserId());
				itemObj.setDeletedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				
				inventoryService.saveOrUpdateItem(itemObj, sessionObj.getUserId());		
			}
			
			// Prepare summary
			int totalProcessCount = requestBody.itemListForInsert.size() + requestBody.itemListForUpdate.size() + requestBody.itemListForDelete.size();
			// Set notification to user
			PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
			notificationObj.setName("Batch Update Completed");
			notificationObj.setDescription("Batch Update (" + totalProcessCount + ") has been executed successfully.");
			notificationObj.setStatus("COMPLETED");
			notificationObj.setNotificationRead(false);
			notificationObj.setNotificationReadOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
			
			placeService.saveOrUpdatePlaceNotification(notificationObj, sessionObj.getUserId());
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchUpdateItems
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchDownloadItemsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadItemsResponseBody batchDownloadItemsTest(HttpServletRequest request, @RequestBody BatchDownloadItemsRequestBody requestBody) 
	{  
		return batchDownloadItems(request, requestBody);
	} // .end of batchDownloadItemsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchDownloadItems", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadItemsResponseBody batchDownloadItems(HttpServletRequest request, @RequestBody BatchDownloadItemsRequestBody requestBody) 
	{  
		BatchDownloadItemsResponseBody responseBody = new BatchDownloadItemsResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			Gson gson = new Gson();
			String requestBodyInString = gson.toJson(requestBody);
			
			Queue queue = QueueFactory.getQueue("batch-request-queue");
			queue.add(
				TaskOptions.Builder.withUrl("/queue/batchDownloadItems")
					.payload(requestBodyInString.getBytes(), "application/json")
					.method(Method.POST));
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadItems
	
	//--------------------------------------------------------------------------
}  