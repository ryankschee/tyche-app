package com.tychees.console.controller.user;

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
import com.tychees.console.controller.user.request.GetUserByIdRequestBody;
import com.tychees.console.controller.user.request.GetUsersByIdsRequestBody;
import com.tychees.console.controller.user.request.GetUsersByPlaceRequestBody;
import com.tychees.console.controller.user.response.GetUserByIdResponseBody;
import com.tychees.console.controller.user.response.GetUsersByIdsResponseBody;
import com.tychees.console.controller.user.response.GetUsersByPlaceResponseBody;
import com.tychees.core.service.UserService;
  
@RestController  
public class UserController {  
   
	@Autowired 
	UserService userService;  
   
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getUserByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetUserByIdResponseBody getUserByIdTest(HttpServletRequest request, @RequestBody GetUserByIdRequestBody requestBody) 
	{  
		return getUserById(request, requestBody);
	} // .end of getUserByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getUserById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetUserByIdResponseBody getUserById(HttpServletRequest request, @RequestBody GetUserByIdRequestBody requestBody) 
	{  
		GetUserByIdResponseBody responseBody = new GetUserByIdResponseBody();
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
			// TASK #1: Get user object, by given ID
			responseBody.userObj = userService.getUserById( requestBody.userId, requestBody.fullBean );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getUserById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getUsersByIdsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetUsersByIdsResponseBody getUsersByIdsTest(HttpServletRequest request, @RequestBody GetUsersByIdsRequestBody requestBody) 
	{  
		return getUsersByIds(request, requestBody);
	} // .end of getUsersByIdsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getUsersByIds", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetUsersByIdsResponseBody getUsersByIds(HttpServletRequest request, @RequestBody GetUsersByIdsRequestBody requestBody) 
	{  
		GetUsersByIdsResponseBody responseBody = new GetUsersByIdsResponseBody();
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
			// TASK #1: Get user object, by given ID
			responseBody.userList = userService.getUserListByIds( requestBody.userIdList );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getUsersByIds
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getUsersByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetUsersByPlaceResponseBody getUsersByPlaceTest(HttpServletRequest request, @RequestBody GetUsersByPlaceRequestBody requestBody) 
	{  
		return getUsersByPlace(request, requestBody);
	} // .end of getUsersByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getUsersByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetUsersByPlaceResponseBody getUsersByPlace(HttpServletRequest request, @RequestBody GetUsersByPlaceRequestBody requestBody) 
	{  
		GetUsersByPlaceResponseBody responseBody = new GetUsersByPlaceResponseBody();
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
			// TASK #1: Get place object, by given ID
			responseBody.userList = userService.getUsersByPlaceId( requestBody.placeId, false );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getUsersByPlace
}  