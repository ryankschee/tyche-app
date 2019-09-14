package com.tychees.core.service;

import java.util.ArrayList;
import java.util.List;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.customer.view.CustomerCompactViewBean;
import com.tychees.core.bean.employee.EmployeeAddressBean;
import com.tychees.core.bean.employee.EmployeeBean;
import com.tychees.core.bean.employee.EmployeeContactBean;
import com.tychees.core.bean.employee.EmployeeEmailBean;
import com.tychees.core.bean.employee.EmployeeJobBean;
import com.tychees.core.bean.employee.EmployeePropertiesBean;
import com.tychees.core.bean.employee.view.EmployeeViewBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.employee.DepartmentDAO;
import com.tychees.core.dao.employee.DepartmentJobDAO;
import com.tychees.core.dao.employee.EmployeeAddressDAO;
import com.tychees.core.dao.employee.EmployeeContactDAO;
import com.tychees.core.dao.employee.EmployeeDAO;
import com.tychees.core.dao.employee.EmployeeEmailDAO;
import com.tychees.core.dao.employee.EmployeeJobDAO;
import com.tychees.core.dao.employee.EmployeePropertiesDAO;
import com.tychees.core.service.criteria.EmployeeSearchCriteria;
import com.tychees.core.util.EmployeeUtil;
  
@Service("employeeService")  
public class EmployeeService 
{
	@Autowired
	EmployeeUtil EMPLOYEE_UTIL;
	@Autowired  
	EmployeeDAO employeeDao;  
	@Autowired  
	EmployeeContactDAO employeeContactDao;
	@Autowired  
	EmployeeAddressDAO employeeAddressDao;
	@Autowired  
	EmployeeEmailDAO employeeEmailDao;
	@Autowired  
	EmployeeJobDAO employeeJobDao;
	@Autowired  
	EmployeePropertiesDAO employeePropertiesDao;
	@Autowired  
	DepartmentDAO departmentDao;
	@Autowired  
	DepartmentJobDAO departmentJobDao;

	private final static Logger LOGGER = Logger.getLogger(EmployeeService.class.getName());
	
	//--------------------------------------------------------------------------
	
	@Transactional  
	public EmployeeBean getEmployeeById(String id) 
	{  
		try 
		{
			EmployeeBean employeeObj = employeeDao.getBeanById(id);  
			return EMPLOYEE_UTIL.fillBean(employeeObj);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return null;
		}
	} // .end of getEmployeeById

	@Transactional  
	public EmployeeBean getEmployeeByEmployeeNo(String employeeNo) 
	{  
		try 
		{
			EmployeeBean employeeObj = employeeDao.getBeanByEmployeeNo(employeeNo);  
			return EMPLOYEE_UTIL.fillBean(employeeObj);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return null;
		}
	} // .end of getEmployeeByEmployeeNo
	
	@Transactional
	public Long getEmployeeCountByPlaceId(String placeId)
	{
		try 
		{
			return employeeDao.getBeanCountByPlaceId(placeId);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return 0L;
		}
	} // .end of getEmployeeCountByPlaceId

	@Transactional
	public List<EmployeeBean> getEmployeesByPlaceId(String placeId, boolean fullBean)
	{
		try 
		{
			List<EmployeeBean> employeeList = employeeDao.getBeansByPlaceId(placeId);
				
			if (fullBean)
			{
				for (EmployeeBean employeeObj : employeeList)
					EMPLOYEE_UTIL.fillBean( employeeObj );
			}
			
			return employeeList;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<EmployeeBean>();
		}
	} // .end of getEmployeesByPlaceId
	
	@Transactional
	public List<EmployeeBean> getEmployeesByPlaceId(EmployeeSearchCriteria criteria)
	{
		try 
		{
			List<EmployeeBean> employeeList = employeeDao.getBeansByPlaceId(criteria);
				
			if (criteria.isFullBean())
			{
				for (EmployeeBean employeeObj : employeeList)
					EMPLOYEE_UTIL.fillBean( employeeObj );
			}
			
			return employeeList;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<EmployeeBean>();
		}
	} // .end of getEmployeesByPlaceId

	@Transactional
	public List<EmployeeViewBean> getEmployeeViewsByPlaceId(EmployeeSearchCriteria criteria)
	{
		try 
		{
			List<EmployeeViewBean> viewList = new ArrayList<EmployeeViewBean>();
			List<EmployeeBean> employeeList = employeeDao.getBeansByPlaceId(criteria);
				
			for (EmployeeBean employeeObj : employeeList)
				viewList.add(new EmployeeViewBean(employeeObj));
			
			return viewList;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<EmployeeViewBean>();
		}
	} // .end of getEmployeeViewsByPlaceId

	@Transactional
	public List<EmployeeViewBean> getEmployeeViewsByKeywords(String placeId, String keywords)
	{
		try 
		{
			List<EmployeeViewBean> viewList = new ArrayList<EmployeeViewBean>();
			List<EmployeeBean> employeeList = employeeDao.getBeansByKeywords(placeId, keywords);
				
			for (EmployeeBean employeeObj : employeeList)
				viewList.add(new EmployeeViewBean(employeeObj));
			
			return viewList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<EmployeeViewBean>();
		}
	} // .end of getCustomerCompactViewsByKeywords

	@Transactional  
	public void saveOrUpdateEmployee(EmployeeBean employeeObj, String userId) 
	{  
		for (EmployeeContactBean beanObj : employeeObj.contactList)
		{
			beanObj.setEmployeeId( employeeObj.getId() );
			employeeContactDao.saveOrUpdate( beanObj, userId );
		}
		
		for (EmployeeAddressBean beanObj : employeeObj.addressList)
		{
			beanObj.setEmployeeId( employeeObj.getId() );
			employeeAddressDao.saveOrUpdate( beanObj, userId );
		}
		
		for (EmployeeEmailBean beanObj : employeeObj.emailList)
		{
			beanObj.setEmployeeId( employeeObj.getId() );
			employeeEmailDao.saveOrUpdate( beanObj, userId );
		}
				
		for (EmployeeJobBean beanObj : employeeObj.jobList)
		{
			beanObj.setEmployeeId( employeeObj.getId() );
			employeeJobDao.saveOrUpdate( beanObj, userId );
		}
		
		for (EmployeePropertiesBean beanObj : employeeObj.propertiesList)
		{
			beanObj.setEmployeeId( employeeObj.getId() );
			employeePropertiesDao.saveOrUpdate( beanObj, userId );
		}
		
		// Save Root Bean
		employeeDao.saveOrUpdate(employeeObj, userId);  
		// Index Bean
		if (employeeObj.isDeleted())
			EMPLOYEE_UTIL.removeIndexBean(employeeObj);
		else
			EMPLOYEE_UTIL.indexBean(employeeObj);
	} // .end of saveOrUpdateCustomer
	
	@Transactional  
	public void deleteEmployee(EmployeeBean employeeObj) 
	{  
		employeeDao.delete(employeeObj);  
	} // .end of deleteEmployee	
}
