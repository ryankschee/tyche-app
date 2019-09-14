package com.tychees.console.controller.document;

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
import com.tychees.console.controller.document.request.GetDocumentByIdRequestBody;
import com.tychees.console.controller.document.request.GetDocumentsByIdsRequestBody;
import com.tychees.console.controller.document.request.GetDocumentsByPlaceRequestBody;
import com.tychees.console.controller.document.response.GetDocumentByIdResponseBody;
import com.tychees.console.controller.document.response.GetDocumentsByIdsResponseBody;
import com.tychees.console.controller.document.response.GetDocumentsByPlaceResponseBody;
import com.tychees.core.service.DocumentService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.DocumentSearchCriteria;
  
@RestController  
public class DocumentController {  
   
	@Autowired 
	DocumentService documentService;  
	@Autowired
	UserService userService;
   
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getDocumentsByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetDocumentsByPlaceResponseBody getDocumentsByPlaceTest(HttpServletRequest request, @RequestBody GetDocumentsByPlaceRequestBody requestBody) 
	{  
		return getDocumentsByPlace(request, requestBody);
	} // .end of getDocumentsByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getDocumentsByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetDocumentsByPlaceResponseBody getDocumentsByPlace(HttpServletRequest request, @RequestBody GetDocumentsByPlaceRequestBody requestBody) 
	{  
		GetDocumentsByPlaceResponseBody responseBody = new GetDocumentsByPlaceResponseBody();
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
			// TASK #1: Get document list, by given place ID
			responseBody.documentList = documentService.getDocumentsByPlaceId( requestBody.placeId );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getDocumentsByPlace
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getDocumentByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetDocumentByIdResponseBody getDocumentByIdTest(HttpServletRequest request, @RequestBody GetDocumentByIdRequestBody requestBody) 
	{  
		return getDocumentById(request, requestBody);
	} // .end of getDocumentByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getDocumentById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetDocumentByIdResponseBody getDocumentById(HttpServletRequest request, @RequestBody GetDocumentByIdRequestBody requestBody) 
	{  
		GetDocumentByIdResponseBody responseBody = new GetDocumentByIdResponseBody();
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
			// TASK #1: Get document object, by given ID
			DocumentSearchCriteria criteria = new DocumentSearchCriteria( requestBody.placeId );
			criteria.setFullBean( requestBody.fullBean );
			criteria.setDocumentId( requestBody.documentId );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			
			responseBody.documentObj = documentService.getDocumentById( criteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getDocumentById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getDocumentsByIdsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetDocumentsByIdsResponseBody getDocumentsByIdsTest(HttpServletRequest request, @RequestBody GetDocumentsByIdsRequestBody requestBody) 
	{  
		return getDocumentsByIds(request, requestBody);
	} // .end of getDocumentsByIdsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getDocumentsByIds", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetDocumentsByIdsResponseBody getDocumentsByIds(HttpServletRequest request, @RequestBody GetDocumentsByIdsRequestBody requestBody) 
	{  
		GetDocumentsByIdsResponseBody responseBody = new GetDocumentsByIdsResponseBody();
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
			// TASK #1: Get document object, by given ID
			responseBody.documentList = documentService.getDocumentListByIds( requestBody.documentIdList );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getDocumentById
}  