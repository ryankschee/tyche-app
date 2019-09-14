package com.tychees.core.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.common.CommonCalendarBean;
import com.tychees.core.bean.common.CommonCalendarEventBean;
import com.tychees.core.bean.common.CommonTemplateBean;
import com.tychees.core.bean.common.CommonTemplatePropertiesBean;
import com.tychees.core.bean.place.PlaceAccessBean;
import com.tychees.core.bean.place.PlaceAccessPropertiesBean;
import com.tychees.core.bean.place.PlaceAddressBean;
import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.place.PlaceContactBean;
import com.tychees.core.bean.place.PlaceDocumentBean;
import com.tychees.core.bean.place.PlaceDocumentPropertiesBean;
import com.tychees.core.bean.place.PlaceDocumentTemplateBean;
import com.tychees.core.bean.place.PlaceDocumentTemplateComponentBean;
import com.tychees.core.bean.place.PlaceImageBean;
import com.tychees.core.bean.place.PlaceLabelBean;
import com.tychees.core.bean.place.PlaceLayoutBean;
import com.tychees.core.bean.place.PlaceLayoutComponentBean;
import com.tychees.core.bean.place.PlaceModuleBean;
import com.tychees.core.bean.place.PlaceNotificationBean;
import com.tychees.core.bean.place.PlaceOperatingHourBean;
import com.tychees.core.bean.place.PlacePropertiesBean;
import com.tychees.core.bean.place.PlaceRoleBean;
import com.tychees.core.bean.place.PlaceSettingsBean;
import com.tychees.core.bean.place.PlaceWorkflowBean;
import com.tychees.core.bean.place.PlaceWorkflowEventBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.common.CommonCalendarDAO;
import com.tychees.core.dao.common.CommonCalendarEventDAO;
import com.tychees.core.dao.common.CommonTemplateDAO;
import com.tychees.core.dao.common.CommonTemplatePropertiesDAO;
import com.tychees.core.dao.googlecloud.GCStorageDAO;
import com.tychees.core.dao.place.PlaceAccessDAO;
import com.tychees.core.dao.place.PlaceAccessPropertiesDAO;
import com.tychees.core.dao.place.PlaceAddressDAO;
import com.tychees.core.dao.place.PlaceContactDAO;
import com.tychees.core.dao.place.PlaceDAO;
import com.tychees.core.dao.place.PlaceDocumentDAO;
import com.tychees.core.dao.place.PlaceDocumentPropertiesDAO;
import com.tychees.core.dao.place.PlaceDocumentTemplateComponentDAO;
import com.tychees.core.dao.place.PlaceDocumentTemplateDAO;
import com.tychees.core.dao.place.PlaceImageDAO;
import com.tychees.core.dao.place.PlaceLabelDAO;
import com.tychees.core.dao.place.PlaceLayoutDAO;
import com.tychees.core.dao.place.PlaceModuleDAO;
import com.tychees.core.dao.place.PlaceLayoutComponentDAO;
import com.tychees.core.dao.place.PlaceNotificationDAO;
import com.tychees.core.dao.place.PlaceOperatingHourDAO;
import com.tychees.core.dao.place.PlacePropertiesDAO;
import com.tychees.core.dao.place.PlaceRoleDAO;
import com.tychees.core.dao.place.PlaceSettingsDAO;
import com.tychees.core.dao.place.PlaceWorkflowDAO;
import com.tychees.core.dao.place.PlaceWorkflowEventDAO;
  
@Service("placeService")  
public class PlaceService 
{ 
	private static final Logger LOGGER = Logger.getLogger(PlaceService.class.getName());	
	
	@Autowired  
	PlaceDAO placeDao;  
	@Autowired  
	PlaceAccessDAO placeAccessDao;  
	@Autowired  
	PlaceAccessPropertiesDAO placeAccessPropertiesDao; 
	@Autowired  
	PlaceAddressDAO placeAddressDao;  
	@Autowired  
	PlaceContactDAO placeContactDao;  
	@Autowired  
	PlaceDocumentDAO placeDocumentDao;  
	@Autowired  
	PlaceDocumentPropertiesDAO placeDocumentPropertiesDao;  
	@Autowired  
	PlaceDocumentTemplateDAO placeDocumentTemplateDao;  
	@Autowired  
	PlaceDocumentTemplateComponentDAO placeDocumentTemplateComponentDao;  
	@Autowired  
	PlaceImageDAO placeImageDao;  
	@Autowired  
	PlaceLabelDAO placeLabelDao;  
	@Autowired  
	PlaceModuleDAO placeModuleDao;  
	@Autowired  
	PlaceNotificationDAO placeNotificationDao;  
	@Autowired  
	PlaceOperatingHourDAO placeOperatingHourDao; 
	@Autowired  
	PlacePropertiesDAO placePropertiesDao;
	@Autowired  
	PlaceRoleDAO placeRoleDao;     
	@Autowired  
	PlaceSettingsDAO placeSettingsDao;  
	@Autowired 
	CommonTemplateDAO commonTemplateDao; 
	@Autowired 
	CommonTemplatePropertiesDAO commonTemplatePropertiesDao; 
	@Autowired 
	CommonCalendarDAO commonCalendarDao; 
	@Autowired 
	CommonCalendarEventDAO commonCalendarEventDao; 
	@Autowired  
	PlaceWorkflowDAO placeWorkflowDao;  
	@Autowired  
	PlaceWorkflowEventDAO placeWorkflowEventDao;  
	@Autowired  
	PlaceLayoutDAO placeLayoutDao;  
	@Autowired  
	PlaceLayoutComponentDAO placeLayoutComponentDao;  
	@Autowired  
	GCStorageDAO gcStorageDao;  
	
	//--------------------------------------------------------------------------

	@Transactional  
	public PlaceNotificationBean newNotification(String placeId, String userId) 
	{  
		PlaceNotificationBean notificationObj = new PlaceNotificationBean();
		notificationObj.setPlaceId( placeId );
		notificationObj.setUserId( userId );
		notificationObj.setCreatedOn( new Timestamp(Calendar.getInstance().getTimeInMillis()) );
		notificationObj.setCreatedBy( userId );
		
		return notificationObj;
	} // .end of newNotification  
		
	@Transactional  
	public PlaceBean getPlaceById(String id, boolean fullBean) 
	{  
		try 
		{
			PlaceBean placeObj = placeDao.getBeanById(id);  
			if (fullBean)
				return fillBean( placeObj );
			else
				return placeObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getPlaceById
	
	@Transactional  
	public List<PlaceBean> getPlacesByUserId(String userId, boolean fullBean) 
	{  
		try 
		{
			List<PlaceRoleBean> roleList = placeRoleDao.getBeansByUserId( userId );
			
			List<PlaceBean> placeList = new ArrayList<PlaceBean>();
			for (PlaceRoleBean roleObj : roleList)
				placeList.add( placeDao.getBeanById(roleObj.getPlaceId()) );
			
			if (fullBean)
				return fillBeans( placeList );
			else
				return placeList;
		}
		catch (DAOException e)
		{
			LOGGER.severe(e.getMessage());
			return new ArrayList<PlaceBean>();
		}
	} // .end of getPlacesByUserId
	
	@Transactional  
	public List<PlaceNotificationBean> getPlaceNotificationsByUserId(String placeId, String userId, int recordCount) 
	{  
		try 
		{
			List<PlaceNotificationBean> notificationList = placeNotificationDao.getBeansByUserId(placeId, userId, recordCount);
			
			return notificationList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<PlaceNotificationBean>();
		}
	} // .end of getPlaceNotificationsByUserId
	
	@Transactional  
	public List<PlaceBean> getPlaceListByIds(String currentPlaceId, String ids) 
	{  
		try 
		{
			List<PlaceBean> placeList = new ArrayList<PlaceBean>();
			StringTokenizer tokenizer = new StringTokenizer(ids, ", ");
			while (tokenizer.hasMoreTokens()) {
				PlaceBean placeObj = this.placeDao.getBeanById(tokenizer.nextToken());
				if (currentPlaceId.equals(placeObj.getId())) 
					placeList.add( fillBean(placeObj) );
				else
					placeList.add( placeObj );
			}	  
			return placeList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<PlaceBean>();
		}
	} // .end of getPlaceListByIds
	
	@Transactional  
	public List<String> getPlaceIdsByUserId(String userId, boolean fullBean) 
	{  
		try 
		{
			List<PlaceRoleBean> roleList = placeRoleDao.getBeansByUserId( userId );
			
			List<String> placeList = new ArrayList<String>();
			for (PlaceRoleBean roleObj : roleList)
				placeList.add( roleObj.getPlaceId() );
			
			return placeList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<String>();
		}
	} // .end of getPlacesByUserId
	
	@Transactional  
	public List<PlaceImageBean> getPlaceImagesByPlaceId(String placeId, boolean onlyTypeLogo) 
	{  
		try 
		{
			List<PlaceImageBean> imageList = placeImageDao.getBeansByPlaceId( placeId );
			if (onlyTypeLogo) {
				List<PlaceImageBean> filteredList = new ArrayList<PlaceImageBean>();
				for (PlaceImageBean imageObj : imageList) {
					if (imageObj.isTypeLogo())
						filteredList.add(imageObj);					
				}
				return filteredList;
			} else {
				return imageList;
			}
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<PlaceImageBean>();
		}
	} // .end of getPlaceImagesByPlaceId
	
	@Transactional  
	public void saveOrUpdatePlace(PlaceBean placeObj, String userId) 
	{  
		placeDao.saveOrUpdate( placeObj, userId );  
		
		for (PlaceAccessBean beanObj : placeObj.accessList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeAccessDao.saveOrUpdate( beanObj, userId );
			
			for (PlaceAccessPropertiesBean childBeanObj : beanObj.propertiesList) {
				childBeanObj.setAccessId( beanObj.getId() );
				placeAccessPropertiesDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
		for (PlaceAddressBean beanObj : placeObj.addressList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeAddressDao.saveOrUpdate( beanObj, userId );
		}

		for (PlaceContactBean beanObj : placeObj.contactList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeContactDao.saveOrUpdate( beanObj, userId );
		}
		
		for (PlaceDocumentBean beanObj : placeObj.documentList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeDocumentDao.saveOrUpdate( beanObj, userId );

			for (PlaceDocumentPropertiesBean childBeanObj : beanObj.propertiesList) {
				childBeanObj.setPlaceDocumentId( beanObj.getId() );
				placeDocumentPropertiesDao.saveOrUpdate( childBeanObj, userId );
			}
		}

		for (PlaceDocumentTemplateBean beanObj : placeObj.documentTemplateList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeDocumentTemplateDao.saveOrUpdate( beanObj, userId );

			for (PlaceDocumentTemplateComponentBean childBeanObj : beanObj.componentList) {
				childBeanObj.setPlaceDocumentTemplateId( beanObj.getId() );
				placeDocumentTemplateComponentDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
		for (PlaceImageBean beanObj : placeObj.imageList)
		{
			// If no URL found, means no file in Google Storage yet
			//if (beanObj.getUrl()==null || "".equals(beanObj.getUrl())) 
			//{
			//	byte[] data = Base64.decodeBase64(beanObj.getBase64().getBytes());
				
			//	String fullBucketName = gcStorageDao.getFullBucketName(gcStorageDao.MODULE_PLACE_IMAGE, placeObj.getId());
			//	gcStorageDao.saveFileToBucket(fullBucketName, beanObj.getName(), data);
				
			//	String url = gcStorageDao.getFullObjectPath(fullBucketName, beanObj.getName());
			//	beanObj.setUrl(url);
			//}
			
			beanObj.setPlaceId( placeObj.getId() );
			placeImageDao.saveOrUpdate( beanObj, userId );
		}
		
		for (PlaceLabelBean beanObj : placeObj.labelList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeLabelDao.saveOrUpdate( beanObj, userId );
		}
		
		for (PlaceLayoutBean beanObj : placeObj.layoutList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeLayoutDao.saveOrUpdate( beanObj, userId );
			
			for (PlaceLayoutComponentBean childBeanObj : beanObj.componentList) {
				childBeanObj.setLayoutId( beanObj.getId() );
				placeLayoutComponentDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
		for (PlaceModuleBean beanObj : placeObj.moduleList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeModuleDao.saveOrUpdate( beanObj, userId );
		}
		
		for (PlaceOperatingHourBean beanObj : placeObj.operatingHourList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeOperatingHourDao.saveOrUpdate( beanObj, userId );
		}
		
		for (PlacePropertiesBean beanObj : placeObj.propertiesList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placePropertiesDao.saveOrUpdate( beanObj, userId );
		}
		
		for (PlaceRoleBean beanObj : placeObj.roleList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeRoleDao.saveOrUpdate( beanObj, userId );
		}
		
		for (PlaceSettingsBean beanObj : placeObj.settingsList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeSettingsDao.saveOrUpdate( beanObj, userId );
		}
		
		for (CommonTemplateBean beanObj : placeObj.templateList)
		{
			beanObj.setParentId( placeObj.getId() );
			commonTemplateDao.saveOrUpdate( beanObj, userId );
			
			for (CommonTemplatePropertiesBean childBeanObj : beanObj.propertiesList) {
				childBeanObj.setTemplateId( beanObj.getId() );
				commonTemplatePropertiesDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
		for (CommonCalendarBean beanObj : placeObj.calendarList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			commonCalendarDao.saveOrUpdate( beanObj, userId );

			for (CommonCalendarEventBean childBeanObj : beanObj.eventList) {
				childBeanObj.setCalendarId( beanObj.getId() );
				commonCalendarEventDao.saveOrUpdate( childBeanObj, userId );
			}
		}

		for (PlaceWorkflowBean beanObj : placeObj.workflowList)
		{
			beanObj.setPlaceId( placeObj.getId() );
			placeWorkflowDao.saveOrUpdate( beanObj, userId );
			
			for (PlaceWorkflowEventBean childBeanObj : beanObj.eventList) 
			{
				childBeanObj.setWorkflowId( beanObj.getId() );
				placeWorkflowEventDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
	} // .end of saveOrUpdatePlace  
  
	@Transactional  
	public void deletePlace(PlaceBean placeObj) 
	{  
		placeDao.delete(placeObj);  
	} // .end of deletePlace
	
	@Transactional  
	public void saveOrUpdatePlaceNotifications(List<PlaceNotificationBean> notificationList, String userId) 
	{  
		for (PlaceNotificationBean notificationObj : notificationList) {
			placeNotificationDao.saveOrUpdate(notificationObj, userId);  	
		}
	} // .end of saveOrUpdatePlaceNotifications  
	
	@Transactional  
	public void saveOrUpdatePlaceNotification(PlaceNotificationBean notificationObj, String userId) 
	{  
		placeNotificationDao.saveOrUpdate(notificationObj, userId);  
	} // .end of saveOrUpdatePlaceNotification  

	@Transactional  
	public void updatePlaceSettings(String placeId, String propKey, String propValue, String userId) 
	{  
		try {
			List<PlaceSettingsBean> settingsList = placeSettingsDao.getBeansByPlaceId(placeId);
			for (PlaceSettingsBean settingsObj : settingsList) {
				if (propKey.trim().equals(settingsObj.getPropKey().trim())) {
					
					settingsObj.setPropValue(propValue);
					
					placeSettingsDao.saveOrUpdate(settingsObj, userId);
					
					break;
				}
			}
		} catch (DAOException e) {
			LOGGER.severe(e.getFullMessage());
		}
	} // .end of updatePlaceSettings  
	
	//--------------------------------------------------------------------------
	
	private List<PlaceBean> fillBeans(List<PlaceBean> placeList) 
	{
		for (PlaceBean placeObj : placeList)
		{
			fillBean( placeObj );
		}
		
		return placeList;
	} // .end of fillBeans
	
	/**
	 * Full Structure of PlaceBean
	 * -----------------------------
	 * PlaceBean
	 *  |- accessList
	 *      |- propertiesList
	 *  |- addressList
	 *  |- contactList
	 *  |- documentList
	 *      |- propertiesList
	 *  |- documentTemplateList
	 *      |- componentList
	 *  |- imageList
	 *  |- labelList
	 *  |- moduleList
	 *  |- operatingHourList
	 *  |- propertiesList
	 *  |- roleList
	 *  |- settingsList
	 *  |- templateList
	 *      |- propertiesList
	 *  |- calendarList
	 *  |- workflowList
	 *      |- eventList
	 *  |- layoutList
	 *      |- componentList
	 */ 
	private PlaceBean fillBean(PlaceBean placeObj) 
	{  
		try
		{
			if (placeObj != null) 
			{
				// Set state: fullBeanLoaded
				placeObj.setFullBeanLoaded( true );
				
				placeObj.accessList = placeAccessDao.getBeansByPlaceId(placeObj.getId());
				for (PlaceAccessBean accessObj : placeObj.accessList)
				{
					accessObj.propertiesList = 
						placeAccessPropertiesDao.getBeansByAccessId(accessObj.getId());
				}
				
				placeObj.addressList = placeAddressDao.getBeansByPlaceId(placeObj.getId());
				
				placeObj.contactList = placeContactDao.getBeansByPlaceId(placeObj.getId());
				
				placeObj.documentList = placeDocumentDao.getBeansByPlaceId(placeObj.getId());
				for (PlaceDocumentBean documentObj : placeObj.documentList)
				{
					documentObj.propertiesList = 
						placeDocumentPropertiesDao.getBeansByPlaceDocumentId(documentObj.getId());
				}

				placeObj.documentTemplateList = placeDocumentTemplateDao.getBeansByPlaceId(placeObj.getId());
				for (PlaceDocumentTemplateBean templateObj : placeObj.documentTemplateList)
				{
					templateObj.componentList = 
						placeDocumentTemplateComponentDao.getBeansByTemplateId(templateObj.getId());
				}
	
				//placeObj.imageList = placeImageDao.getBeansByPlaceId(placeObj.getId());
				
				placeObj.labelList = placeLabelDao.getBeansByPlaceId(placeObj.getId());
	
	            placeObj.moduleList = placeModuleDao.getBeansByPlaceId(placeObj.getId());
	
				placeObj.operatingHourList = placeOperatingHourDao.getBeansByPlaceId(placeObj.getId());
	
				placeObj.propertiesList = placePropertiesDao.getBeansByPlaceId(placeObj.getId());
	
				placeObj.roleList = placeRoleDao.getBeansByPlaceId(placeObj.getId());
	
				placeObj.settingsList = placeSettingsDao.getBeansByPlaceId(placeObj.getId());
	
				placeObj.templateList = commonTemplateDao.getBeansByParentId(placeObj.getId());
				for (CommonTemplateBean templateObj : placeObj.templateList)
				{
					templateObj.propertiesList = 
						commonTemplatePropertiesDao.getBeansByTemplateId(templateObj.getId());
				}

				placeObj.calendarList = commonCalendarDao.getBeansByPlaceId(placeObj.getId());
				for (CommonCalendarBean calendarObj : placeObj.calendarList)
				{
					calendarObj.eventList = 
						commonCalendarEventDao.getBeansByCalendarId(calendarObj.getId());
				}

				placeObj.workflowList = placeWorkflowDao.getBeansByPlaceId(placeObj.getId());
				for (PlaceWorkflowBean workflowObj : placeObj.workflowList) 
				{
					workflowObj.eventList = 
						placeWorkflowEventDao.getBeansByWorkflowId(workflowObj.getId());
				}

				placeObj.layoutList = placeLayoutDao.getBeansByPlaceId(placeObj.getId());
				for (PlaceLayoutBean layoutObj : placeObj.layoutList) 
				{
					layoutObj.componentList = 
						placeLayoutComponentDao.getBeansByLayoutId(layoutObj.getId());
				}
			}
			
			return placeObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of fillBean  
}
