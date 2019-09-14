package com.tychees.console.controller.customer;

import java.sql.Timestamp;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin; 
import org.springframework.web.bind.annotation.RequestBody;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.tychees.core.bean.customer.CustomerAddressBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.customer.CustomerContactBean;
import com.tychees.core.bean.customer.CustomerEmailBean;
import com.tychees.core.bean.customer.CustomerPropertiesBean;
import com.tychees.core.bean.place.PlaceNotificationBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.controller.RequestStatus;
import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.taskqueue.TaskOptions;
import com.google.appengine.api.taskqueue.TaskOptions.Method;
import com.google.gson.Gson;
import com.tychees.console.controller.customer.request.BatchDownloadCustomerAddressesRequestBody;
import com.tychees.console.controller.customer.request.BatchDownloadCustomerContactsRequestBody;
import com.tychees.console.controller.customer.request.BatchDownloadCustomerEmailsRequestBody;
import com.tychees.console.controller.customer.request.BatchDownloadCustomersRequestBody;
import com.tychees.console.controller.customer.request.BatchUpdateCustomerAddressesRequestBody;
import com.tychees.console.controller.customer.request.BatchUpdateCustomerContactsRequestBody;
import com.tychees.console.controller.customer.request.BatchUpdateCustomerEmailsRequestBody;
import com.tychees.console.controller.customer.request.BatchUpdateCustomersRequestBody;
import com.tychees.console.controller.customer.request.GetCustomerByContactRequestBody;
import com.tychees.console.controller.customer.request.GetCustomerByCustomerNoRequestBody;
import com.tychees.console.controller.customer.request.GetCustomerByEmailRequestBody;
import com.tychees.console.controller.customer.request.GetCustomerByIdRequestBody;
import com.tychees.console.controller.customer.request.GetCustomerByNameRequestBody;
import com.tychees.console.controller.customer.request.GetCustomerFilterCriteriaByPlaceRequestBody;
import com.tychees.console.controller.customer.request.GetCustomersByEmployeeRequestBody;
import com.tychees.console.controller.customer.request.GetCustomersByIdsRequestBody;
import com.tychees.console.controller.customer.request.GetCustomersByKeywordsRequestBody;
import com.tychees.console.controller.customer.request.GetCustomersByPlaceRequestBody;
import com.tychees.console.controller.customer.response.BatchDownloadCustomerAddressesResponseBody;
import com.tychees.console.controller.customer.response.BatchDownloadCustomerContactsResponseBody;
import com.tychees.console.controller.customer.response.BatchDownloadCustomerEmailsResponseBody;
import com.tychees.console.controller.customer.response.BatchDownloadCustomersResponseBody;
import com.tychees.console.controller.customer.response.BatchUpdateCustomerAddressesResponseBody;
import com.tychees.console.controller.customer.response.BatchUpdateCustomerContactsResponseBody;
import com.tychees.console.controller.customer.response.BatchUpdateCustomerEmailsResponseBody;
import com.tychees.console.controller.customer.response.BatchUpdateCustomersResponseBody;
import com.tychees.console.controller.customer.response.GetCustomerByContactResponseBody;
import com.tychees.console.controller.customer.response.GetCustomerByCustomerNoResponseBody;
import com.tychees.console.controller.customer.response.GetCustomerByEmailResponseBody;
import com.tychees.console.controller.customer.response.GetCustomerByIdResponseBody;
import com.tychees.console.controller.customer.response.GetCustomerByNameResponseBody;
import com.tychees.console.controller.customer.response.GetCustomerFilterCriteriaByPlaceResponseBody;
import com.tychees.console.controller.customer.response.GetCustomersByEmployeeResponseBody;
import com.tychees.console.controller.customer.response.GetCustomersByIdsResponseBody;
import com.tychees.console.controller.customer.response.GetCustomersByKeywordsResponseBody;
import com.tychees.console.controller.customer.response.GetCustomersByPlaceResponseBody;
import com.tychees.core.service.CustomerService;
import com.tychees.core.service.PlaceService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.CustomerSearchCriteria;
import com.tychees.core.util.BeanUtil;
import com.tychees.core.util.CustomerUtil;
  
@RestController  
public class CustomerController {  
   
	@Autowired
	BeanUtil BEAN_UTIL;
	@Autowired
	CustomerUtil CUSTOMER_UTIL;
	@Autowired 
	CustomerService customerService;  
	@Autowired 
	PlaceService placeService;  
	@Autowired
	UserService userService;
   
	private final static Logger LOGGER = Logger.getLogger(CustomerController.class.getName());
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCustomerByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByIdResponseBody getCustomerByIdTest(HttpServletRequest request, @RequestBody GetCustomerByIdRequestBody requestBody) 
	{  
		return getCustomerById(request, requestBody);
	} // .end of getCustomersByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomerById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByIdResponseBody getCustomerById(HttpServletRequest request, @RequestBody GetCustomerByIdRequestBody requestBody) 
	{  
		GetCustomerByIdResponseBody responseBody = new GetCustomerByIdResponseBody();
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
			// TASK #1: Get customer list, by given place ID
			responseBody.customerObj = customerService.getCustomerById( requestBody.customerId );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomerById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCustomerByCustomerNoTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByCustomerNoResponseBody getCustomerByCustomerNoTest(HttpServletRequest request, @RequestBody GetCustomerByCustomerNoRequestBody requestBody) 
	{  
		return getCustomerByCustomerNo(request, requestBody);
	} // .end of getCustomerByCustomerNoTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomerByCustomerNo", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByCustomerNoResponseBody getCustomerByCustomerNo(HttpServletRequest request, @RequestBody GetCustomerByCustomerNoRequestBody requestBody) 
	{  
		GetCustomerByCustomerNoResponseBody responseBody = new GetCustomerByCustomerNoResponseBody();
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
			// TASK #1: Get customer list, by given place ID
			responseBody.customerObj = customerService.getCustomerByCustomerNo( requestBody.customerNo );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomerByCustomerNo
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCustomerByNameTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByNameResponseBody getCustomerByNameTest(HttpServletRequest request, @RequestBody GetCustomerByNameRequestBody requestBody) 
	{  
		return getCustomerByName(request, requestBody);
	} // .end of getCustomerByNameTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomerByName", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByNameResponseBody getCustomerByName(HttpServletRequest request, @RequestBody GetCustomerByNameRequestBody requestBody) 
	{  
		GetCustomerByNameResponseBody responseBody = new GetCustomerByNameResponseBody();
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
			// TASK #1: Get customer, by given customer name
			//responseBody.customerObj = customerService.getCustomerByName( requestBody.customerName );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomerByName
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCustomerByContactTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByContactResponseBody getCustomerByContactTest(HttpServletRequest request, @RequestBody GetCustomerByContactRequestBody requestBody) 
	{  
		return getCustomerByContact(request, requestBody);
	} // .end of getCustomerByContactTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomerByContact", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByContactResponseBody getCustomerByContact(HttpServletRequest request, @RequestBody GetCustomerByContactRequestBody requestBody) 
	{  
		GetCustomerByContactResponseBody responseBody = new GetCustomerByContactResponseBody();
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
			// TASK #1: Get customer, by given customer contact
			//responseBody.customerObj = customerService.getCustomerByContact( requestBody.customerContact );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomerByContact
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCustomerByEmailTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByEmailResponseBody getCustomerByEmailTest(HttpServletRequest request, @RequestBody GetCustomerByEmailRequestBody requestBody) 
	{  
		return getCustomerByEmail(request, requestBody);
	} // .end of getCustomerByEmailTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomerByEmail", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerByEmailResponseBody getCustomerByEmail(HttpServletRequest request, @RequestBody GetCustomerByEmailRequestBody requestBody) 
	{  
		GetCustomerByEmailResponseBody responseBody = new GetCustomerByEmailResponseBody();
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
			// TASK #1: Get customer, by given customer email
			//responseBody.customerObj = customerService.getCustomerByEmail( requestBody.customerEmail );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomerByEmail	
		
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCustomersByIdsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomersByIdsResponseBody getCustomerByIdTest(HttpServletRequest request, @RequestBody GetCustomersByIdsRequestBody requestBody) 
	{  
		return getCustomersByIds(request, requestBody);
	} // .end of getCustomersByIdsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomersByIds", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomersByIdsResponseBody getCustomersByIds(HttpServletRequest request, @RequestBody GetCustomersByIdsRequestBody requestBody) 
	{  
		GetCustomersByIdsResponseBody responseBody = new GetCustomersByIdsResponseBody();
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
			// TASK #1: Get customer list, by given place ID
			responseBody.customerList = customerService.getCustomerListByIds( requestBody.customerIdList );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomerById
	
	//--------------------------------------------------------------------------
		
	@RequestMapping(value = "/console/getCustomersByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomersByPlaceResponseBody getCustomersByPlaceTest(HttpServletRequest request, @RequestBody GetCustomersByPlaceRequestBody requestBody) 
	{  
		return getCustomersByPlace(request, requestBody);
	} // .end of getCustomersByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomersByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomersByPlaceResponseBody getCustomersByPlace(HttpServletRequest request, @RequestBody GetCustomersByPlaceRequestBody requestBody) 
	{  
		GetCustomersByPlaceResponseBody responseBody = new GetCustomersByPlaceResponseBody();
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
			// TASK #1: Get customer list, by given place ID
			CustomerSearchCriteria criteria = new CustomerSearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			
			responseBody.customerList = customerService.getCustomerCompactViewsByPlaceId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomersByPlace
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCustomersByEmployeeTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomersByEmployeeResponseBody getCustomersByEmployeeTest(HttpServletRequest request, @RequestBody GetCustomersByEmployeeRequestBody requestBody) 
	{  
		return getCustomersByEmployee(request, requestBody);
	} // .end of getCustomersByEmployeeTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomersByEmployee", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomersByEmployeeResponseBody getCustomersByEmployee(HttpServletRequest request, @RequestBody GetCustomersByEmployeeRequestBody requestBody) 
	{  
		GetCustomersByEmployeeResponseBody responseBody = new GetCustomersByEmployeeResponseBody();
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
			// TASK #1: Get customer list, by given employee ID
			responseBody.customerList = customerService.getCustomerCompactViewsByEmployeeId( requestBody.placeId, requestBody.employeeId );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomersByEmployee
		
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCustomersByKeywordsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomersByKeywordsResponseBody getCustomersByKeywordsTest(HttpServletRequest request, @RequestBody GetCustomersByKeywordsRequestBody requestBody) 
	{  
		return getCustomersByKeywords(request, requestBody);
	} // .end of getCustomersByKeywordsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomersByKeywords", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomersByKeywordsResponseBody getCustomersByKeywords(HttpServletRequest request, @RequestBody GetCustomersByKeywordsRequestBody requestBody) 
	{  
		GetCustomersByKeywordsResponseBody responseBody = new GetCustomersByKeywordsResponseBody();
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
			// TASK #1: Get customer list, by given place ID & keywords
			responseBody.customerList = customerService.getCustomerCompactViewsByKeywords( requestBody.placeId, requestBody.keywords );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomersByKeywords
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCustomerFilterCriteriaByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerFilterCriteriaByPlaceResponseBody getCustomerFilterCriteriaByPlaceTest(HttpServletRequest request, @RequestBody GetCustomerFilterCriteriaByPlaceRequestBody requestBody) 
	{  
		return getCustomerFilterCriteriaByPlace(request, requestBody);
	} // .end of getCustomerFilterCriteriaByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCustomerFilterCriteriaByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCustomerFilterCriteriaByPlaceResponseBody getCustomerFilterCriteriaByPlace(HttpServletRequest request, @RequestBody GetCustomerFilterCriteriaByPlaceRequestBody requestBody) 
	{  
		GetCustomerFilterCriteriaByPlaceResponseBody responseBody = new GetCustomerFilterCriteriaByPlaceResponseBody();
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
			// TASK #1: Get customer list, by given place ID
			responseBody.typeList = customerService.getCustomerTypesByPlaceId(requestBody.placeId);
			responseBody.stateList = customerService.getCustomerStatesByPlaceId(requestBody.placeId);
			responseBody.areaList = customerService.getCustomerAreasByPlaceId(requestBody.placeId);
			responseBody.cityList = customerService.getCustomerCitiesByPlaceId(requestBody.placeId);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCustomersByPlace
	
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchUpdateCustomersTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateCustomersResponseBody batchUpdateCustomersTest(HttpServletRequest request, @RequestBody BatchUpdateCustomersRequestBody requestBody) 
	{  
		return batchUpdateCustomers(request, requestBody);
	} // .end of batchUpdateCustomersTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchUpdateCustomers", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateCustomersResponseBody batchUpdateCustomers(HttpServletRequest request, @RequestBody BatchUpdateCustomersRequestBody requestBody) 
	{  
		BatchUpdateCustomersResponseBody responseBody = new BatchUpdateCustomersResponseBody();
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
			for (CustomerBean customerObj : requestBody.listForInsert) 
			{
				customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());
			}

			for (CustomerBean customerObj : requestBody.listForUpdate) 
			{
				CustomerBean existingObj = customerService.getCustomerById(customerObj.getId());
				if (existingObj == null)
					continue;
				
				existingObj.setCustomerNo(customerObj.getCustomerNo());
				existingObj.setFirstName(customerObj.getFirstName());
				existingObj.setLastName(customerObj.getLastName());
				existingObj.setGender(customerObj.getGender());
				existingObj.setDob(customerObj.getDob());
				existingObj.setDescription(customerObj.getDescription());
				
				for (CustomerPropertiesBean existingPropObj : existingObj.propertiesList) 
				{
					for (CustomerPropertiesBean updatedPropObj : customerObj.propertiesList) 
					{
						if (existingPropObj.getPropKey().equals(updatedPropObj.getPropKey()))
						{
							existingPropObj.setPropValue(updatedPropObj.getPropValue());
						}
					}
				}
				
				customerService.saveOrUpdateCustomer(existingObj, sessionObj.getUserId());	
			}

			for (CustomerBean customerObj : requestBody.listForDelete) 
			{
				customerObj.setDeletedBy(sessionObj.getUserId());
				customerObj.setDeletedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

				customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());	
			}
			
			// Prepare summary
			int totalProcessCount = requestBody.listForInsert.size() + requestBody.listForUpdate.size() + requestBody.listForDelete.size();
			// Set notification to user
			PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
			notificationObj.setName("Batch Update Customers is Completed");
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
	} // .end of batchUpdateCustomers
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchUpdateCustomerContactsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateCustomerContactsResponseBody batchUpdateCustomerContactsTest(HttpServletRequest request, @RequestBody BatchUpdateCustomerContactsRequestBody requestBody) 
	{  
		return batchUpdateCustomerContacts(request, requestBody);
	} // .end of batchUpdateCustomersTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchUpdateCustomerContacts", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateCustomerContactsResponseBody batchUpdateCustomerContacts(HttpServletRequest request, @RequestBody BatchUpdateCustomerContactsRequestBody requestBody) 
	{  
		BatchUpdateCustomerContactsResponseBody responseBody = new BatchUpdateCustomerContactsResponseBody();
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
			for (CustomerContactBean contactObj : requestBody.listForInsert) 
			{
				CustomerBean customerObj = customerService.getCustomerById(contactObj.getCustomerId());
				if (customerObj != null) {
					customerObj.contactList.add(contactObj);
					if (contactObj.isDefaultContact()) {
						customerObj.setContact( BEAN_UTIL.formatContactBeanToString(contactObj) );
						
						for (CustomerContactBean beanObj : customerObj.contactList) {
							if (beanObj.getId().equals(contactObj.getId()))
								continue;
							
							beanObj.setDefaultContact(false);
						}
					}					
					
					customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());	
					LOGGER.info("INSERT > " + contactObj.getPhoneNumber());
				}
			}

			for (CustomerContactBean contactObj : requestBody.listForUpdate) 
			{
				CustomerBean customerObj = customerService.getCustomerById(contactObj.getCustomerId());
				if (customerObj != null) {
				
					CustomerContactBean existingObj = null;
					for (CustomerContactBean beanObj : customerObj.contactList) {
						if (beanObj.getId().trim().equals(contactObj.getId().trim())) {
							existingObj = beanObj;
						}
					}
					
					if (existingObj == null) {
						customerObj.contactList.add(contactObj);	
						if (contactObj.isDefaultContact()) {
							customerObj.setContact( BEAN_UTIL.formatContactBeanToString(contactObj) );
							
							for (CustomerContactBean beanObj : customerObj.contactList) {
								if (beanObj.getId().equals(contactObj.getId()))
									continue;
								
								beanObj.setDefaultContact(false);
							}
						}
					} else {
						if (existingObj.isDefaultContact() && !contactObj.isDefaultContact()) {
							customerObj.setContact("");
						}
						
						existingObj.setType(contactObj.getType());
						existingObj.setCountryCode(contactObj.getCountryCode());
						existingObj.setAreaCode(contactObj.getAreaCode());
						existingObj.setPhoneNumber(contactObj.getPhoneNumber());
						existingObj.setExtension(contactObj.getExtension());
						existingObj.setDefaultContact(contactObj.isDefaultContact());
						
						if (existingObj.isDefaultContact()) {
							customerObj.setContact( BEAN_UTIL.formatContactBeanToString(contactObj) );
							
							for (CustomerContactBean beanObj : customerObj.contactList) {
								if (beanObj.getId().equals(contactObj.getId()))
									continue;
								
								beanObj.setDefaultContact(false);
							}
						}
					}				
										
					customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());	
					LOGGER.info("UPDATE > " + customerObj.getCustomerNo());
				}
			}

			for (CustomerContactBean contactObj : requestBody.listForDelete) 
			{
				CustomerBean customerObj = customerService.getCustomerById(contactObj.getCustomerId());
				if (customerObj != null) {
				
					CustomerContactBean existingObj = null;
					for (CustomerContactBean beanObj : customerObj.contactList) {
						if (beanObj.getId().trim().equals(contactObj.getId().trim())) {
							existingObj = beanObj;
						}
					}
					
					if (existingObj != null) {
						existingObj.setDeletedBy(sessionObj.getUserId());
						existingObj.setDeletedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

						if (existingObj.isDefaultContact()) {
							customerObj.setContact("");
						}
						
						customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());	
						LOGGER.info("DELETE > " + customerObj.getCustomerNo());
					}
				}
			}
			
			// Prepare summary
			int totalProcessCount = requestBody.listForInsert.size() + requestBody.listForUpdate.size() + requestBody.listForDelete.size();
			// Set notification to user
			PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
			notificationObj.setName("Batch Update Customer Contacts is Completed");
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
	} // .end of batchUpdateCustomerContacts
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchUpdateCustomerEmailsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateCustomerEmailsResponseBody batchUpdateCustomerEmailsTest(HttpServletRequest request, @RequestBody BatchUpdateCustomerEmailsRequestBody requestBody) 
	{  
		return batchUpdateCustomerEmails(request, requestBody);
	} // .end of batchUpdateCustomerEmailsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchUpdateCustomerEmails", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateCustomerEmailsResponseBody batchUpdateCustomerEmails(HttpServletRequest request, @RequestBody BatchUpdateCustomerEmailsRequestBody requestBody) 
	{  
		BatchUpdateCustomerEmailsResponseBody responseBody = new BatchUpdateCustomerEmailsResponseBody();
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
			for (CustomerEmailBean emailObj : requestBody.listForInsert) 
			{
				CustomerBean customerObj = customerService.getCustomerById(emailObj.getCustomerId());
				if (customerObj != null) {
					customerObj.emailList.add(emailObj);
					if (emailObj.isDefaultEmail()) {
						customerObj.setEmail( emailObj.getEmailAddress() );
						
						for (CustomerEmailBean beanObj : customerObj.emailList) {
							if (beanObj.getId().equals(emailObj.getId()))
								continue;
							
							beanObj.setDefaultEmail(false);
						}
					}					
					
					customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());	
					LOGGER.info("INSERT > " + emailObj.getEmailAddress());
				}
			}

			for (CustomerEmailBean emailObj : requestBody.listForUpdate) 
			{
				CustomerBean customerObj = customerService.getCustomerById(emailObj.getCustomerId());
				if (customerObj != null) {
				
					CustomerEmailBean existingObj = null;
					for (CustomerEmailBean beanObj : customerObj.emailList) {
						if (beanObj.getId().trim().equals(emailObj.getId().trim())) {
							existingObj = beanObj;
						}
					}
					
					if (existingObj == null) {
						customerObj.emailList.add(emailObj);	
						if (emailObj.isDefaultEmail()) {
							customerObj.setEmail( emailObj.getEmailAddress() );
							
							for (CustomerEmailBean beanObj : customerObj.emailList) {
								if (beanObj.getId().equals(emailObj.getId()))
									continue;
								
								beanObj.setDefaultEmail(false);
							}
						}
					} else {
						if (existingObj.isDefaultEmail() && !emailObj.isDefaultEmail()) {
							customerObj.setEmail("");
						}
						
						existingObj.setType(emailObj.getType());
						existingObj.setEmailAddress(emailObj.getEmailAddress());
						existingObj.setDefaultEmail(emailObj.isDefaultEmail());
						
						if (existingObj.isDefaultEmail()) {
							customerObj.setEmail( emailObj.getEmailAddress() );
							
							for (CustomerEmailBean beanObj : customerObj.emailList) {
								if (beanObj.getId().equals(emailObj.getId()))
									continue;
								
								beanObj.setDefaultEmail(false);
							}
						}
					}				
										
					customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());	
					LOGGER.info("UPDATE > " + emailObj.getEmailAddress());
				}
			}

			for (CustomerEmailBean emailObj : requestBody.listForDelete) 
			{
				CustomerBean customerObj = customerService.getCustomerById(emailObj.getCustomerId());
				if (customerObj != null) {
				
					CustomerEmailBean existingObj = null;
					for (CustomerEmailBean beanObj : customerObj.emailList) {
						if (beanObj.getId().trim().equals(emailObj.getId().trim())) {
							existingObj = emailObj;
						}
					}
					
					if (existingObj != null) {
						existingObj.setDeletedBy(sessionObj.getUserId());
						existingObj.setDeletedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

						if (existingObj.isDefaultEmail()) {
							customerObj.setEmail("");
						}
						
						customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());	
						LOGGER.info("DELETE > " + emailObj.getEmailAddress());
					}
				}
			}
			
			// Prepare summary
			int totalProcessCount = requestBody.listForInsert.size() + requestBody.listForUpdate.size() + requestBody.listForDelete.size();
			// Set notification to user
			PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
			notificationObj.setName("Batch Update Customer Contacts is Completed");
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
	} // .end of batchUpdateCustomerEmails

	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchUpdateCustomerAddressesTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateCustomerAddressesResponseBody batchUpdateCustomerAddressesTest(HttpServletRequest request, @RequestBody BatchUpdateCustomerAddressesRequestBody requestBody) 
	{  
		return batchUpdateCustomerAddresses(request, requestBody);
	} // .end of batchUpdateCustomerAddressesTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchUpdateCustomerAddresses", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchUpdateCustomerAddressesResponseBody batchUpdateCustomerAddresses(HttpServletRequest request, @RequestBody BatchUpdateCustomerAddressesRequestBody requestBody) 
	{  
		BatchUpdateCustomerAddressesResponseBody responseBody = new BatchUpdateCustomerAddressesResponseBody();
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
			for (CustomerAddressBean addressObj : requestBody.listForInsert) 
			{
				CustomerBean customerObj = customerService.getCustomerById(addressObj.getCustomerId());
				if (customerObj != null) {
					customerObj.addressList.add(addressObj);
					if (addressObj.isDefaultAddress()) {
						customerObj.setAddress( BEAN_UTIL.formatAddressBeanToString(addressObj) );
						
						for (CustomerAddressBean beanObj : customerObj.addressList) {
							if (beanObj.getId().equals(addressObj.getId()))
								continue;
							
							beanObj.setDefaultAddress(false);
						}
					}					
					
					customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());
				}
			}

			for (CustomerAddressBean addressObj : requestBody.listForUpdate) 
			{
				CustomerBean customerObj = customerService.getCustomerById(addressObj.getCustomerId());
				if (customerObj != null) {
				
					CustomerAddressBean existingObj = null;
					for (CustomerAddressBean beanObj : customerObj.addressList) {
						if (beanObj.getId().trim().equals(addressObj.getId().trim())) {
							existingObj = beanObj;
						}
					}
					
					if (existingObj == null) {
						customerObj.addressList.add(addressObj);	
						if (addressObj.isDefaultAddress()) {
							customerObj.setAddress( BEAN_UTIL.formatAddressBeanToString(addressObj) );
							
							for (CustomerAddressBean beanObj : customerObj.addressList) {
								if (beanObj.getId().equals(addressObj.getId()))
									continue;
								
								beanObj.setDefaultAddress(false);
							}
						}
					} else {
						if (existingObj.isDefaultAddress() && !addressObj.isDefaultAddress()) {
							customerObj.setAddress("");
						}
						
						existingObj.setType(addressObj.getType());
						existingObj.setAttentionTo(addressObj.getAttentionTo());
						existingObj.setStreetLine1(addressObj.getStreetLine1());
						existingObj.setStreetLine2(addressObj.getStreetLine2());
						existingObj.setStreetLine3(addressObj.getStreetLine3());
						existingObj.setPostalCode(addressObj.getPostalCode());
						existingObj.setCity(addressObj.getCity());
						existingObj.setState(addressObj.getState());
						existingObj.setCountry(addressObj.getCountry());
						existingObj.setDefaultAddress(addressObj.isDefaultAddress());
						
						if (existingObj.isDefaultAddress()) {
							customerObj.setAddress( BEAN_UTIL.formatAddressBeanToString(addressObj) );
							
							for (CustomerAddressBean beanObj : customerObj.addressList) {
								if (beanObj.getId().equals(addressObj.getId()))
									continue;
								
								beanObj.setDefaultAddress(false);
							}
						}
					}				
										
					customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());
				}
			}

			for (CustomerAddressBean addressObj : requestBody.listForDelete) 
			{
				CustomerBean customerObj = customerService.getCustomerById(addressObj.getCustomerId());
				if (customerObj != null) {
				
					CustomerAddressBean existingObj = null;
					for (CustomerAddressBean beanObj : customerObj.addressList) {
						if (beanObj.getId().trim().equals(addressObj.getId().trim())) {
							existingObj = addressObj;
						}
					}
					
					if (existingObj != null) {
						existingObj.setDeletedBy(sessionObj.getUserId());
						existingObj.setDeletedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

						if (existingObj.isDefaultAddress()) {
							customerObj.setAddress("");
						}
						
						customerService.saveOrUpdateCustomer(customerObj, sessionObj.getUserId());
					}
				}
			}
			
			// Prepare summary
			int totalProcessCount = requestBody.listForInsert.size() + requestBody.listForUpdate.size() + requestBody.listForDelete.size();
			// Set notification to user
			PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
			notificationObj.setName("Batch Update Customer Contacts is Completed");
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
	} // .end of batchUpdateCustomerEmails

	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchDownloadCustomersTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadCustomersResponseBody batchDownloadCustomersTest(HttpServletRequest request, @RequestBody BatchDownloadCustomersRequestBody requestBody) 
	{  
		return batchDownloadCustomers(request, requestBody);
	} // .end of batchDownloadCustomersTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchDownloadCustomers", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadCustomersResponseBody batchDownloadCustomers(HttpServletRequest request, @RequestBody BatchDownloadCustomersRequestBody requestBody) 
	{  
		BatchDownloadCustomersResponseBody responseBody = new BatchDownloadCustomersResponseBody();
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
				TaskOptions.Builder.withUrl("/queue/batchDownloadCustomers")
					.payload(requestBodyInString.getBytes(), "application/json")
					.method(Method.POST));
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadCustomers
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchDownloadCustomerContactsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadCustomerContactsResponseBody batchDownloadCustomerContactsTest(HttpServletRequest request, @RequestBody BatchDownloadCustomerContactsRequestBody requestBody) 
	{  
		return batchDownloadCustomerContacts(request, requestBody);
	} // .end of batchDownloadCustomerContactsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchDownloadCustomerContacts", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadCustomerContactsResponseBody batchDownloadCustomerContacts(HttpServletRequest request, @RequestBody BatchDownloadCustomerContactsRequestBody requestBody) 
	{  
		BatchDownloadCustomerContactsResponseBody responseBody = new BatchDownloadCustomerContactsResponseBody();
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
				TaskOptions.Builder.withUrl("/queue/batchDownloadCustomerContacts")
					.payload(requestBodyInString.getBytes(), "application/json")
					.method(Method.POST));
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadCustomerContacts
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchDownloadCustomerEmailsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadCustomerEmailsResponseBody batchDownloadCustomerEmailsTest(HttpServletRequest request, @RequestBody BatchDownloadCustomerEmailsRequestBody requestBody) 
	{  
		return batchDownloadCustomerEmails(request, requestBody);
	} // .end of batchDownloadCustomerEmailsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchDownloadCustomerEmails", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadCustomerEmailsResponseBody batchDownloadCustomerEmails(HttpServletRequest request, @RequestBody BatchDownloadCustomerEmailsRequestBody requestBody) 
	{  
		BatchDownloadCustomerEmailsResponseBody responseBody = new BatchDownloadCustomerEmailsResponseBody();
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
				TaskOptions.Builder.withUrl("/queue/batchDownloadCustomerEmails")
					.payload(requestBodyInString.getBytes(), "application/json")
					.method(Method.POST));
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadCustomerEmails
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/batchDownloadCustomerAddressesTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadCustomerAddressesResponseBody batchDownloadCustomerAddressesTest(HttpServletRequest request, @RequestBody BatchDownloadCustomerAddressesRequestBody requestBody) 
	{  
		return batchDownloadCustomerAddresses(request, requestBody);
	} // .end of batchDownloadCustomerAddressesTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/batchDownloadCustomerAddresses", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public BatchDownloadCustomerAddressesResponseBody batchDownloadCustomerAddresses(HttpServletRequest request, @RequestBody BatchDownloadCustomerAddressesRequestBody requestBody) 
	{  
		BatchDownloadCustomerAddressesResponseBody responseBody = new BatchDownloadCustomerAddressesResponseBody();
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
				TaskOptions.Builder.withUrl("/queue/batchDownloadCustomerAddresses")
					.payload(requestBodyInString.getBytes(), "application/json")
					.method(Method.POST));
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadCustomerAddresses
	
	//--------------------------------------------------------------------------
}  