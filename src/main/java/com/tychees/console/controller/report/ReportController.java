package com.tychees.console.controller.report;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.jboss.logging.Logger;
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
import com.tychees.core.controller.AbstractController;
import com.tychees.core.controller.RequestStatus;
import com.tychees.core.service.ReportService;
import com.tychees.core.service.UserService;
import com.tychees.console.controller.report.request.GetReportByCustomerOverviewRequestBody;
import com.tychees.console.controller.report.request.GetReportByInventoryTopSellingItemsRequestBody;
import com.tychees.console.controller.report.request.GetReportByInventoryZeroSoldItemsRequestBody;
import com.tychees.console.controller.report.response.GetReportByCustomerOverviewResponseBody;
import com.tychees.console.controller.report.response.GetReportByInventoryTopSellingItemsResponseBody;
import com.tychees.console.controller.report.response.GetReportByInventoryZeroSoldItemsResponseBody;

@RestController  
@RequestMapping("/api/reports")
public class ReportController 
	extends AbstractController {  

	@Autowired 
	ReportService reportService;
	@Autowired 
	UserService userService;
	
	private final static Logger LOGGER = Logger.getLogger(ReportController.class.getClass());
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/v1/getByCustomerOverviewTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetReportByCustomerOverviewResponseBody getReportByCustomerOverviewTest(HttpServletRequest request, @RequestBody GetReportByCustomerOverviewRequestBody requestBody) 
	{  
		return getReportByCustomerOverview(request, requestBody);
	} // .end of getReportByCustomerOverviewTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/v1/getByCustomerOverview", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetReportByCustomerOverviewResponseBody getReportByCustomerOverview(HttpServletRequest request, @RequestBody GetReportByCustomerOverviewRequestBody requestBody) 
	{  
		GetReportByCustomerOverviewResponseBody responseBody = new GetReportByCustomerOverviewResponseBody();
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
				List<String> typeList = new ArrayList<String>();
				StringTokenizer tokenizer1 = new StringTokenizer(requestBody.typeList, ",\"");
				while (tokenizer1.hasMoreTokens())
					typeList.add( tokenizer1.nextToken() );

				List<String> stateList = new ArrayList<String>();
				StringTokenizer tokenizer2 = new StringTokenizer(requestBody.stateList, ",\"");
				while (tokenizer2.hasMoreTokens())
					stateList.add( tokenizer2.nextToken() );

				List<String> areaList = new ArrayList<String>();
				StringTokenizer tokenizer3 = new StringTokenizer(requestBody.areaList, ",\"");
				while (tokenizer3.hasMoreTokens())
					areaList.add( tokenizer3.nextToken() );

				List<String> cityList = new ArrayList<String>();
				StringTokenizer tokenizer4 = new StringTokenizer(requestBody.cityList, ",\"");
				while (tokenizer4.hasMoreTokens())
					cityList.add( tokenizer4.nextToken() );
				
				responseBody.resultList = 
					reportService.getByCustomerOverview(
						requestBody.placeId, requestBody.beginTime, requestBody.endTime, typeList, stateList, areaList, cityList);
				
				// TASK #2.2: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getReportByCustomerOverview
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/v1/getByInventoryTopSellingItemsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetReportByInventoryTopSellingItemsResponseBody getByInventoryTopSellingItemsTest(HttpServletRequest request, @RequestBody GetReportByInventoryTopSellingItemsRequestBody requestBody) 
	{  
		return getByInventoryTopSellingItems(request, requestBody);
	} // .end of getByInventoryTopSellingItemsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/v1/getByInventoryTopSellingItems", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetReportByInventoryTopSellingItemsResponseBody getByInventoryTopSellingItems(HttpServletRequest request, @RequestBody GetReportByInventoryTopSellingItemsRequestBody requestBody) 
	{  
		GetReportByInventoryTopSellingItemsResponseBody responseBody = new GetReportByInventoryTopSellingItemsResponseBody();
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
				List<String> itemTypeList = new ArrayList<>();
				StringTokenizer tokenizer = new StringTokenizer(requestBody.itemTypeList, ",");
				while (tokenizer.hasMoreTokens()) {
					itemTypeList.add(tokenizer.nextToken());
				}
				
				responseBody.resultList = 
					reportService.getByInventoryTopSellingItems(
						requestBody.placeId, requestBody.beginTime, requestBody.endTime, requestBody.itemCount, itemTypeList);
				
				// TASK #2.2: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getByInventoryTopSellingItems
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/v1/getByInventoryZeroSoldItemsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetReportByInventoryTopSellingItemsResponseBody getByInventoryZeroSoldItemsTest(HttpServletRequest request, @RequestBody GetReportByInventoryTopSellingItemsRequestBody requestBody) 
	{  
		return getByInventoryTopSellingItems(request, requestBody);
	} // .end of getByInventoryTopSellingItemsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/v1/getByInventoryZeroSoldItems", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetReportByInventoryZeroSoldItemsResponseBody getByInventoryZeroSoldItems(HttpServletRequest request, @RequestBody GetReportByInventoryZeroSoldItemsRequestBody requestBody) 
	{  
		GetReportByInventoryZeroSoldItemsResponseBody responseBody = new GetReportByInventoryZeroSoldItemsResponseBody();
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
				List<String> itemTypeList = new ArrayList<>();
				StringTokenizer tokenizer = new StringTokenizer(requestBody.itemTypeList, ",");
				while (tokenizer.hasMoreTokens()) {
					itemTypeList.add(tokenizer.nextToken());
				}
				
				responseBody.resultList = 
					reportService.getByInventoryZeroSoldItems(
						requestBody.placeId, requestBody.beginTime, requestBody.endTime, requestBody.itemCount, itemTypeList);
				
				// TASK #2.2: Set response primitive data.
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
			}
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getByInventoryZeroSoldItems
	
	//--------------------------------------------------------------------------
}  