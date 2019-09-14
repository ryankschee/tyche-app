package com.tychees.pws.controller.search;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.tychees.core.bean.user.UserBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.controller.RequestStatus;
import com.tychees.core.controller.AbstractController;
import com.tychees.core.service.BillingService;
import com.tychees.core.service.CustomerService;
import com.tychees.core.service.DocumentService;
import com.tychees.core.service.IndexService;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.PlaceService;
import com.tychees.core.service.UserService;
import com.tychees.pws.controller.search.request.CommonSearchRequestBody;
import com.tychees.pws.controller.search.response.CommonSearchResponseBody;
  
@RestController  
public class SearchController 
	extends AbstractController {  
   
	@Autowired 
	BillingService billingService;  
	@Autowired 
	DocumentService documentService;  
	@Autowired 
	CustomerService customerService;   
	@Autowired 
	InventoryService inventoryService;  
	@Autowired 
	PlaceService placeService;  
	@Autowired 
	UserService userService; 
	@Autowired 
	IndexService indexService;
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/pws/commonSearchTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public CommonSearchResponseBody commonSearchTest(HttpServletRequest request, @RequestBody CommonSearchRequestBody requestBody) 
	{  
		return commonSearch(request, requestBody);
	} // .end of commonSearchTest
	
	@CrossOrigin(origins = AppConstants.PWS_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/pws/commonSearch", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public CommonSearchResponseBody commonSearch(HttpServletRequest request, @RequestBody CommonSearchRequestBody requestBody) 
	{  
		CommonSearchResponseBody responseBody = new CommonSearchResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		
		List<String> keywordList = new ArrayList<String>();
		StringTokenizer tokenizer = new StringTokenizer(requestBody.keywordList, ", \"");
		while (tokenizer.hasMoreTokens())
			keywordList.add( tokenizer.nextToken() );
		
		// TASK #2.1: Get list of records and assign bean id into list
		//responseBody.resultList = indexService.search(requestBody.placeId, keywordList);
		// TASK #2.2: Set response primitive data.
		responseBody.status = RequestStatus.REQUEST_SUCCESS;
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of commonSearch
	
	//--------------------------------------------------------------------------
}  