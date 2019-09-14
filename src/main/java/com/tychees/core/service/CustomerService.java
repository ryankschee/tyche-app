package com.tychees.core.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.customer.CustomerAddressBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.customer.CustomerContactBean;
import com.tychees.core.bean.customer.CustomerEmailBean;
import com.tychees.core.bean.customer.CustomerProfileBean;
import com.tychees.core.bean.customer.CustomerProfilePropertiesBean;
import com.tychees.core.bean.customer.CustomerPropertiesBean;
import com.tychees.core.bean.customer.view.CustomerCompactViewBean;
import com.tychees.core.bean.customer.view.CustomerViewBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.customer.CustomerAddressDAO;
import com.tychees.core.dao.customer.CustomerContactDAO;
import com.tychees.core.dao.customer.CustomerDAO;
import com.tychees.core.dao.customer.CustomerEmailDAO;
import com.tychees.core.dao.customer.CustomerProfileDAO;
import com.tychees.core.dao.customer.CustomerProfilePropertiesDAO;
import com.tychees.core.dao.customer.CustomerPropertiesDAO;
import com.tychees.core.service.criteria.CustomerSearchCriteria;
import com.tychees.core.util.CustomerUtil;
  
@Service("customerService")  
public class CustomerService 
{
	@Autowired
	CustomerUtil customerUtil;
	@Autowired  
	CustomerDAO customerDao;  
	@Autowired  
	CustomerEmailDAO customerEmailDao;
	@Autowired  
	CustomerAddressDAO customerAddressDao;
	@Autowired  
	CustomerContactDAO customerContactDao;
	@Autowired  
	CustomerPropertiesDAO customerPropertiesDao;
	@Autowired  
	CustomerProfileDAO customerProfileDao;
	@Autowired  
	CustomerProfilePropertiesDAO customerProfilePropertiesDao;

	private final static Logger LOGGER = Logger.getLogger(CustomerService.class.getName());
	
	//--------------------------------------------------------------------------
	
	@Transactional  
	public CustomerBean getCustomerById(String id) 
	{  
		try 
		{
			CustomerBean customerObj = customerDao.getBeanById(id);  
			return customerUtil.fillBean(customerObj);
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getCustomerById

	@Transactional  
	public CustomerBean getCustomerByCustomerNo(String customerNo) 
	{  
		try 
		{
			CustomerBean customerObj = customerDao.getBeanByCustomerNo(customerNo);  
			return customerUtil.fillBean(customerObj);
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getCustomerById
	
	@Transactional
	public Long getCustomerCountByPlaceId(String placeId)
	{
		try 
		{
			return customerDao.getBeanCountByPlaceId(placeId);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return 0L;
		}
	} // .end of getCustomerCountByPlaceId

	@Transactional  
	public List<CustomerBean> getCustomerListByIds(String ids) 
	{  
		try 
		{
			List<CustomerBean> customerList = new ArrayList<CustomerBean>();
			StringTokenizer tokenizer = new StringTokenizer(ids, ", ");
			while (tokenizer.hasMoreTokens()) {
				customerList.add( customerDao.getBeanById(tokenizer.nextToken()) );
			}	  
			
			return customerUtil.fillBeans(customerList);
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<CustomerBean>();
		}
	} // .end of getCustomerListByIds
	
	@Transactional
	public List<CustomerBean> getCustomersByPlaceId(String placeId, boolean fullBean)
	{
		try 
		{
			List<CustomerBean> customerList = customerDao.getBeansByPlaceId(placeId);
				
			if (fullBean)
			{
				for (CustomerBean customerObj : customerList)
					customerUtil.fillBean( customerObj );
			}
			
			return customerList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<CustomerBean>();
		}
	} // .end of getCustomersByPlaceId
	
	@Transactional
	public List<CustomerBean> getCustomersByPlaceId(CustomerSearchCriteria criteria)
	{
		try 
		{
			List<CustomerBean> customerList = customerDao.getBeansByPlaceId(criteria);
				
			if (criteria.isFullBean())
			{
				for (CustomerBean customerObj : customerList)
					customerUtil.fillBean( customerObj );
			}
			
			return customerList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<CustomerBean>();
		}
	} // .end of getCustomersByPlaceId

	@Transactional
	public List<CustomerViewBean> getCustomerViewsByPlaceId(CustomerSearchCriteria criteria)
	{
		try 
		{
			List<CustomerViewBean> viewList = new ArrayList<CustomerViewBean>();
			List<CustomerBean> customerList = customerDao.getBeansByPlaceId(criteria);
				
			for (CustomerBean customerObj : customerList)
				viewList.add(new CustomerViewBean(customerObj));
			
			return viewList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<CustomerViewBean>();
		}
	} // .end of getCustomersByPlaceId

	@Transactional
	public List<CustomerCompactViewBean> getCustomerCompactViewsByPlaceId(CustomerSearchCriteria criteria)
	{
		try 
		{
			List<CustomerCompactViewBean> viewList = new ArrayList<CustomerCompactViewBean>();
			List<CustomerBean> customerList = customerDao.getBeansByPlaceId(criteria);
				
			for (CustomerBean customerObj : customerList)
				viewList.add(new CustomerCompactViewBean(customerObj));
			
			return viewList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<CustomerCompactViewBean>();
		}
	} // .end of getCustomerCompactViewsByPlaceId

	@Transactional
	public List<CustomerCompactViewBean> getCustomerCompactViewsByEmployeeId(String placeId, String employeeId)
	{
		try 
		{
			List<CustomerCompactViewBean> viewList = new ArrayList<CustomerCompactViewBean>();
			List<CustomerBean> customerList = customerDao.getBeansByEmployeeId(placeId, employeeId);
				
			for (CustomerBean customerObj : customerList)
				viewList.add(new CustomerCompactViewBean(customerObj));
			
			return viewList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<CustomerCompactViewBean>();
		}
	} // .end of getCustomerCompactViewsByEmployeeId

	@Transactional
	public List<CustomerCompactViewBean> getCustomerCompactViewsByKeywords(String placeId, String keywords)
	{
		try 
		{
			List<CustomerCompactViewBean> viewList = new ArrayList<CustomerCompactViewBean>();
			List<CustomerBean> customerList = customerDao.getBeansByKeywords(placeId, keywords);
				
			for (CustomerBean customerObj : customerList)
				viewList.add(new CustomerCompactViewBean(customerObj));
			
			return viewList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<CustomerCompactViewBean>();
		}
	} // .end of getCustomerCompactViewsByKeywords

	@Transactional
	public List<String> getCustomerIdsByPlaceId(CustomerSearchCriteria criteria)
	{
		try 
		{
			List<String> customerList = customerDao.getBeanIdsByPlaceId(criteria);
			return customerList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<String>();
		}
	} // .end of getCustomerIdsByPlaceId

	@Transactional
	public List<String> getCustomerTypesByPlaceId(String placeId)
	{
		try 
		{
			return customerDao.getTypesByPlaceId(placeId);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<String>();
		}
	} // .end of getCustomerTypesByPlaceId

	@Transactional
	public List<String> getCustomerStatesByPlaceId(String placeId)
	{
		try 
		{
			return customerAddressDao.getStatesByPlaceId(placeId);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<String>();
		}
	} // .end of getCustomerStatesByPlaceId

	@Transactional
	public List<String> getCustomerAreasByPlaceId(String placeId)
	{
		try 
		{
			return customerAddressDao.getAreasByPlaceId(placeId);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<String>();
		}
	} // .end of getCustomerAreasByPlaceId

	@Transactional
	public List<String> getCustomerCitiesByPlaceId(String placeId)
	{
		try 
		{
			return customerAddressDao.getCitiesByPlaceId(placeId);
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<String>();
		}
	} // .end of getCustomerCitiesByPlaceId
	
	@Transactional  
	public void saveOrUpdateCustomer(CustomerBean customerObj, String userId) 
	{  
		for (CustomerEmailBean beanObj : customerObj.emailList)
		{
			beanObj.setCustomerId( customerObj.getId() );
			customerEmailDao.saveOrUpdate( beanObj, userId );
		}
		
		for (CustomerAddressBean beanObj : customerObj.addressList)
		{
			beanObj.setCustomerId( customerObj.getId() );
			customerAddressDao.saveOrUpdate( beanObj, userId );
		}
		
		for (CustomerContactBean beanObj : customerObj.contactList)
		{
			beanObj.setCustomerId( customerObj.getId() );
			customerContactDao.saveOrUpdate( beanObj, userId );
		}
		
		for (CustomerPropertiesBean beanObj : customerObj.propertiesList)
		{
			beanObj.setCustomerId( customerObj.getId() );
			customerPropertiesDao.saveOrUpdate( beanObj, userId );
		}
		
		for (CustomerProfileBean beanObj : customerObj.profileList)
		{
			beanObj.setCustomerId( customerObj.getId() );
			customerProfileDao.saveOrUpdate( beanObj, userId );
			
			for (CustomerProfilePropertiesBean childBeanObj : beanObj.propertiesList) {
				childBeanObj.setProfileId( beanObj.getId() );
				customerProfilePropertiesDao.saveOrUpdate( childBeanObj, userId );
			}
		}
		
		// Save Root Bean
		customerDao.saveOrUpdate(customerObj, userId);  
		// Index Bean
		if (customerObj.isDeleted())
			customerUtil.removeIndexBean(customerObj);
		else
			customerUtil.indexBean(customerObj);
	} // .end of saveOrUpdateCustomer
	
	@Transactional  
	public void deleteCustomer(CustomerBean customerObj) 
	{  
		customerDao.delete(customerObj);  
	} // .end of deleteCustomer
	
	@Transactional
	public List<CustomerContactBean> getContactsByCustomer(String customerId) 
	{
		try {
			return customerContactDao.getBeansByCustomerId(customerId);
		}
		catch (DAOException e)
		{
			return new ArrayList<CustomerContactBean>();
		}
	} // .end of getContactsByCustomer
	
	@Transactional
	public List<CustomerEmailBean> getEmailsByCustomer(String customerId) 
	{
		try {
			return customerEmailDao.getBeansByCustomerId(customerId);
		}
		catch (DAOException e)
		{
			return new ArrayList<CustomerEmailBean>();
		}
	} // .end of getEmailsByCustomer
	
	@Transactional
	public List<CustomerAddressBean> getAddressesByCustomer(String customerId) 
	{
		try {
			return customerAddressDao.getBeansByCustomerId(customerId);
		}
		catch (DAOException e)
		{
			return new ArrayList<CustomerAddressBean>();
		}
	} // .end of getAddressesByCustomer
}
