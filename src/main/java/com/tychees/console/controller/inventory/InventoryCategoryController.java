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
import com.tychees.console.controller.inventory.request.GetCategoriesByIdsRequestBody;
import com.tychees.console.controller.inventory.request.GetCategoriesByParentCategoryRequestBody;
import com.tychees.console.controller.inventory.request.GetCategoriesByPlaceRequestBody;
import com.tychees.console.controller.inventory.request.GetCategoryByIdRequestBody;
import com.tychees.console.controller.inventory.response.GetCategoriesByIdsResponseBody;
import com.tychees.console.controller.inventory.response.GetCategoriesByParentCategoryResponseBody;
import com.tychees.console.controller.inventory.response.GetCategoriesByPlaceResponseBody;
import com.tychees.console.controller.inventory.response.GetCategoryByIdResponseBody;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.InventorySearchCriteria;
  
@RestController  
public class InventoryCategoryController {  
   
	@Autowired 
	InventoryService inventoryService;  
	
	@Autowired
	UserService userService;
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCategoryByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCategoryByIdResponseBody getCategoryByIdTest(HttpServletRequest request, @RequestBody GetCategoryByIdRequestBody requestBody) 
	{  
		return getCategoryById(request, requestBody);
	} // .end of getCategoryByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCategoryById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCategoryByIdResponseBody getCategoryById(HttpServletRequest request, @RequestBody GetCategoryByIdRequestBody requestBody) 
	{  
		GetCategoryByIdResponseBody responseBody = new GetCategoryByIdResponseBody();
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
			responseBody.categoryObj = inventoryService.getCategoryById( requestBody.categoryId, requestBody.fullBean );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCategoryById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCategoriesByIdsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCategoriesByIdsResponseBody getCategoriesByIdsTest(HttpServletRequest request, @RequestBody GetCategoriesByIdsRequestBody requestBody) 
	{  
		return getCategoriesByIds(request, requestBody);
	} // .end of getCategoriesByIdsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCategoriesByIds", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCategoriesByIdsResponseBody getCategoriesByIds(HttpServletRequest request, @RequestBody GetCategoriesByIdsRequestBody requestBody) 
	{  
		GetCategoriesByIdsResponseBody responseBody = new GetCategoriesByIdsResponseBody();
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
			responseBody.categoryList = inventoryService.getCategoryListByIds( requestBody.categoryIdList );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCategoriesByIds
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCategoriesByPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCategoriesByPlaceResponseBody getCategoriesByPlaceTest(HttpServletRequest request, @RequestBody GetCategoriesByPlaceRequestBody requestBody) 
	{  
		return getCategoriesByPlace(request, requestBody);
	} // .end of getCategoriesByPlaceTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCategoriesByPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCategoriesByPlaceResponseBody getCategoriesByPlace(HttpServletRequest request, @RequestBody GetCategoriesByPlaceRequestBody requestBody) 
	{  
		GetCategoriesByPlaceResponseBody responseBody = new GetCategoriesByPlaceResponseBody();
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
			// TASK #1: Get category list, by given place ID
			InventorySearchCriteria categorySearchCriteria = new InventorySearchCriteria( requestBody.placeId );
			categorySearchCriteria.setFullBean( requestBody.fullBean );
			categorySearchCriteria.setFilterByPosVisible( requestBody.filterByPosVisible );
			categorySearchCriteria.setPosVisible( requestBody.posVisible );
			if (requestBody.viewBean)
				responseBody.viewList = inventoryService.getCategoryViewsByPlaceId( categorySearchCriteria );
			else
				responseBody.categoryList = inventoryService.getCategoriesByPlaceId( categorySearchCriteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCategoriesByPlace	
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getCategoriesByParentCategoryTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCategoriesByParentCategoryResponseBody getCategoriesByParentCategoryTest(HttpServletRequest request, @RequestBody GetCategoriesByParentCategoryRequestBody requestBody) 
	{  
		return getCategoriesByParentCategory(request, requestBody);
	} // .end of getCategoriesByParentCategoryTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getCategoriesByParentCategory", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetCategoriesByParentCategoryResponseBody getCategoriesByParentCategory(HttpServletRequest request, @RequestBody GetCategoriesByParentCategoryRequestBody requestBody) 
	{  
		GetCategoriesByParentCategoryResponseBody responseBody = new GetCategoriesByParentCategoryResponseBody();
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
			// TASK #1: Get category list, by given place ID
			InventorySearchCriteria categorySearchCriteria = new InventorySearchCriteria( requestBody.placeId );
			categorySearchCriteria.setFullBean( requestBody.fullBean );
			categorySearchCriteria.setFilterByPosVisible( false );
			categorySearchCriteria.setPosVisible( true );
			responseBody.categoryList = inventoryService.getCategoriesByParentCategory( categorySearchCriteria );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getCategoriesByPlace
}  