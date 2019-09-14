package com.tychees.console.controller.employee;

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
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.controller.RequestStatus;
import com.tychees.console.controller.customer.request.GetCustomersByKeywordsRequestBody;
import com.tychees.console.controller.customer.response.GetCustomersByKeywordsResponseBody;
import com.tychees.console.controller.employee.request.GetEmployeeByEmployeeNoRequestBody;
import com.tychees.console.controller.employee.request.GetEmployeeByIdRequestBody;
import com.tychees.console.controller.employee.request.GetEmployeesByKeywordsRequestBody;
import com.tychees.console.controller.employee.request.GetEmployeesByPlaceRequestBody;
import com.tychees.console.controller.employee.response.GetEmployeeByEmployeeNoResponseBody;
import com.tychees.console.controller.employee.response.GetEmployeeByIdResponseBody;
import com.tychees.console.controller.employee.response.GetEmployeesByKeywordsResponseBody;
import com.tychees.console.controller.employee.response.GetEmployeesByPlaceResponseBody;
import com.tychees.core.service.EmployeeService;
import com.tychees.core.service.PlaceService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.EmployeeSearchCriteria;
import com.tychees.core.util.BeanUtil;
import com.tychees.core.util.EmployeeUtil;
  
@RestController  
public class EmployeeController {  
   
	@Autowired
	BeanUtil BEAN_UTIL;
	@Autowired
	EmployeeUtil EMPLOYEE_UTIL;
	@Autowired 
	EmployeeService employeeService;  
	@Autowired 
	PlaceService placeService;  
	@Autowired
	UserService userService;
   
	private final static Logger LOGGER = Logger.getLogger(EmployeeController.class.getName());
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getEmployeeByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetEmployeeByIdResponseBody getEmployeeByIdTest(HttpServletRequest request, @RequestBody GetEmployeeByIdRequestBody requestBody) 
	{  
		return getEmployeeById(request, requestBody);
	} // .end of getEmployeeByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getEmployeeById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetEmployeeByIdResponseBody getEmployeeById(HttpServletRequest request, @RequestBody GetEmployeeByIdRequestBody requestBody) 
	{  
		GetEmployeeByIdResponseBody responseBody = new GetEmployeeByIdResponseBody();
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
			responseBody.employeeObj = employeeService.getEmployeeById( requestBody.employeeId );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getEmployeeById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getEmployeeByEmployeeNoTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetEmployeeByEmployeeNoResponseBody getEmployeeByEmployeeNoTest(HttpServletRequest request, @RequestBody GetEmployeeByEmployeeNoRequestBody requestBody) 
	{  
		return getEmployeeByEmployeeNo(request, requestBody);
	} // .end of getEmployeeByEmployeeNoTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getEmployeeByEmployeeNo", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetEmployeeByEmployeeNoResponseBody getEmployeeByEmployeeNo(HttpServletRequest request, @RequestBody GetEmployeeByEmployeeNoRequestBody requestBody) 
	{  
		GetEmployeeByEmployeeNoResponseBody responseBody = new GetEmployeeByEmployeeNoResponseBody();
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
			responseBody.employeeObj = employeeService.getEmployeeByEmployeeNo(requestBody.employeeNo);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getEmployeeByEmployeeNo
	
	
	//--------------------------------------------------------------------------
		
	@RequestMapping(value = "/console/getEmployeesByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetEmployeesByPlaceResponseBody getEmployeesByPlaceTest(HttpServletRequest request, @RequestBody GetEmployeesByPlaceRequestBody requestBody) 
	{  
		return getEmployeesByPlace(request, requestBody);
	} // .end of getEmployeesByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getEmployeesByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetEmployeesByPlaceResponseBody getEmployeesByPlace(HttpServletRequest request, @RequestBody GetEmployeesByPlaceRequestBody requestBody) 
	{  
		GetEmployeesByPlaceResponseBody responseBody = new GetEmployeesByPlaceResponseBody();
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
			EmployeeSearchCriteria criteria = new EmployeeSearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			
			responseBody.employeeList = employeeService.getEmployeeViewsByPlaceId( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getEmployeesByPlace
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getEmployeesByKeywordsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetEmployeesByKeywordsResponseBody getEmployeesByKeywordsTest(HttpServletRequest request, @RequestBody GetEmployeesByKeywordsRequestBody requestBody) 
	{  
		return getEmployeesByKeywords(request, requestBody);
	} // .end of getEmployeesByKeywordsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getEmployeesByKeywords", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetEmployeesByKeywordsResponseBody getEmployeesByKeywords(HttpServletRequest request, @RequestBody GetEmployeesByKeywordsRequestBody requestBody) 
	{  
		GetEmployeesByKeywordsResponseBody responseBody = new GetEmployeesByKeywordsResponseBody();
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
			responseBody.employeeList = employeeService.getEmployeeViewsByKeywords( requestBody.placeId, requestBody.keywords );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getEmployeesByKeywords
	
	
	//--------------------------------------------------------------------------	
}  