package com.tychees.core.util;

import java.util.List;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tychees.core.bean.employee.EmployeeBean;
import com.tychees.core.bean.employee.EmployeePropertiesBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.employee.DepartmentDAO;
import com.tychees.core.dao.employee.DepartmentJobDAO;
import com.tychees.core.dao.employee.EmployeeAddressDAO;
import com.tychees.core.dao.employee.EmployeeContactDAO;
import com.tychees.core.dao.employee.EmployeeDAO;
import com.tychees.core.dao.employee.EmployeeEmailDAO;
import com.tychees.core.dao.employee.EmployeeJobDAO;
import com.tychees.core.dao.employee.EmployeePropertiesDAO;
import com.tychees.core.service.IndexService;

@Component
public class EmployeeUtil {

    @Autowired  
	IndexUtil indexUtil;
	@Autowired
	IndexService indexService;
	@Autowired
	EmployeeUtil employeeUtil;
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
	
	private final static Logger LOGGER = Logger.getLogger(EmployeeUtil.class.getName());
	
	//----------------------------------------------------------------------------------------
	
	public List<EmployeeBean> fillBeans(List<EmployeeBean> employeeList) 
	{
		for (EmployeeBean employeeObj : employeeList)
		{
			fillBean( employeeObj );
		}
		
		return employeeList;
	} // .end of fillBeans
	
	/**
	 * Full Structure of EmployeeBean
	 * -----------------------------
	 * EmployeeBean
	 *  |- contactList
	 *  |- addressList
	 *  |- emailList
	 *  |- jobList
	 *  |- propertiesList
	 */ 
	public EmployeeBean fillBean(EmployeeBean employeeObj) 
	{  
		try
		{
			if (employeeObj != null)
			{
				// set state - fullBeanLoaded
				employeeObj.setFullBeanLoaded( true );
				
				employeeObj.contactList = 
					employeeContactDao.getBeansByEmployeeId(employeeObj.getId());		
				employeeObj.addressList = 
					employeeAddressDao.getBeansByEmployeeId(employeeObj.getId());		
				employeeObj.emailList = 
					employeeEmailDao.getBeansByEmployeeId(employeeObj.getId());		
				employeeObj.jobList = 
					employeeJobDao.getBeansByEmployeeId(employeeObj.getId());		
				employeeObj.propertiesList = 
					employeePropertiesDao.getBeansByEmployeeId(employeeObj.getId());
			}
			
			return employeeObj;
		}
		catch (DAOException e)
		{
			LOGGER.equals(e.getMessage());
			return employeeObj;
		}
	} // .end of fillBean
	
	public void indexBean(EmployeeBean employeeObj) 
	{
		if (indexService.validateBean(employeeObj.getPlaceId(), employeeObj))
		{
			// Indexing Starts
			indexService.saveTermsAsIndex(employeeObj, "employeeNo", employeeObj.getEmployeeNo());
			indexService.saveTermsAsIndex(employeeObj, "firstName", employeeObj.getFirstName());
			indexService.saveTermsAsIndex(employeeObj, "lastName", employeeObj.getLastName());
			indexService.saveTermsAsIndex(employeeObj, "address", employeeObj.getAddress());
			indexService.saveTermsAsIndex(employeeObj, "contact", employeeObj.getContact());
			indexService.saveTermsAsIndex(employeeObj, "email", employeeObj.getEmail());
			indexService.saveTermsAsIndex(employeeObj, "description", employeeObj.getDescription());
			indexService.saveTermsAsIndex(employeeObj, "remarks", employeeObj.getRemarks());
			
			for (EmployeePropertiesBean beanObj : employeeObj.propertiesList)
			{
				indexService.saveTermsAsIndex(employeeObj, "properties", beanObj.getPropValue());
			}
		}
	} // .end of indexBean
	
	public void removeIndexBean(EmployeeBean employeeObj) 
	{
		indexService.removeTermsByBean(employeeObj);
	} // .end of removeIndexBean
	
}