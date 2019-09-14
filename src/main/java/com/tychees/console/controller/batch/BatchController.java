package com.tychees.console.controller.batch;

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
import com.tychees.core.service.BatchService;
import com.tychees.core.service.UserService;
import com.tychees.console.controller.batch.request.GetBatchRequestByIdRequestBody;
import com.tychees.console.controller.batch.response.GetBatchRequestByIdResponseBody;

@RestController  
public class BatchController {  
   
	@Autowired 
	BatchService batchService;  
	@Autowired 
	UserService userService;  
   
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getBatchRequestByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBatchRequestByIdResponseBody getBatchRequestByIdTest(HttpServletRequest request, @RequestBody GetBatchRequestByIdRequestBody requestBody) 
	{  
		return getBatchRequestById(request, requestBody);
	} // .end of getBatchRequestByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getBatchRequestById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetBatchRequestByIdResponseBody getBatchRequestById(HttpServletRequest request, @RequestBody GetBatchRequestByIdRequestBody requestBody) 
	{  
		GetBatchRequestByIdResponseBody responseBody = new GetBatchRequestByIdResponseBody();
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
			responseBody.requestObj	= batchService.getRequestById(requestBody.requestId, requestBody.fullBean);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBatchRequestById
	
	//--------------------------------------------------------------------------	
}  