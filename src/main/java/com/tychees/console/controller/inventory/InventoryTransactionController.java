package com.tychees.console.controller.inventory;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;  
import org.springframework.web.bind.annotation.RestController;

import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.controller.RequestStatus;
import com.tychees.console.controller.inventory.request.GetTransactionsByIdsRequestBody;
import com.tychees.console.controller.inventory.request.GetTransactionsByPlaceRequestBody;
import com.tychees.console.controller.inventory.response.GetTransactionsByIdsResponseBody;
import com.tychees.console.controller.inventory.response.GetTransactionsByPlaceResponseBody;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.InventorySearchCriteria;
  
@RestController  
public class InventoryTransactionController {  
   
	@Autowired 
	InventoryService inventoryService;  
	
	@Autowired
	UserService userService;
		
	//--------------------------------------------------------------------------
	/*
	@RequestMapping(value = "/console/getTransactionByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetTransactionByIdResponseBody getTransactionByIdTest(HttpServletRequest request, @RequestBody GetTransactionByIdRequestBody requestBody) 
	{  
		return getTransactionById(request, requestBody);
	} // .end of getTransactionByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getTransactionById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetTransactionByIdResponseBody getTransactionById(HttpServletRequest request, @RequestBody GetTransactionByIdRequestBody requestBody) 
	{  
		GetTransactionByIdResponseBody responseBody = new GetTransactionByIdResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
		if (sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get category object, by given ID
			responseBody.transactionObj = inventoryService.getTransactionById( requestBody.transactionId, requestBody.fullBean );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getTransactionById
	*/
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getTransactionsByIdsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetTransactionsByIdsResponseBody getTransactionsByIdsTest(HttpServletRequest request, @RequestBody GetTransactionsByIdsRequestBody requestBody) 
	{  
		return getTransactionsByIds(request, requestBody);
	} // .end of getTransactionsByIdsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getTransactionsByIds", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetTransactionsByIdsResponseBody getTransactionsByIds(HttpServletRequest request, @RequestBody GetTransactionsByIdsRequestBody requestBody) 
	{  
		GetTransactionsByIdsResponseBody responseBody = new GetTransactionsByIdsResponseBody();
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
			// TASK #1: Get category object, by given ID
			responseBody.transactionList = inventoryService.getTransactionListByIds( requestBody.transactionIdList );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getTransactionsByIds
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getTransactionsByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetTransactionsByPlaceResponseBody getTransactionsByPlaceTest(HttpServletRequest request, @RequestBody GetTransactionsByPlaceRequestBody requestBody) 
	{  
		return getTransactionsByPlace(request, requestBody);
	} // .end of getTransactionsByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getTransactionsByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetTransactionsByPlaceResponseBody getTransactionsByPlace(HttpServletRequest request, @RequestBody GetTransactionsByPlaceRequestBody requestBody) 
	{  
		GetTransactionsByPlaceResponseBody responseBody = new GetTransactionsByPlaceResponseBody();
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
			// TASK #1: Get transaction list, by given place ID
			InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( true );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			responseBody.transactionList = inventoryService.getTransactionsByPlaceId( criteria );
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getTransactionsByPlace
}  