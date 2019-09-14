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

import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.controller.RequestStatus;
import com.tychees.core.service.BillingService;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.BillingSearchCriteria;
import com.tychees.console.controller.billing.request.GetBillingByBillingNoRequestBody;
import com.tychees.console.controller.billing.request.GetBillingByIdRequestBody;
import com.tychees.console.controller.billing.request.GetBillingByQuotationNoRequestBody;
import com.tychees.console.controller.billing.request.GetBillingsByBucketRequestBody;
import com.tychees.console.controller.billing.request.GetBillingsByCustomerRequestBody;
import com.tychees.console.controller.billing.request.GetBillingsByEmployeeRequestBody;
import com.tychees.console.controller.billing.request.GetBillingsByIdsRequestBody;
import com.tychees.console.controller.billing.request.GetBillingsByPaymentTimePeriodRequestBody;
import com.tychees.console.controller.billing.request.GetBillingsByPlaceRequestBody;
import com.tychees.console.controller.billing.request.GetBillingsByTimePeriodRequestBody;
import com.tychees.console.controller.billing.response.GetBillingByBillingNoResponseBody;
import com.tychees.console.controller.billing.response.GetBillingByIdResponseBody;
import com.tychees.console.controller.billing.response.GetBillingByQuotationNoResponseBody;
import com.tychees.console.controller.billing.response.GetBillingsByBucketResponseBody;
import com.tychees.console.controller.billing.response.GetBillingsByCustomerResponseBody;
import com.tychees.console.controller.billing.response.GetBillingsByEmployeeResponseBody;
import com.tychees.console.controller.billing.response.GetBillingsByIdsResponseBody;
import com.tychees.console.controller.billing.response.GetBillingsByPaymentTimePeriodResponseBody;
import com.tychees.console.controller.billing.response.GetBillingsByPlaceResponseBody;
import com.tychees.console.controller.billing.response.GetBillingsByTimePeriodResponseBody;

@RestController  
public class BillingController {  
   
	@Autowired 
	BillingService billingService;  
	@Autowired 
	InventoryService inventoryService;  
	@Autowired
	UserService userService;
   
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingByIdResponseBody getBillingByIdTest(HttpServletRequest request, @RequestBody GetBillingByIdRequestBody requestBody) 
	{  
		return getBillingById(request, requestBody);
	} // .end of getBillingByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingByIdResponseBody getBillingById(HttpServletRequest request, @RequestBody GetBillingByIdRequestBody requestBody) 
	{  
		GetBillingByIdResponseBody responseBody = new GetBillingByIdResponseBody();
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
			// TASK #1: Get full billing object, by given billing ID
			responseBody.billingObj 	= billingService.getBillingById(requestBody.billingId, requestBody.fullBean);
			//responseBody.transactionObj = inventoryService.getTransactionByThirdPartyId(requestBody.billingId, requestBody.fullBean);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingsByIdsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByIdsResponseBody getBillingsByIdsTest(HttpServletRequest request, @RequestBody GetBillingsByIdsRequestBody requestBody) 
	{  
		return getBillingsByIds(request, requestBody);
	} // .end of getBillingByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingsByIds", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByIdsResponseBody getBillingsByIds(HttpServletRequest request, @RequestBody GetBillingsByIdsRequestBody requestBody) 
	{  
		GetBillingsByIdsResponseBody responseBody = new GetBillingsByIdsResponseBody();
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
			// TASK #1: Get full billing object, by given billing ID
			responseBody.billingList = billingService.getBillingListByIds( requestBody.billingIdList );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingByBillingNoTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingByBillingNoResponseBody getBillingByBillingNoTest(HttpServletRequest request, @RequestBody GetBillingByBillingNoRequestBody requestBody) 
	{  
		return getBillingByBillingNo(request, requestBody);
	} // .end of getBillingByBillingNoTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingByBillingNo", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingByBillingNoResponseBody getBillingByBillingNo(HttpServletRequest request, @RequestBody GetBillingByBillingNoRequestBody requestBody) 
	{  
		GetBillingByBillingNoResponseBody responseBody = new GetBillingByBillingNoResponseBody();
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
			// TASK #1: Get full billing object, by given billing ID
			responseBody.billingObj = billingService.getBillingByBillingNo( requestBody.placeId, requestBody.billingNo, requestBody.fullBean );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingByBillingNo
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingByQuotationNoTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingByQuotationNoResponseBody getBillingByQuotationNoTest(HttpServletRequest request, @RequestBody GetBillingByQuotationNoRequestBody requestBody) 
	{  
		return getBillingByQuotationNo(request, requestBody);
	} // .end of getBillingByQuotationNoTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingByQuotationNo", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingByQuotationNoResponseBody getBillingByQuotationNo(HttpServletRequest request, @RequestBody GetBillingByQuotationNoRequestBody requestBody) 
	{  
		GetBillingByQuotationNoResponseBody responseBody = new GetBillingByQuotationNoResponseBody();
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
			// TASK #1: Get full billing object, by given billing ID
			responseBody.billingObj = billingService.getBillingByQuotationNo( requestBody.quotationNo, requestBody.fullBean );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingByBillingNo

	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingsByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByPlaceResponseBody getBillingsByPlaceTest(HttpServletRequest request, @RequestBody GetBillingsByPlaceRequestBody requestBody) 
	{  
		return getBillingsByPlace(request, requestBody);
	} // .end of getBillingsByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingsByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByPlaceResponseBody getBillingsByPlace(HttpServletRequest request, @RequestBody GetBillingsByPlaceRequestBody requestBody) 
	{  
		GetBillingsByPlaceResponseBody responseBody = new GetBillingsByPlaceResponseBody();
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
			BillingSearchCriteria criteria1 = new BillingSearchCriteria( requestBody.placeId );
			criteria1.setFullBean( requestBody.fullBean );
			criteria1.setFilterByLastSyncedTime( false );
			criteria1.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			
			//InventorySearchCriteria criteria2 = new InventorySearchCriteria( requestBody.placeId );
			//criteria2.setFullBean( requestBody.fullBean );
			//criteria2.setFilterByLastSyncedTime( false );
			//criteria2.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			
			responseBody.billingList = billingService.getBillingCompactViewsByPlaceId( criteria1 );
			//responseBody.transactionList = inventoryService.getTransactionsByPlaceId( criteria2 );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingsByPlace
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingsByCustomerTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByCustomerResponseBody getBillingsByCustomerTest(HttpServletRequest request, @RequestBody GetBillingsByCustomerRequestBody requestBody) 
	{  
		return getBillingsByCustomer(request, requestBody);
	} // .end of getBillingsByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingsByCustomer", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByCustomerResponseBody getBillingsByCustomer(HttpServletRequest request, @RequestBody GetBillingsByCustomerRequestBody requestBody) 
	{  
		GetBillingsByCustomerResponseBody responseBody = new GetBillingsByCustomerResponseBody();
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
			BillingSearchCriteria criteria1 = new BillingSearchCriteria( requestBody.placeId );
			criteria1.setCustomerId( requestBody.customerId );
			criteria1.setFullBean( requestBody.fullBean );
			criteria1.setFilterByLastSyncedTime( false );
			criteria1.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			
			responseBody.billingList = billingService.getBillingsByCustomerId( criteria1 );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingsByCustomer
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingsByEmployeeTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByEmployeeResponseBody getBillingsByEmployeeTest(HttpServletRequest request, @RequestBody GetBillingsByEmployeeRequestBody requestBody) 
	{  
		return getBillingsByEmployee(request, requestBody);
	} // .end of getBillingsByEmployeeTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingsByEmployee", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByEmployeeResponseBody getBillingsByEmployee(HttpServletRequest request, @RequestBody GetBillingsByEmployeeRequestBody requestBody) 
	{  
		GetBillingsByEmployeeResponseBody responseBody = new GetBillingsByEmployeeResponseBody();
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
			// TASK #1: Get billing list, by given employee ID
			responseBody.billingList = billingService.getBillingCompactViewsByEmployeeId( requestBody.placeId, requestBody.employeeId );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingsByEmployee
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingsByBucketTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByBucketResponseBody getBillingsByBucketTest(HttpServletRequest request, @RequestBody GetBillingsByBucketRequestBody requestBody) 
	{  
		return getBillingsByBucket(request, requestBody);
	} // .end of getBillingsByBucketTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingsByBucket", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByBucketResponseBody getBillingsByBucket(HttpServletRequest request, @RequestBody GetBillingsByBucketRequestBody requestBody) 
	{  
		GetBillingsByBucketResponseBody responseBody = new GetBillingsByBucketResponseBody();
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
			BillingSearchCriteria criteria = new BillingSearchCriteria( requestBody.placeId );
			criteria.setBucketId( requestBody.bucketId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			// Query
			responseBody.billingList = billingService.getBillingsByBucketId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingsByBucket
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingsByTimePeriodTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByTimePeriodResponseBody getBillingsByTimePeriodTest(HttpServletRequest request, @RequestBody GetBillingsByTimePeriodRequestBody requestBody) 
	{  
		return getBillingsByTimePeriod(request, requestBody);
	} // .end of getBillingsByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingsByTimePeriod", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByTimePeriodResponseBody getBillingsByTimePeriod(HttpServletRequest request, @RequestBody GetBillingsByTimePeriodRequestBody requestBody) 
	{  
		GetBillingsByTimePeriodResponseBody responseBody = new GetBillingsByTimePeriodResponseBody();
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
			BillingSearchCriteria criteria1 = new BillingSearchCriteria( requestBody.placeId );
			criteria1.setBeginTime( requestBody.beginTime );
			criteria1.setEndTime( requestBody.endTime );
			criteria1.setFullBean( requestBody.fullBean );
			criteria1.setFilterByLastSyncedTime( false );
			criteria1.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			criteria1.setFilterByBillingDate( requestBody.byBillingDate);
			criteria1.setFilterByInvoiceDate( requestBody.byInvoiceDate);
			
			responseBody.billingList = billingService.getBillingsByTimePeriod( criteria1 );			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingsByTimePeriod
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBillingsByPaymentTimePeriodTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByPaymentTimePeriodResponseBody getBillingsByPaymentTimePeriodTest(HttpServletRequest request, @RequestBody GetBillingsByPaymentTimePeriodRequestBody requestBody) 
	{  
		return getBillingsByPaymentTimePeriod(request, requestBody);
	} // .end of getBillingsByPaymentTimePeriodTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBillingsByPaymentTimePeriod", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBillingsByPaymentTimePeriodResponseBody getBillingsByPaymentTimePeriod(HttpServletRequest request, @RequestBody GetBillingsByPaymentTimePeriodRequestBody requestBody) 
	{  
		GetBillingsByPaymentTimePeriodResponseBody responseBody = new GetBillingsByPaymentTimePeriodResponseBody();
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
			BillingSearchCriteria criteria = new BillingSearchCriteria( requestBody.placeId );
			criteria.setBeginTime( requestBody.beginTime );
			criteria.setEndTime( requestBody.endTime );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			
			responseBody.billingList = billingService.getBillingsByPaymentTimePeriod( criteria );
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBillingsByPaymentTimePeriod
	
	//--------------------------------------------------------------------------
}  