package com.tychees.core.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.common.CommonCalendarBean;
import com.tychees.core.bean.common.CommonCalendarEventBean;
import com.tychees.core.bean.place.PlaceRoleBean;
import com.tychees.core.bean.user.UserActionBean;
import com.tychees.core.bean.user.UserBean;
import com.tychees.core.bean.user.UserPropertiesBean;
import com.tychees.core.bean.user.UserRoleBean;
import com.tychees.core.bean.user.UserSecurityBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.bean.user.UserAccessRightBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.common.CommonCalendarDAO;
import com.tychees.core.dao.common.CommonCalendarEventDAO;
import com.tychees.core.dao.place.PlaceRoleDAO;
import com.tychees.core.dao.user.UserActionDAO;
import com.tychees.core.dao.user.UserDAO;
import com.tychees.core.dao.user.UserPropertiesDAO;
import com.tychees.core.dao.user.UserRoleDAO;
import com.tychees.core.dao.user.UserSecurityDAO;
import com.tychees.core.dao.user.UserSessionDAO;
import com.tychees.core.dao.user.UserAccessRightDAO;
  
@Service("userService")  
public class UserService 
{ 
	private static final Logger LOGGER = Logger.getLogger(UserService.class.getName());	
	
	@Autowired  
	UserDAO userDao;  
	@Autowired  
	UserSecurityDAO userSecurityDao;  
	@Autowired  
	UserActionDAO userActionDao;
	@Autowired  
	UserPropertiesDAO userPropertiesDao;
	@Autowired  
	UserSessionDAO userSessionDao;
	@Autowired  
	UserAccessRightDAO userAccessRightDao;
	@Autowired  
	UserRoleDAO userRoleDao;
	@Autowired  
	PlaceRoleDAO placeRoleDao;
	@Autowired 
	CommonCalendarDAO commonCalendarDao; 
	@Autowired 
	CommonCalendarEventDAO commonCalendarEventDao; 

	//--------------------------------------------------------------------------
	
	@Transactional
	public UserBean authenticate(String email, String password)
	{
		try 
		{
			UserBean userObj = userDao.getBeanByEmail(email);
			if (userObj==null)
				return null;
			
			UserSecurityBean userSecurityObj = userSecurityDao.getBeanById( userObj.getId() );
			if (userSecurityObj.getPassword().equals(password))
				return fillBean( userObj );
			else
				return null;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of authenticate	
	
	@Transactional
	public String getCSalt(String userId)
	{
		try 
		{			
			UserSecurityBean userSecurityObj = userSecurityDao.getBeanById(userId);
			if (userSecurityObj == null)
				return null;
			else
				return userSecurityObj.getCSalt();
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getCSalt
	
	@Transactional
	public String getSSalt(String userId)
	{
		try 
		{			
			UserSecurityBean userSecurityObj = userSecurityDao.getBeanById(userId);
			if (userSecurityObj == null)
				return null;
			else
				return userSecurityObj.getSSalt();
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getSSalt
	
	@Transactional  
	public UserSessionBean getSessionById(String id) 
	{  
		try 
		{
			UserSessionBean sessionObj = userSessionDao.getBeanById(id);  
			return sessionObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getSessionById  
	
	@Transactional  
	public UserBean getUserById(String id, boolean fullBean) 
	{  
		try 
		{
			UserBean userObj = userDao.getBeanById(id);
			if (fullBean)
				return fillBean(userObj);
			else
				return userObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getUserById  

	@Transactional  
	public UserSecurityBean getUserSecurityById(String id) 
	{  
		try 
		{
			UserSecurityBean securityObj = userSecurityDao.getBeanById(id);
			return securityObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getUserById  
	
	@Transactional  
	public List<UserBean> getUserListByIds(String ids) 
	{  
		try 
		{
			List<UserBean> userList = new ArrayList<UserBean>();
			StringTokenizer tokenizer = new StringTokenizer(ids, ", ");
			while (tokenizer.hasMoreTokens()) {
				userList.add(
					fillBean(
						this.userDao.getBeanById(tokenizer.nextToken())) );
			}	  
			return userList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<UserBean>();
		}
	} // .end of getUserListByIds
	
	@Transactional  
	public UserBean getUserBySessionId(String sessionId, boolean fullBean) 
	{  
		try 
		{
			UserSessionBean sessionObj = userSessionDao.getBeanById( sessionId );  
			if (sessionObj == null)
				return null;
			
			UserBean userObj = userDao.getBeanById( sessionObj.getUserId() );
			if (fullBean)
				return fillBean(userObj);
			else
				return userObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getUserBySessionId 
	
	@Transactional  
	public UserBean getUserByEmail(String email, boolean fullBean) 
	{  
		try 
		{
			UserBean userObj = userDao.getBeanByEmail( email );
			if (fullBean)
				return fillBean(userObj);
			else
				return userObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getUserByEmail 
	
	@Transactional  
	public List<UserBean> getUsersByPlaceId(String placeId, boolean fullBean) 
	{  
		try 
		{
			List<PlaceRoleBean> roleList = placeRoleDao.getBeansByPlaceId( placeId );
			List<UserBean> userList = new ArrayList<UserBean>();
			
			for (PlaceRoleBean roleObj : roleList) 
			{
				UserBean userObj = userDao.getBeanById( roleObj.getUserId() );
				if (fullBean == true)
					userList.add( fillBean( userObj, placeId ) );	
				else
					userList.add( userObj );
			}
			
			return userList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<UserBean>();
		}
	} // .end of getUsersByPlaceId

	@Transactional  
	public List<String> getUserIdsByPlaceId(String placeId, boolean fillBeanFlag) 
	{  
		try 
		{
			List<PlaceRoleBean> roleList = placeRoleDao.getBeansByPlaceId( placeId );
			List<String> userList = new ArrayList<String>();
			
			for (PlaceRoleBean roleObj : roleList) 
				userList.add( roleObj.getUserId() );
			
			return userList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<String>();
		}
	} // .end of getUsersByPlaceId
	
	@Transactional  
	public List<UserBean> getUsersByPlaceId(String placeId, boolean fillBeanFlag, long lastSyncedTime) 
	{  
		try 
		{
			List<PlaceRoleBean> roleList = placeRoleDao.getBeansByPlaceId( placeId );
			List<UserBean> userList = new ArrayList<UserBean>();
			
			for (PlaceRoleBean roleObj : roleList) 
			{
				UserBean userObj = userDao.getBeanById( roleObj.getUserId(), lastSyncedTime );
				if (userObj != null)
				{
					if (fillBeanFlag == true)
						userList.add( fillBean( userObj, placeId ) );	
					else
						userList.add( userObj );	
				}
			}
			
			return userList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<UserBean>();
		}
	} // .end of getUsersByPlaceId 
	
	@Transactional
	public void saveOrUpdateUserSecurity(UserSecurityBean userSecurityObj, String userId)
	{
		if (userSecurityObj != null)
		{
			try {
				userSecurityDao.saveOrUpdate(userSecurityObj, userId);  
			} catch (Exception e) {
				LOGGER.severe("exception: " + e.getMessage());
			}
		}
	} // .end of saveOrUpdateUserSecurity
	
	@Transactional  
	public void saveOrUpdateUser(UserBean userObj, String userId) 
	{  
		//UserBean dbUserObj = userDao.getBeanById( userObj.getId() );
		//userObj.setPassword( dbUserObj.getPassword() );
		
		userDao.saveOrUpdate(userObj, userId);  
		
		for (UserActionBean beanObj : userObj.actionList)
		{
			beanObj.setUserId( userObj.getId() );
			userActionDao.saveOrUpdate( beanObj, userId );
		}
		
		for (UserPropertiesBean beanObj : userObj.propertiesList)
		{
			beanObj.setUserId( userObj.getId() );
			userPropertiesDao.saveOrUpdate( beanObj, userId );
		}
		
		for (UserSessionBean beanObj : userObj.sessionList)
		{
			beanObj.setUserId( userObj.getId() );
			userSessionDao.saveOrUpdate( beanObj, userId );
		}
		
		for (UserAccessRightBean beanObj : userObj.accessRightList)
		{
			beanObj.setUserId( userObj.getId() );
			userAccessRightDao.saveOrUpdate( beanObj, userId );
		}
		
		for (UserRoleBean beanObj : userObj.roleList)
		{
			beanObj.setUserId( userObj.getId() );
			userRoleDao.saveOrUpdate( beanObj, userId );
		}
		
		for (CommonCalendarBean beanObj : userObj.calendarList)
		{
			beanObj.setUserId( userObj.getId() );
			commonCalendarDao.saveOrUpdate( beanObj, userId );

			for (CommonCalendarEventBean childBeanObj : beanObj.eventList) {
				childBeanObj.setCalendarId( beanObj.getId() );
				commonCalendarEventDao.saveOrUpdate( childBeanObj, userId );
			}
		}
	} // .end of saveOrUpdateUser 
  
	@Transactional  
	public void deleteUser(UserBean userObj) 
	{  
		userDao.delete(userObj);  
	} // .end of deleteUser
	
	//--------------------------------------------------------------------------
	
	/**
	 * Full Structure of UserBean
	 * -----------------------------
	 * UserBean
	 *  |- actionList
	 *  |- sessionList
	 *  |- propertiesList
	 *  |- accessRightList
	 *  |- calendarList
	 *  |- roleList
	 */ 
	private UserBean fillBean(UserBean userObj) 
	{  
		try
		{
			if (userObj != null)
			{
				// Set state: fullBeanLoaded
				userObj.setFullBeanLoaded( true );
				
				userObj.actionList = 
					userActionDao.getBeansByUserId(userObj.getId());
				
				userObj.sessionList = 
					userSessionDao.getBeansByUserId(userObj.getId());
				
				userObj.propertiesList = 
					userPropertiesDao.getBeansByUserId(userObj.getId());
				
				userObj.accessRightList = 
					userAccessRightDao.getBeansByUserId(userObj.getId());
				
				userObj.roleList = 
					userRoleDao.getBeansByUserId(userObj.getId());
				
				userObj.calendarList = commonCalendarDao.getBeansByUserId(userObj.getId());
				for (CommonCalendarBean calendarObj : userObj.calendarList)
				{
					calendarObj.eventList = 
						commonCalendarEventDao.getBeansByCalendarId(calendarObj.getId());
				}
			}
			
			return userObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return userObj;
		}
	} // .end of fillBean
	
	private UserBean fillBean(UserBean userObj, String placeId) 
	{  
		try
		{
			if (userObj != null)
			{
				// Set state: fullBeanLoaded
				userObj.setFullBeanLoaded( true );
				
				userObj.actionList = 
					userActionDao.getBeansByUserId(userObj.getId());
				
				userObj.sessionList = 
					userSessionDao.getBeansByUserId(userObj.getId());
				
				userObj.propertiesList = 
					userPropertiesDao.getBeansByUserId(userObj.getId());
				
				// Remove
				//userObj.accessRightList = 
				//	userAccessRightDao.getBeansByCompositeId(placeId, userObj.getId());
				// Remove
				//userObj.roleList = 
				//	userRoleDao.getBeansByUserId(userObj.getId());
				
				userObj.calendarList = commonCalendarDao.getBeansByUserId(userObj.getId());
				for (CommonCalendarBean calendarObj : userObj.calendarList)
				{
					calendarObj.eventList = 
						commonCalendarEventDao.getBeansByCalendarId(calendarObj.getId());
				}
			}
			
			return userObj;
		}
		catch (DAOException e)
		{
			LOGGER.severe(e.getMessage());
			return userObj;
		}
	} // .end of fillBean
}
