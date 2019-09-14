package com.tychees.console.controller.billing;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;  
import org.springframework.web.bind.annotation.RestController;

import com.tychees.console.controller.billing.request.GetBillingBucketByIdRequestBody;
import com.tychees.console.controller.billing.request.GetBillingBucketsByPlaceRequestBody;
import com.tychees.console.controller.billing.response.GetBillingBucketByIdResponseBody;
import com.tychees.console.controller.billing.response.GetBillingBucketsByPlaceResponseBody;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.constants.BillingConstants;
import com.tychees.core.controller.RequestStatus;
import com.tychees.core.service.BillingService;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.BillingBucketSearchCriteria;

@RestController  
public class BillingBucketController {  
   
	@Autowired 
	BillingConstants billingConstants;  
	@Autowired 
	BillingService billingService;  
	@Autowired 
	InventoryService inventoryService;  
	@Autowired
	UserService userService;

	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingBucketByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingBucketByIdResponseBody getBillingBucketByIdTest(HttpServletRequest request, @RequestBody GetBillingBucketByIdRequestBody requestBody) 
	{  
		return getBillingBucketById(request, requestBody);
	} // .end of getBillingBucketByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingBucketById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingBucketByIdResponseBody getBillingBucketById(HttpServletRequest request, @RequestBody GetBillingBucketByIdRequestBody requestBody) 
	{  
		GetBillingBucketByIdResponseBody responseBody = new GetBillingBucketByIdResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASK: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// TASK #1: Get full billing object, by given billing ID
			responseBody.billingBucketObj = billingService.getBillingBucketById(requestBody.billingBucketId, requestBody.fullBean);
			// Filter
			if (responseBody.billingBucketObj != null) {
				if (billingConstants.BUCKET_STATUS_DELETED.equals(responseBody.billingBucketObj.getBucketStatus()))
					responseBody.billingBucketObj = null;
			}
			// Set response status
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingBucketsByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingBucketsByPlaceResponseBody getBillingBucketsByPlaceTest(HttpServletRequest request, @RequestBody GetBillingBucketsByPlaceRequestBody requestBody) 
	{  
		return getBillingBucketsByPlace(request, requestBody);
	} // .end of getBillingBucketsByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingBucketsByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingBucketsByPlaceResponseBody getBillingBucketsByPlace(HttpServletRequest request, @RequestBody GetBillingBucketsByPlaceRequestBody requestBody) 
	{  
		GetBillingBucketsByPlaceResponseBody responseBody = new GetBillingBucketsByPlaceResponseBody();
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
			// TASK #1: Get billing list, by given place ID
			BillingBucketSearchCriteria criteria = new BillingBucketSearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByBucketStatus( requestBody.filterByBucketStatus );
			criteria.setBucketStatus( requestBody.bucketStatus );
						
			responseBody.billingBucketList = billingService.getBillingBucketsByPlaceId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingBucketsByPlace
}  