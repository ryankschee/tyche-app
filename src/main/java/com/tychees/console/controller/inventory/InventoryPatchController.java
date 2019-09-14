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
import com.tychees.console.controller.inventory.request.PatchItemRequestBody;
import com.tychees.console.controller.inventory.response.PatchItemResponseBody;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.UserService;
  
@RestController  
public class InventoryPatchController {  
   
	@Autowired 
	InventoryService inventoryService;  
	
	@Autowired
	UserService userService;
		
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/patchItemTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchItemResponseBody patchItemTest(HttpServletRequest request, @RequestBody PatchItemRequestBody requestBody) 
	{  
		return patchItem(request, requestBody);
	} // .end of getItemByIdyTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/patchItem", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchItemResponseBody patchItem(HttpServletRequest request, @RequestBody PatchItemRequestBody requestBody) 
	{  
		PatchItemResponseBody responseBody = new PatchItemResponseBody();
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
			// TASK #1: Get item list, by given category ID
			//responseBody.itemList = inventoryService.getItemsByCategoryId( requestBody.categoryId, true, requestBody.lastSyncedTime.longValue() );
			inventoryService.patchItem(requestBody.from, requestBody.to);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getItemById	
}  