package com.tychees.console.controller.common;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.tychees.core.bean.billing.BillingDeliveryBean;
import com.tychees.core.bean.billing.BillingLineBean;
import com.tychees.core.bean.billing.BillingPaymentBean;
import com.tychees.core.bean.billing.BillingPaymentPropertiesBean;
import com.tychees.core.bean.billing.BillingPropertiesBean;
import com.tychees.core.bean.billing.BillingBucketBean;
import com.tychees.core.bean.billing.BillingBucketLineBean;
import com.tychees.core.bean.billing.BillingWorkflowBean;
import com.tychees.core.bean.billing.BillingWorkflowEventBean;
import com.tychees.core.bean.common.CommonCalendarBean;
import com.tychees.core.bean.common.CommonCalendarEventBean;
import com.tychees.core.bean.common.CommonTemplateBean;
import com.tychees.core.bean.common.CommonTemplatePropertiesBean;
import com.tychees.core.bean.customer.CustomerAddressBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.customer.CustomerContactBean;
import com.tychees.core.bean.customer.CustomerEmailBean;
import com.tychees.core.bean.customer.CustomerProfileBean;
import com.tychees.core.bean.customer.CustomerProfilePropertiesBean;
import com.tychees.core.bean.customer.CustomerPropertiesBean;
import com.tychees.core.bean.document.DocumentBean;
import com.tychees.core.bean.document.DocumentPropertiesBean;
import com.tychees.core.bean.employee.EmployeeAddressBean;
import com.tychees.core.bean.employee.EmployeeBean;
import com.tychees.core.bean.employee.EmployeeContactBean;
import com.tychees.core.bean.employee.EmployeeEmailBean;
import com.tychees.core.bean.employee.EmployeeJobBean;
import com.tychees.core.bean.employee.EmployeePropertiesBean;
import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.inventory.InventoryCategoryPropertiesBean;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.InventoryItemComponentBean;
import com.tychees.core.bean.inventory.InventoryItemImageBean;
import com.tychees.core.bean.inventory.InventoryItemPropertiesBean;
import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.bean.inventory.InventoryTransactionLineBean;
import com.tychees.core.bean.place.PlaceAccessBean;
import com.tychees.core.bean.place.PlaceAccessPropertiesBean;
import com.tychees.core.bean.place.PlaceAddressBean;
import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.place.PlaceContactBean;
import com.tychees.core.bean.place.PlaceDocumentBean;
import com.tychees.core.bean.place.PlaceDocumentPropertiesBean;
import com.tychees.core.bean.place.PlaceDocumentTemplateBean;
import com.tychees.core.bean.place.PlaceDocumentTemplateComponentBean;
import com.tychees.core.bean.place.PlaceImageBean;
import com.tychees.core.bean.place.PlaceLabelBean;
import com.tychees.core.bean.place.PlaceLayoutBean;
import com.tychees.core.bean.place.PlaceLayoutComponentBean;
import com.tychees.core.bean.place.PlaceOperatingHourBean;
import com.tychees.core.bean.place.PlacePropertiesBean;
import com.tychees.core.bean.place.PlaceRoleBean;
import com.tychees.core.bean.place.PlaceSettingsBean;
import com.tychees.core.bean.place.PlaceWorkflowBean;
import com.tychees.core.bean.place.PlaceWorkflowEventBean;
import com.tychees.core.bean.user.UserAccessRightBean;
import com.tychees.core.bean.user.UserActionBean;
import com.tychees.core.bean.user.UserBean;
import com.tychees.core.bean.user.UserPropertiesBean;
import com.tychees.core.bean.user.UserRoleBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.constants.BeanConstants;
import com.tychees.core.constants.BillingConstants;
import com.tychees.core.constants.CustomerConstants;
import com.tychees.core.constants.DocumentConstants;
import com.tychees.core.constants.InventoryConstants;
import com.tychees.core.constants.ModuleConstants;
import com.tychees.core.constants.PlaceConstants;
import com.tychees.core.constants.SettingsConstants;
import com.tychees.core.constants.UserConstants;
import com.tychees.core.controller.AbstractController;
import com.tychees.core.controller.RequestStatus;
import com.tychees.core.factory.PlaceFactory;
import com.tychees.console.controller.common.request.GetRecordListRequestBody;
import com.tychees.console.controller.common.request.GetAccountUsagesByPlaceRequestBody;
import com.tychees.console.controller.common.request.InitConsoleRequestBody;
import com.tychees.console.controller.common.request.SyncConsoleRequestBody;
import com.tychees.console.controller.common.request.SyncSessionRequestBody;
import com.tychees.console.controller.common.response.GetRecordListResponseBody;
import com.tychees.console.controller.common.response.GetAccountUsagesByPlaceResponseBody;
import com.tychees.console.controller.common.response.InitConsoleResponseBody;
import com.tychees.console.controller.common.response.SyncConsoleResponseBody;
import com.tychees.console.controller.common.response.SyncSessionResponseBody;
import com.tychees.core.service.BillingService;
import com.tychees.core.service.CustomerService;
import com.tychees.core.service.DocumentService;
import com.tychees.core.service.EmployeeService;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.PlaceService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.BillingSearchCriteria;
import com.tychees.core.service.criteria.CustomerSearchCriteria;
import com.tychees.core.service.criteria.DocumentSearchCriteria;
import com.tychees.core.service.criteria.InventorySearchCriteria;
import com.tychees.core.util.PlaceUtil;
  
@RestController  
public class ConsoleController 
	extends AbstractController {  
   
	@Autowired
	PlaceConstants PLACE_CONSTANTS;
	@Autowired
	PlaceFactory PLACE_FACTORY;
	@Autowired
	PlaceUtil PLACE_UTIL;
	@Autowired 
	BillingService billingService;  
	@Autowired 
	DocumentService documentService;  
	@Autowired 
	CustomerService customerService;   
	@Autowired 
	EmployeeService employeeService;   
	@Autowired 
	InventoryService inventoryService;  
	@Autowired 
	PlaceService placeService;  
	@Autowired 
	UserService userService;
	
	private static final Logger LOGGER = Logger.getLogger(ConsoleController.class.getName());

	//--------------------------------------------------------------------------
	/*
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/_ah/stop", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GenericResponseBody ahStop(HttpServletRequest request, @RequestBody GenericRequestBody requestBody) 
	{  
		GenericResponseBody responseBody = new GenericResponseBody();
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
			// TASK #1: Get User Object
			UserBean currentUserObj = userService.getUserBySessionId( requestBody.sessionId );
			
			if (currentUserObj == null) 
			{
				responseBody.status = RequestStatus.INVALID_USER;
			}
			else
			{
				// TASK #2.2: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of ahStop
	*/
	//--------------------------------------------------------------------------
	/*
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/_ah/start", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GenericResponseBody ahStart(HttpServletRequest request, @RequestBody GenericRequestBody requestBody) 
	{  
		GenericResponseBody responseBody = new GenericResponseBody();
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
			// TASK #1: Get User Object
			UserBean currentUserObj = userService.getUserBySessionId( requestBody.sessionId );
			
			if (currentUserObj == null) 
			{
				responseBody.status = RequestStatus.INVALID_USER;
			}
			else
			{
				// TASK #2.2: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of ahStart
	*/
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getAccountUsagesByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetAccountUsagesByPlaceResponseBody getAccountUsagesByPlaceTest(HttpServletRequest request, @RequestBody GetAccountUsagesByPlaceRequestBody requestBody) 
	{  
		return getAccountUsagesByPlace(request, requestBody);
	} // .end of getAccountUsagesByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getAccountUsagesByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetAccountUsagesByPlaceResponseBody getAccountUsagesByPlace(HttpServletRequest request, @RequestBody GetAccountUsagesByPlaceRequestBody requestBody) 
	{  
		GetAccountUsagesByPlaceResponseBody responseBody = new GetAccountUsagesByPlaceResponseBody();
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
			// TASK #1: Get User Object
			UserBean currentUserObj = userService.getUserBySessionId( requestBody.sessionId, false );
			
			if (currentUserObj == null) 
			{
				responseBody.status = RequestStatus.INVALID_USER;
			}
			else
			{
				// TASK #2.1: Get list of records and assign bean id into list
				responseBody.userUsageCount 			= userService.getUsersByPlaceId(requestBody.placeId, false).size();
				responseBody.customerUsageCount 		= customerService.getCustomerCountByPlaceId(requestBody.placeId).longValue();
				responseBody.employeeUsageCount 		= employeeService.getEmployeeCountByPlaceId(requestBody.placeId).longValue();
				responseBody.inventoryCategoryUsageCount= inventoryService.getCategoryCountByPlaceId(requestBody.placeId).longValue();
				responseBody.inventoryItemUsageCount 	= inventoryService.getItemCountByPlaceId(requestBody.placeId).longValue();
				responseBody.monthlyBillingUsageAmount 	= billingService.getMonthlyBillingAmountByPlaceId(requestBody.placeId);
				
				// TASK #2.2: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getAccountUsagesByPlace
	
	//--------------------------------------------------------------------------
	/*
	@RequestMapping(value = "/console/getRecordListTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetRecordListResponseBody getRecordListTest(HttpServletRequest request, @RequestBody GetRecordListRequestBody requestBody) 
	{  
		return getRecordList(request, requestBody);
	} // .end of getRecordListTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getRecordList", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetRecordListResponseBody getRecordList(HttpServletRequest request, @RequestBody GetRecordListRequestBody requestBody) 
	{  
		GetRecordListResponseBody responseBody = new GetRecordListResponseBody();
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
			// TASK #1: Get User Object
			UserBean currentUserObj = userService.getUserBySessionId( requestBody.sessionId, false );
			
			if (currentUserObj == null) 
			{
				responseBody.status = RequestStatus.INVALID_USER;
			}
			else
			{
				// TASK #2.1: Get list of records and assign bean id into list
				responseBody.billingList 	= billingService.getBillingIdsByPlaceId( new BillingSearchCriteria( requestBody.placeId ) );
				responseBody.customerList 	= customerService.getCustomerIdsByPlaceId( new CustomerSearchCriteria( requestBody.placeId ) );
				responseBody.documentList 	= documentService.getAllDocumentIds( new DocumentSearchCriteria( requestBody.placeId ) );
				responseBody.categoryList 	= inventoryService.getCategoryIdsByPlaceId( new InventorySearchCriteria( requestBody.placeId ) );
				responseBody.itemList 		= inventoryService.getItemIdsByPlaceId( new InventorySearchCriteria( requestBody.placeId ) );
				responseBody.transactionList= inventoryService.getTransactionIdsByPlaceId( new InventorySearchCriteria( requestBody.placeId ) );
				responseBody.placeList 		= placeService.getPlaceIdsByUserId( currentUserObj.getId(), false );
				responseBody.userList 		= userService.getUserIdsByPlaceId( requestBody.placeId, false );
				
				// TASK #2.2: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getRecordList
	*/
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/initConsoleTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public InitConsoleResponseBody initConsoleTest(HttpServletRequest request, @RequestBody InitConsoleRequestBody requestBody) 
	{  
		return initConsole(request, requestBody);
	} // .end of initConsoleTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/initConsole", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public InitConsoleResponseBody initConsole(HttpServletRequest request, @RequestBody InitConsoleRequestBody requestBody) 
	{  
		InitConsoleResponseBody responseBody = new InitConsoleResponseBody();
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
			// TASK #1: Get User Object
			UserBean currentUserObj = userService.getUserBySessionId( requestBody.sessionId, false );
			
			if (currentUserObj == null) 
			{
				responseBody.status = RequestStatus.INVALID_USER;
			}
			else
			{
				// Check user's status
				responseBody.resetPasswordRequired = currentUserObj.isResetPasswordRequired();
				responseBody.logoutRequired = currentUserObj.isLogoutRequired();
				
				// TASK #2.1: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
				responseBody.userId = currentUserObj.getId();
				responseBody.sessionId = requestBody.sessionId;
				responseBody.placeId = requestBody.placeId;
				
				// TASK #2.3: Load Constants
				loadConstants(requestBody, responseBody);
				
				// TASK #2.2: Get latest persistent objects from Database, based on lastSyncedTime
				//            - Any root data where updatedOn > lastSyncedTime.
				loadData(requestBody, responseBody, currentUserObj);
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		LOGGER.info("status: " + responseBody.status);
		
		return responseBody;
	} // .end of initConsole
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/syncConsoleTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public SyncConsoleResponseBody syncConsoleTest(HttpServletRequest request, @RequestBody SyncConsoleRequestBody requestBody) 
	{  
		return syncConsole(request, requestBody);
	} // .end of syncConsoleTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/syncConsole", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public SyncConsoleResponseBody syncConsole(HttpServletRequest request, @RequestBody SyncConsoleRequestBody requestBody) 
	{  
		SyncConsoleResponseBody responseBody = new SyncConsoleResponseBody();
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
			// TASK #1: Get User Object
			UserBean currentUserObj = userService.getUserBySessionId( requestBody.sessionId, false );
			
			if (currentUserObj == null) 
			{
				responseBody.status = RequestStatus.INVALID_USER;
			}
			else
			{
				// Check user's status
				responseBody.resetPasswordRequired = currentUserObj.isResetPasswordRequired();
				responseBody.logoutRequired = currentUserObj.isLogoutRequired();
				
				// TASK #2: Save or Update persistent objects.
				
				for (BillingBean billingObj : requestBody.billingList) {
					billingService.saveOrUpdateBilling( billingObj, currentUserObj.getId() );
				}
				
				for (BillingBucketBean billingBucketObj : requestBody.billingBucketList) {
					billingService.saveOrUpdateBillingBucket( billingBucketObj, currentUserObj.getId() );
				}	
				
				for (DocumentBean documentObj : requestBody.documentList) {
					documentService.saveOrUpdateDocument( documentObj, currentUserObj.getId() );
				}
					
				for (CustomerBean customerObj : requestBody.customerList) {
					customerService.saveOrUpdateCustomer( customerObj, currentUserObj.getId() );
				}
				
				for (EmployeeBean employeeObj : requestBody.employeeList) {
					employeeService.saveOrUpdateEmployee( employeeObj, currentUserObj.getId() );
				}
					
				for (InventoryCategoryBean categoryObj : requestBody.categoryList) {
					inventoryService.saveOrUpdateCategory( categoryObj, currentUserObj.getId() );
				}
					
				for (InventoryItemBean itemObj : requestBody.itemList) {
					inventoryService.saveOrUpdateItem( itemObj, currentUserObj.getId() );
				}
					
				for (InventoryTransactionBean transactionObj : requestBody.transactionList) {
					inventoryService.saveOrUpdateTransaction( transactionObj, currentUserObj.getId() );
				}
					
				for (PlaceBean placeObj : requestBody.placeList) {
					placeService.saveOrUpdatePlace( placeObj, currentUserObj.getId() );
				}
					
				for (UserBean userObj : requestBody.userList) {
					userService.saveOrUpdateUser( userObj, currentUserObj.getId() );
				}
				
				
				// TASK #3.1: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
				responseBody.userId = currentUserObj.getId();
				responseBody.sessionId = requestBody.sessionId;
				responseBody.placeId = requestBody.placeId;
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of syncConsole
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/syncSessionTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public SyncSessionResponseBody syncSessionTest(HttpServletRequest request, @RequestBody SyncSessionRequestBody requestBody) 
	{  
		return syncSession(request, requestBody);
	} // .end of syncSessionTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/syncSession", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public SyncSessionResponseBody syncSession(HttpServletRequest request, @RequestBody SyncSessionRequestBody requestBody) 
	{  
		SyncSessionResponseBody responseBody = new SyncSessionResponseBody();
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
			// TASK #1: Get User Object
			UserBean currentUserObj = userService.getUserBySessionId( requestBody.sessionId, false );
			
			if (currentUserObj == null) 
			{
				responseBody.status = RequestStatus.INVALID_USER;
			}
			else
			{
				// Get Last Sync Time
				Date lastSyncTime = new Date(requestBody.lastSyncedTime);
				
				// Check user's status
				responseBody.resetPasswordRequired = currentUserObj.isResetPasswordRequired();
				responseBody.logoutRequired = currentUserObj.isLogoutRequired();

				PlaceBean placeObj = placeService.getPlaceById(requestBody.placeId, true);
				UserBean userObj = userService.getUserById(currentUserObj.getId(), true);
				
				// If new changes found at place object
				//if (placeObj.getUpdatedOn().after(lastSyncTime)) {
				
					boolean savePlaceRequired = false;
					if (validatePlace(placeObj, currentUserObj))
						savePlaceRequired = true;
					
					// Get Usage
					long userUsageCount 				= userService.getUsersByPlaceId(requestBody.placeId, false).size();
					long customerUsageCount 			= customerService.getCustomerCountByPlaceId(requestBody.placeId).longValue();
					long employeeUsageCount 			= employeeService.getEmployeeCountByPlaceId(requestBody.placeId).longValue();
					long inventoryCategoryUsageCount	= inventoryService.getCategoryCountByPlaceId(requestBody.placeId).longValue();
					long inventoryItemUsageCount 		= inventoryService.getItemCountByPlaceId(requestBody.placeId).longValue();
					double monthlyBillingUsageAmount 	= billingService.getMonthlyBillingAmountByPlaceId(requestBody.placeId);
					
					for (PlacePropertiesBean propObj : placeObj.propertiesList) {
						if (PLACE_CONSTANTS.PLACE_PROP_KEY_USER_MAX_COUNT.equals(propObj.getPropKey())) 
							propObj.setPropContent(String.valueOf(userUsageCount));
						if (PLACE_CONSTANTS.PLACE_PROP_KEY_CUSTOMER_MAX_COUNT.equals(propObj.getPropKey())) 
							propObj.setPropContent(String.valueOf(customerUsageCount));
						if (PLACE_CONSTANTS.PLACE_PROP_KEY_EMPLOYEE_MAX_COUNT.equals(propObj.getPropKey())) 
							propObj.setPropContent(String.valueOf(employeeUsageCount));
						if (PLACE_CONSTANTS.PLACE_PROP_KEY_INVENTORY_CATEGORY_MAX_COUNT.equals(propObj.getPropKey())) 
							propObj.setPropContent(String.valueOf(inventoryCategoryUsageCount));
						if (PLACE_CONSTANTS.PLACE_PROP_KEY_INVENTORY_ITEM_MAX_COUNT.equals(propObj.getPropKey())) 
							propObj.setPropContent(String.valueOf(inventoryItemUsageCount));
						if (PLACE_CONSTANTS.PLACE_PROP_KEY_MONTHLY_BILLING_MAX_AMOUNT.equals(propObj.getPropKey())) 
							propObj.setPropContent(String.valueOf(monthlyBillingUsageAmount));
						
						savePlaceRequired = true;
					}
					
					if (savePlaceRequired)
						placeService.saveOrUpdatePlace(placeObj, currentUserObj.getId());
					
					responseBody.placeObj = placeObj;
				//}

				// If new changes found at user object
				//if (userObj.getUpdatedOn().after(lastSyncTime)) {
					if (validateUser(userObj))
						userService.saveOrUpdateUser(userObj, currentUserObj.getId());
					
					responseBody.userObj = userObj;
				//}
				
				// TASK #3.1: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
				responseBody.userId = currentUserObj.getId();
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of syncSession
	
	//--------------------------------------------------------------------------
	
	private void loadConstants(InitConsoleRequestBody requestBody, InitConsoleResponseBody responseBody)
	{
		responseBody.appConstants = new AppConstants();
		responseBody.beanConstants = new BeanConstants();
		responseBody.moduleConstants = new ModuleConstants();
		responseBody.billingConstants = new BillingConstants();
		responseBody.customerConstants = new CustomerConstants();
		responseBody.documentConstants = new DocumentConstants();
		responseBody.inventoryConstants = new InventoryConstants();
		responseBody.placeConstants = new PlaceConstants();
		responseBody.settingsConstants = new SettingsConstants();
		responseBody.userConstants = new UserConstants();
		
		// New Plain Object
		responseBody.newBilling = new BillingBean();
		responseBody.newBillingDelivery = new BillingDeliveryBean();
		responseBody.newBillingLine = new BillingLineBean();
		responseBody.newBillingPayment = new BillingPaymentBean();
		responseBody.newBillingPaymentProperties = new BillingPaymentPropertiesBean();
		responseBody.newBillingProperties = new BillingPropertiesBean();
		responseBody.newBillingWorkflow = new BillingWorkflowBean();
		responseBody.newBillingWorkflowEvent = new BillingWorkflowEventBean();
		responseBody.newBillingBucket = new BillingBucketBean();
		responseBody.newBillingBucketLine = new BillingBucketLineBean();
		responseBody.newCommonCalendar = new CommonCalendarBean();
		responseBody.newCommonCalendarEvent = new CommonCalendarEventBean();
		responseBody.newCommonTemplate = new CommonTemplateBean();
		responseBody.newCommonTemplateProperties = new CommonTemplatePropertiesBean();
		responseBody.newCustomer = new CustomerBean();
		responseBody.newCustomerAddress = new CustomerAddressBean();
		responseBody.newCustomerContact = new CustomerContactBean();
		responseBody.newCustomerEmail = new CustomerEmailBean();
		responseBody.newCustomerProfile = new CustomerProfileBean();
		responseBody.newCustomerProfileProperties = new CustomerProfilePropertiesBean();
		responseBody.newCustomerProperties = new CustomerPropertiesBean();
		responseBody.newEmployee = new EmployeeBean();
		responseBody.newEmployeeContact = new EmployeeContactBean();
		responseBody.newEmployeeAddress = new EmployeeAddressBean();
		responseBody.newEmployeeEmail = new EmployeeEmailBean();
		responseBody.newEmployeeJob = new EmployeeJobBean();
		responseBody.newEmployeeProperties = new EmployeePropertiesBean();
		responseBody.newDocument = new DocumentBean();
		responseBody.newDocumentProperties = new DocumentPropertiesBean();
		responseBody.newCategory = new InventoryCategoryBean();
		responseBody.newCategoryProperties = new InventoryCategoryPropertiesBean();
		responseBody.newItem = new InventoryItemBean();
		responseBody.newItemComponent = new InventoryItemComponentBean();
		responseBody.newItemImage = new InventoryItemImageBean();
		responseBody.newItemProperties = new InventoryItemPropertiesBean();
		responseBody.newTransaction = new InventoryTransactionBean();
		responseBody.newTransactionLine = new InventoryTransactionLineBean();
		responseBody.newPlace = new PlaceBean();
		responseBody.newPlaceAccess = new PlaceAccessBean();
		responseBody.newPlaceAccessProperties = new PlaceAccessPropertiesBean();
		responseBody.newPlaceAddress = new PlaceAddressBean();
		responseBody.newPlaceContact = new PlaceContactBean();
		responseBody.newPlaceDocument = new PlaceDocumentBean();
		responseBody.newPlaceDocumentProperties = new PlaceDocumentPropertiesBean();
		responseBody.newPlaceDocumentTemplate = new PlaceDocumentTemplateBean();
		responseBody.newPlaceDocumentTemplateComponent = new PlaceDocumentTemplateComponentBean();
		responseBody.newPlaceImage = new PlaceImageBean();
		responseBody.newPlaceLabel = new PlaceLabelBean();
		responseBody.newPlaceOperatingHour = new PlaceOperatingHourBean();
		responseBody.newPlaceProperties = new PlacePropertiesBean();
		responseBody.newPlaceRole = new PlaceRoleBean();
		responseBody.newPlaceSettings = new PlaceSettingsBean();
		responseBody.newPlaceWorkflow = new PlaceWorkflowBean();
		responseBody.newPlaceWorkflowEvent = new PlaceWorkflowEventBean();
		responseBody.newPlaceLayout = new PlaceLayoutBean();
		responseBody.newPlaceLayoutComponent = new PlaceLayoutComponentBean();
		responseBody.newUser = new UserBean();
		responseBody.newUserAction = new UserActionBean();
		responseBody.newUserSession = new UserSessionBean();
		responseBody.newUserProperties = new UserPropertiesBean();
		responseBody.newUserAccessRight = new UserAccessRightBean();
		responseBody.newUserRole = new UserRoleBean();
	} // .end of loadConstants
	
	private void loadData(InitConsoleRequestBody requestBody, InitConsoleResponseBody responseBody, UserBean logonUserObj)
	{
		if (requestBody.loadPlaceList) {
			PlaceBean placeObj = placeService.getPlaceById(requestBody.placeId, true);
			if (validatePlace(placeObj, logonUserObj))
				placeService.saveOrUpdatePlace(placeObj, logonUserObj.getId());
			
			responseBody.placeList = new ArrayList<PlaceBean>();
			responseBody.placeList.add(placeObj);
		}
		
		if (requestBody.loadUserList) {
			UserBean userObj = userService.getUserById(logonUserObj.getId(), true);
			if (validateUser(userObj))
				userService.saveOrUpdateUser(userObj, logonUserObj.getId());
			
			responseBody.userList = new ArrayList<UserBean>();
			responseBody.userList.add(userObj);
		}
	} // .end of loadData
	
	private boolean validatePlace(PlaceBean placeObj, UserBean userObj)
	{		
		boolean saveRequired = false;
		
		// Check existence of properties: Account Type
		PlacePropertiesBean accountTypeObj = PLACE_UTIL.getPlacePropertiesByKey(placeObj, PLACE_CONSTANTS.PLACE_PROP_KEY_ACCOUNT_TYPE);
		if (accountTypeObj == null) {

			String propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_BASIC;
			if ("burlingtontailorbsc".equals(placeObj.getId()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_PREMIUM;
			
			accountTypeObj = PLACE_FACTORY.createPlaceProperties(
								placeObj, 
								userObj, 
								PLACE_CONSTANTS.PLACE_PROP_GROUP_ACCOUNT_MEMBERSHIP,
								PLACE_CONSTANTS.PLACE_PROP_KEY_ACCOUNT_TYPE, 
								PLACE_CONSTANTS.PLACE_PROP_NAME_ACCOUNT_TYPE, 
								propVal, 
								1);
			placeObj.propertiesList.add(accountTypeObj);
		}
		
		// Check existence of properties: User Max Count
		PlacePropertiesBean userMaxCountObj = PLACE_UTIL.getPlacePropertiesByKey(placeObj, PLACE_CONSTANTS.PLACE_PROP_KEY_USER_MAX_COUNT);
		if (userMaxCountObj == null) {
			
			String propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_BASIC_USER_MAX_COUNT;
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_ENTERPRISE.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_ENTERPRISE_USER_MAX_COUNT;
			else
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_PREMIUM.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_PREMIUM_USER_MAX_COUNT; 
				
			userMaxCountObj = PLACE_FACTORY.createPlaceProperties(
								placeObj, 
								userObj, 
								PLACE_CONSTANTS.PLACE_PROP_GROUP_ACCOUNT_MEMBERSHIP,
								PLACE_CONSTANTS.PLACE_PROP_KEY_USER_MAX_COUNT, 
								PLACE_CONSTANTS.PLACE_PROP_NAME_USER_MAX_COUNT, 
								propVal, 
								2);
			placeObj.propertiesList.add(userMaxCountObj);
			saveRequired = true;
		}
		
		// Check existence of properties: Customer Max Count
		PlacePropertiesBean customerMaxCountObj = PLACE_UTIL.getPlacePropertiesByKey(placeObj, PLACE_CONSTANTS.PLACE_PROP_KEY_CUSTOMER_MAX_COUNT);
		if (customerMaxCountObj == null) {
			
			String propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_BASIC_CUSTOMER_MAX_COUNT;
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_ENTERPRISE.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_ENTERPRISE_CUSTOMER_MAX_COUNT;
			else
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_PREMIUM.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_PREMIUM_CUSTOMER_MAX_COUNT; 
						
			customerMaxCountObj = PLACE_FACTORY.createPlaceProperties(
									placeObj, 
									userObj, 
									PLACE_CONSTANTS.PLACE_PROP_GROUP_ACCOUNT_MEMBERSHIP,
									PLACE_CONSTANTS.PLACE_PROP_KEY_CUSTOMER_MAX_COUNT, 
									PLACE_CONSTANTS.PLACE_PROP_NAME_CUSTOMER_MAX_COUNT, 
									propVal, 
									3);
			placeObj.propertiesList.add(customerMaxCountObj);
			saveRequired = true;
		}
		
		// Check existence of properties: Customer Max Count
		PlacePropertiesBean employeeMaxCountObj = PLACE_UTIL.getPlacePropertiesByKey(placeObj, PLACE_CONSTANTS.PLACE_PROP_KEY_EMPLOYEE_MAX_COUNT);
		if (employeeMaxCountObj == null) {
			
			String propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_BASIC_EMPLOYEE_MAX_COUNT;
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_ENTERPRISE.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_ENTERPRISE_EMPLOYEE_MAX_COUNT;
			else
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_PREMIUM.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_PREMIUM_EMPLOYEE_MAX_COUNT; 
						
			employeeMaxCountObj = PLACE_FACTORY.createPlaceProperties(
									placeObj, 
									userObj, 
									PLACE_CONSTANTS.PLACE_PROP_GROUP_ACCOUNT_MEMBERSHIP,
									PLACE_CONSTANTS.PLACE_PROP_KEY_EMPLOYEE_MAX_COUNT, 
									PLACE_CONSTANTS.PLACE_PROP_NAME_EMPLOYEE_MAX_COUNT, 
									propVal, 
									3);
			placeObj.propertiesList.add(employeeMaxCountObj);
			saveRequired = true;
		}
		
		// Check existence of properties: Inventory Category Max Count
		PlacePropertiesBean inventoryCategoryMaxCountObj = PLACE_UTIL.getPlacePropertiesByKey(placeObj, PLACE_CONSTANTS.PLACE_PROP_KEY_INVENTORY_CATEGORY_MAX_COUNT);
		if (inventoryCategoryMaxCountObj == null) {
			
			String propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_BASIC_INVENTORY_CATEGORY_MAX_COUNT;
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_ENTERPRISE.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_ENTERPRISE_INVENTORY_CATEGORY_MAX_COUNT;
			else
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_PREMIUM.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_PREMIUM_INVENTORY_CATEGORY_MAX_COUNT; 
						
			inventoryCategoryMaxCountObj = PLACE_FACTORY.createPlaceProperties(
											placeObj, 
											userObj, 
											PLACE_CONSTANTS.PLACE_PROP_GROUP_ACCOUNT_MEMBERSHIP,
											PLACE_CONSTANTS.PLACE_PROP_KEY_INVENTORY_CATEGORY_MAX_COUNT, 
											PLACE_CONSTANTS.PLACE_PROP_NAME_INVENTORY_CATEGORY_MAX_COUNT, 
											propVal, 
											4);
			placeObj.propertiesList.add(inventoryCategoryMaxCountObj);
			saveRequired = true;
		}
		
		// Check existence of properties: Inventory Item Max Count
		PlacePropertiesBean inventoryItemMaxCountObj = PLACE_UTIL.getPlacePropertiesByKey(placeObj, PLACE_CONSTANTS.PLACE_PROP_KEY_INVENTORY_ITEM_MAX_COUNT);
		if (inventoryItemMaxCountObj == null) {
			
			String propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_BASIC_INVENTORY_ITEM_MAX_COUNT;
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_ENTERPRISE.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_ENTERPRISE_INVENTORY_ITEM_MAX_COUNT;
			else
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_PREMIUM.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_PREMIUM_INVENTORY_ITEM_MAX_COUNT;
			
			inventoryItemMaxCountObj = PLACE_FACTORY.createPlaceProperties(
											placeObj, 
											userObj, 
											PLACE_CONSTANTS.PLACE_PROP_GROUP_ACCOUNT_MEMBERSHIP,
											PLACE_CONSTANTS.PLACE_PROP_KEY_INVENTORY_ITEM_MAX_COUNT, 
											PLACE_CONSTANTS.PLACE_PROP_NAME_INVENTORY_ITEM_MAX_COUNT, 
											propVal, 
											5);
			placeObj.propertiesList.add(inventoryItemMaxCountObj);
			saveRequired = true;
		}
	
		// Check existence of properties: Monthly Billing Max Amount
		PlacePropertiesBean monthlyBillingMaxAmountObj = PLACE_UTIL.getPlacePropertiesByKey(placeObj, PLACE_CONSTANTS.PLACE_PROP_KEY_MONTHLY_BILLING_MAX_AMOUNT);
		if (monthlyBillingMaxAmountObj == null) {
			
			String propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_BASIC_MONTHLY_BILLING_MAX_AMOUNT;
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_ENTERPRISE.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_ENTERPRISE_MONTHLY_BILLING_MAX_AMOUNT;
			else
			if (PLACE_CONSTANTS.PLACE_PROP_VALUE_ACCOUNT_TYPE_PREMIUM.equals(accountTypeObj.getPropValue()))
				propVal = PLACE_CONSTANTS.PLACE_PROP_VALUE_PREMIUM_MONTHLY_BILLING_MAX_AMOUNT;
			
			monthlyBillingMaxAmountObj = PLACE_FACTORY.createPlaceProperties(
											placeObj, 
											userObj, 
											PLACE_CONSTANTS.PLACE_PROP_GROUP_ACCOUNT_MEMBERSHIP,
											PLACE_CONSTANTS.PLACE_PROP_KEY_MONTHLY_BILLING_MAX_AMOUNT, 
											PLACE_CONSTANTS.PLACE_PROP_NAME_MONTHLY_BILLING_MAX_AMOUNT, 
											propVal, 
											6);
			placeObj.propertiesList.add(monthlyBillingMaxAmountObj);
			saveRequired = true;
		}
		
		return saveRequired;
	} // .end of validatePlace
	
	private boolean validateUser(UserBean userObj) {
		boolean saveRequired = false;
		return saveRequired;
	} // .end of validateUser
}  