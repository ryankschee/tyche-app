package com.tychees.console.controller._patch;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;  
import org.springframework.web.bind.annotation.RestController;

import com.tychees.core.constants.AppConstants;
import com.tychees.core.controller.RequestStatus;
import com.tychees.core.service.PatchService;
import com.google.appengine.api.taskqueue.Queue;
import com.google.appengine.api.taskqueue.QueueFactory;
import com.google.appengine.api.taskqueue.TaskOptions;
import com.google.appengine.api.taskqueue.TaskOptions.Method;
import com.google.gson.Gson;
import com.tychees.console.controller._patch.request.GeneralPatchRequestBody;
import com.tychees.console.controller._patch.request.PatchAllBillingsRequestBody;
import com.tychees.console.controller._patch.request.PatchAllCustomersRequestBody;
import com.tychees.console.controller._patch.response.GeneralPatchResponseBody;
import com.tychees.console.controller._patch.response.PatchAllBillingsResponseBody;
import com.tychees.console.controller._patch.response.PatchAllCustomersResponseBody;

@RestController  
public class PatchController {  
   
	@Autowired 
	PatchService patchService;  
   
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/generalPatchTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GeneralPatchResponseBody patchTest(HttpServletRequest request, @RequestBody GeneralPatchRequestBody requestBody) 
	{  
		return patch(request, requestBody);
	} // .end of patchTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/generalPatch", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GeneralPatchResponseBody patch(HttpServletRequest request, @RequestBody GeneralPatchRequestBody requestBody) 
	{  
		GeneralPatchResponseBody responseBody = new GeneralPatchResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();

		Gson gson = new Gson();		
		Queue queue = QueueFactory.getQueue("patch-request-queue");
				
		requestBody.patchType = "calculateBillings";
		queue.add(
			TaskOptions.Builder.withUrl("/queue/patch")
				.payload(gson.toJson(requestBody).getBytes(), "application/json")
				.method(Method.POST));
		/*
		requestBody.patchType = "indexBillings";
		queue.add(
			TaskOptions.Builder.withUrl("/queue/patch")
				.payload(gson.toJson(requestBody).getBytes(), "application/json")
				.method(Method.POST));
		
		requestBody.patchType = "indexCustomers";
		queue.add(
			TaskOptions.Builder.withUrl("/queue/patch")
				.payload(gson.toJson(requestBody).getBytes(), "application/json")
				.method(Method.POST));
		
		requestBody.patchType = "indexCategories";
		queue.add(
			TaskOptions.Builder.withUrl("/queue/patch")
				.payload(gson.toJson(requestBody).getBytes(), "application/json")
				.method(Method.POST));
		
		requestBody.patchType = "indexItems";
		queue.add(
			TaskOptions.Builder.withUrl("/queue/patch")
				.payload(gson.toJson(requestBody).getBytes(), "application/json")
				.method(Method.POST));
		*/	
			
		responseBody.status = RequestStatus.REQUEST_SUCCESS;
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of patch
	
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/patchAllCustomerTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchAllCustomersResponseBody patchAllCustomersTest(HttpServletRequest request, @RequestBody PatchAllCustomersRequestBody requestBody) 
	{  
		return patchAllCustomers(request, requestBody);
	} // .end of getBatchRequestByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/patchAllCustomers", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchAllCustomersResponseBody patchAllCustomers(HttpServletRequest request, @RequestBody PatchAllCustomersRequestBody requestBody) 
	{  
		PatchAllCustomersResponseBody responseBody = new PatchAllCustomersResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		
		Gson gson = new Gson();
		String requestBodyInString = gson.toJson(requestBody);
		
		Queue queue = QueueFactory.getQueue("patch-request-queue");
		queue.add(
			TaskOptions.Builder.withUrl("/queue/patchCustomer")
				.payload(requestBodyInString.getBytes(), "application/json")
				.method(Method.POST));
		
		responseBody.status = RequestStatus.REQUEST_SUCCESS;
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getBatchRequestById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/patchAllBillingTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchAllBillingsResponseBody patchAllBillingsTest(HttpServletRequest request, @RequestBody PatchAllBillingsRequestBody requestBody) 
	{  
		return patchAllBillings(request, requestBody);
	} // .end of patchAllBillingsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/patchAllBillings", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchAllBillingsResponseBody patchAllBillings(HttpServletRequest request, @RequestBody PatchAllBillingsRequestBody requestBody) 
	{  
		PatchAllBillingsResponseBody responseBody = new PatchAllBillingsResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		
		Gson gson = new Gson();
		String requestBodyInString = gson.toJson(requestBody);
		
		Queue queue = QueueFactory.getQueue("patch-request-queue");
		queue.add(
			TaskOptions.Builder.withUrl("/queue/patchBilling")
				.payload(requestBodyInString.getBytes(), "application/json")
				.method(Method.POST));
		
		responseBody.status = RequestStatus.REQUEST_SUCCESS;
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of patchAllBillings
	
}  