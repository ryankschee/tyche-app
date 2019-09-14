package com.tychees.console.controller.opportunity;

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
import com.tychees.console.controller.opportunity.request.GetOpportunityByIdRequestBody;
import com.tychees.console.controller.opportunity.request.GetOpportunitiesByCustomerRequestBody;
import com.tychees.console.controller.opportunity.request.GetOpportunitiesByEmployeeRequestBody;
import com.tychees.console.controller.opportunity.response.GetOpportunityByIdResponseBody;
import com.tychees.console.controller.opportunity.response.GetOpportunitiesByCustomerResponseBody;
import com.tychees.console.controller.opportunity.response.GetOpportunitiesByEmployeeResponseBody;
import com.tychees.core.service.OpportunityService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.OpportunitySearchCriteria;
  
@RestController  
public class OpportunityController {  
   
	@Autowired 
	OpportunityService opportunityService;  
	@Autowired 
	UserService userService;  
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value="/getOpportunityByIdTest", method=RequestMethod.POST, headers="Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetOpportunityByIdResponseBody getOpportunityByIdTest(HttpServletRequest request, @RequestBody GetOpportunityByIdRequestBody requestBody) 
	{  
		return getOpportunityById(request, requestBody);
	} // .end of getOpportunityByIdTest
	
	@CrossOrigin(origins=AppConstants.CONSOLE_SITE_URL, methods={RequestMethod.POST}, allowedHeaders={"*"}, exposedHeaders={"Access-Control-Allow-Origin"})
	@RequestMapping(value="/getOpportunityById", method=RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetOpportunityByIdResponseBody getOpportunityById(HttpServletRequest request, @RequestBody GetOpportunityByIdRequestBody requestBody) 
	{  
		GetOpportunityByIdResponseBody responseBody = new GetOpportunityByIdResponseBody();
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
			responseBody.opportunityObj	= 
				opportunityService.getOpportunityById(requestBody.opportunityId, requestBody.fullBean);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getOpportunityById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getOpportunitiesByCustomerTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetOpportunitiesByCustomerResponseBody getOpportunitiesByCustomerTest(HttpServletRequest request, @RequestBody GetOpportunitiesByCustomerRequestBody requestBody) 
	{  
		return getOpportunitiesByCustomer(request, requestBody);
	} // .end of getOpportunitiesByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(
		value = "/console/getOpportunitiesByCustomer", 
		method = RequestMethod.POST, 
		headers = "Accept=application/json", 
		produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetOpportunitiesByCustomerResponseBody getOpportunitiesByCustomer(HttpServletRequest request, @RequestBody GetOpportunitiesByCustomerRequestBody requestBody) 
	{  
		GetOpportunitiesByCustomerResponseBody responseBody = new GetOpportunitiesByCustomerResponseBody();
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
			OpportunitySearchCriteria criteria1 = new OpportunitySearchCriteria( requestBody.placeId );
			criteria1.setCustomerId( requestBody.customerId );
			criteria1.setFullBean( requestBody.fullBean );
			criteria1.setFilterByLastSyncedTime( false );
			criteria1.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			
			responseBody.opportunityList = opportunityService.getOpportunitiesByCustomerId( criteria1 );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getOpportunitiesByCustomer
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getOpportunitiesByEmployeeTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetOpportunitiesByEmployeeResponseBody getOpportunitiesByCustomerTest(HttpServletRequest request, @RequestBody GetOpportunitiesByEmployeeRequestBody requestBody) 
	{  
		return getOpportunitiesByEmployee(request, requestBody);
	} // .end of getOpportunitiesByEmployeeTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(
		value = "/console/getOpportunitiesByEmployee", 
		method = RequestMethod.POST, 
		headers = "Accept=application/json", 
		produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetOpportunitiesByEmployeeResponseBody getOpportunitiesByEmployee(HttpServletRequest request, @RequestBody GetOpportunitiesByEmployeeRequestBody requestBody) 
	{  
		GetOpportunitiesByEmployeeResponseBody responseBody = new GetOpportunitiesByEmployeeResponseBody();
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
			responseBody.opportunityList = opportunityService.getOpportunitiesByEmployeeId( requestBody.placeId, requestBody.employeeId );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getOpportunitiesByEmployee
	
	//--------------------------------------------------------------------------
}  