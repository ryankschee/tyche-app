package com.tychees.console.controller.place;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;  
import org.springframework.web.bind.annotation.RestController;

import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.controller.RequestStatus;
import com.tychees.console.controller.place.request.GetPlaceByIdRequestBody;
import com.tychees.console.controller.place.request.GetPlaceImagesByPlaceIdRequestBody;
import com.tychees.console.controller.place.request.GetPlaceNotificationsByUserRequestBody;
import com.tychees.console.controller.place.request.GetPlacesByIdsRequestBody;
import com.tychees.console.controller.place.request.GetPlacesBySessionRequestBody;
import com.tychees.console.controller.place.request.SaveOrUpdatePlaceNotificationsRequestBody;
import com.tychees.console.controller.place.request.UpdatePlaceSettingsRequestBody;
import com.tychees.console.controller.place.response.GetPlaceByIdResponseBody;
import com.tychees.console.controller.place.response.GetPlaceImagesByPlaceIdResponseBody;
import com.tychees.console.controller.place.response.GetPlaceNotificationsByUserResponseBody;
import com.tychees.console.controller.place.response.GetPlacesByIdsResponseBody;
import com.tychees.console.controller.place.response.GetPlacesBySessionResponseBody;
import com.tychees.console.controller.place.response.SaveOrUpdatePlaceNotificationsResponseBody;
import com.tychees.console.controller.place.response.UpdatePlaceSettingsResponseBody;
import com.tychees.core.service.PlaceService;
import com.tychees.core.service.UserService;
  
@RestController  
public class PlaceController 
{  
	@Autowired 
	PlaceService placeService;  
	@Autowired 
	UserService userService;  
     
	@RequestMapping(value = "/console/getPlace/{id}", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PlaceBean getPlaceById(@PathVariable String id) 
	{  
		return placeService.getPlaceById(id, true);  
	}  
  
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getPlaceByIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlaceByIdResponseBody getPlaceByIdTest(HttpServletRequest request, @RequestBody GetPlaceByIdRequestBody requestBody) 
	{  
		return getPlaceById(request, requestBody);
	} // .end of getPlaceByIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getPlaceById", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlaceByIdResponseBody getPlaceById(HttpServletRequest request, @RequestBody GetPlaceByIdRequestBody requestBody) 
	{  
		GetPlaceByIdResponseBody responseBody = new GetPlaceByIdResponseBody();
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
			responseBody.placeObj = placeService.getPlaceById( requestBody.placeId, true );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getPlaceById
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getPlacesByIdsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlacesByIdsResponseBody getPlacesByIdsTest(HttpServletRequest request, @RequestBody GetPlacesByIdsRequestBody requestBody) 
	{  
		return getPlacesByIds(request, requestBody);
	} // .end of getPlacesByIdsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getPlacesByIds", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlacesByIdsResponseBody getPlacesByIds(HttpServletRequest request, @RequestBody GetPlacesByIdsRequestBody requestBody) 
	{  
		GetPlacesByIdsResponseBody responseBody = new GetPlacesByIdsResponseBody();
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
			responseBody.placeList = placeService.getPlaceListByIds( requestBody.placeId, requestBody.placeIdList );
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getPlacesByIds
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getPlacesBySessionTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlacesBySessionResponseBody getPlacesBySessionTest(HttpServletRequest request, @RequestBody GetPlacesBySessionRequestBody requestBody) 
	{  
		return getPlacesBySession(request, requestBody);
	} // .end of getPlacesBySessionTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getPlacesBySession", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlacesBySessionResponseBody getPlacesBySession(HttpServletRequest request, @RequestBody GetPlacesBySessionRequestBody requestBody) 
	{  
		GetPlacesBySessionResponseBody responseBody = new GetPlacesBySessionResponseBody();
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
			responseBody.placeList = placeService.getPlacesByUserId(sessionObj.getUserId(), false);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getPlacesBySession
	
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/getPlaceNotificationsByUserTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlaceNotificationsByUserResponseBody getPlaceNotificationsByUserTest(HttpServletRequest request, @RequestBody GetPlaceNotificationsByUserRequestBody requestBody) 
	{  
		return getPlaceNotificationsByUser(request, requestBody);
	} // .end of getPlaceNotificationsByUserTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getPlaceNotificationsByUser", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlaceNotificationsByUserResponseBody getPlaceNotificationsByUser(HttpServletRequest request, @RequestBody GetPlaceNotificationsByUserRequestBody requestBody) 
	{  
		GetPlaceNotificationsByUserResponseBody responseBody = new GetPlaceNotificationsByUserResponseBody();
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
			responseBody.notificationList = 
				placeService.getPlaceNotificationsByUserId(requestBody.placeId, requestBody.userId, requestBody.notificationCount);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getPlaceNotificationsByUser
	
	//--------------------------------------------------------------------------

	@RequestMapping(value = "/console/getPlaceImagesByPlaceIdTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlaceImagesByPlaceIdResponseBody getPlaceImagesByPlaceIdTest(HttpServletRequest request, @RequestBody GetPlaceImagesByPlaceIdRequestBody requestBody) 
	{  
		return getPlaceImagesByPlaceId(request, requestBody);
	} // .end of getPlaceImagesByPlaceIdTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/getPlaceImagesByPlaceId", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public GetPlaceImagesByPlaceIdResponseBody getPlaceImagesByPlaceId(HttpServletRequest request, @RequestBody GetPlaceImagesByPlaceIdRequestBody requestBody) 
	{  
		GetPlaceImagesByPlaceIdResponseBody responseBody = new GetPlaceImagesByPlaceIdResponseBody();
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
			responseBody.imageList = 
				placeService.getPlaceImagesByPlaceId(requestBody.placeId, requestBody.onlyTypeLogo);
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of getPlaceImagesByPlaceId
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/saveOrUpdatePlaceNotificationsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public SaveOrUpdatePlaceNotificationsResponseBody saveOrUpdatePlaceNotificationsTest(HttpServletRequest request, @RequestBody SaveOrUpdatePlaceNotificationsRequestBody requestBody) 
	{  
		return saveOrUpdatePlaceNotifications(request, requestBody);
	} // .end of saveOrUpdatePlaceNotificationsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/saveOrUpdatePlaceNotifications", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public SaveOrUpdatePlaceNotificationsResponseBody saveOrUpdatePlaceNotifications(HttpServletRequest request, @RequestBody SaveOrUpdatePlaceNotificationsRequestBody requestBody) 
	{  
		SaveOrUpdatePlaceNotificationsResponseBody responseBody = new SaveOrUpdatePlaceNotificationsResponseBody();
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
			placeService.saveOrUpdatePlaceNotifications(requestBody.notificationList, sessionObj.getUserId());
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of saveOrUpdatePlaceNotifications
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/console/updatePlaceSettingsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public UpdatePlaceSettingsResponseBody updatePlaceSettingsTest(HttpServletRequest request, @RequestBody UpdatePlaceSettingsRequestBody requestBody) 
	{  
		return updatePlaceSettings(request, requestBody);
	} // .end of updatePlaceSettingsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/updatePlaceSettings", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public UpdatePlaceSettingsResponseBody updatePlaceSettings(HttpServletRequest request, @RequestBody UpdatePlaceSettingsRequestBody requestBody) 
	{  
		UpdatePlaceSettingsResponseBody responseBody = new UpdatePlaceSettingsResponseBody();
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
			placeService.updatePlaceSettings(requestBody.placeId, requestBody.propKey, requestBody.propValue, sessionObj.getUserId());
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of updatePlaceSettings
}  