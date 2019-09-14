package com.tychees.core.util;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tychees.core.bean.common.CommonAddressBean;
import com.tychees.core.bean.common.CommonContactBean;
import com.tychees.core.bean.customer.CustomerAddressBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.customer.CustomerContactBean;
import com.tychees.core.bean.customer.CustomerEmailBean;
import com.tychees.core.bean.customer.CustomerProfileBean;
import com.tychees.core.bean.customer.CustomerProfilePropertiesBean;
import com.tychees.core.bean.customer.CustomerPropertiesBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.customer.CustomerAddressDAO;
import com.tychees.core.dao.customer.CustomerContactDAO;
import com.tychees.core.dao.customer.CustomerDAO;
import com.tychees.core.dao.customer.CustomerEmailDAO;
import com.tychees.core.dao.customer.CustomerProfileDAO;
import com.tychees.core.dao.customer.CustomerProfilePropertiesDAO;
import com.tychees.core.dao.customer.CustomerPropertiesDAO;
import com.tychees.core.service.IndexService;

@Component
public class CustomerUtil {

    @Autowired  
	IndexUtil indexUtil;
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
	@Autowired
	IndexService indexService;
	
	public List<CustomerBean> fillBeans(List<CustomerBean> customerList) 
	{
		for (CustomerBean customerObj : customerList)
		{
			fillBean( customerObj );
		}
		
		return customerList;
	} // .end of fillBeans
	
	/**
	 * Full Structure of CustomerBean
	 * -----------------------------
	 * CustomerBean
	 *  |- addressList
	 *  |- contactList
	 *  |- emailList
	 *  |- propertiesList
	 *  |- profileList
	 *      |- propertiesList
	 */ 
	public CustomerBean fillBean(CustomerBean customerObj) 
	{  
		try
		{
			if (customerObj != null)
			{
				// set state - fullBeanLoaded
				customerObj.setFullBeanLoaded( true );
				
				customerObj.addressList = 
					customerAddressDao.getBeansByCustomerId(customerObj.getId());			
				customerObj.contactList = 
					customerContactDao.getBeansByCustomerId(customerObj.getId());			
				customerObj.emailList = 
					customerEmailDao.getBeansByCustomerId(customerObj.getId());			
				customerObj.propertiesList = 
					customerPropertiesDao.getBeansByCustomerId(customerObj.getId());			
				customerObj.profileList = 
					customerProfileDao.getBeansByCustomerId(customerObj.getId());
				for (CustomerProfileBean profileObj : customerObj.profileList) 
				{
					profileObj.propertiesList = 
						customerProfilePropertiesDao.getBeansByProfileId(profileObj.getId());
				}
			}
			
			return customerObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return customerObj;
		}
	} // .end of fillBean
	
	public void indexBean(CustomerBean customerObj) 
	{
		if (indexService.validateBean(customerObj.getPlaceId(), customerObj))
		{
			// Indexing Starts
			indexService.saveTermsAsIndex(customerObj, "customerNo", customerObj.getCustomerNo());
			indexService.saveTermsAsIndex(customerObj, "firstName", customerObj.getFirstName());
			indexService.saveTermsAsIndex(customerObj, "lastName", customerObj.getLastName());
			indexService.saveTermsAsIndex(customerObj, "address", customerObj.getAddress());
			indexService.saveTermsAsIndex(customerObj, "contact", customerObj.getContact());
			indexService.saveTermsAsIndex(customerObj, "email", customerObj.getEmail());
			indexService.saveTermsAsIndex(customerObj, "description", customerObj.getDescription());
			indexService.saveTermsAsIndex(customerObj, "remarks", customerObj.getRemarks());
			
			for (CustomerEmailBean beanObj : customerObj.emailList)
			{
				indexService.saveTermsAsIndex(customerObj, "email", beanObj.getEmailAddress());
			}
			
			for (CustomerAddressBean beanObj : customerObj.addressList)
			{
				indexService.saveTermsAsIndex(customerObj, "address", beanObj.getAttentionTo());
				indexService.saveTermsAsIndex(customerObj, "address", beanObj.getStreetLine1());
				indexService.saveTermsAsIndex(customerObj, "address", beanObj.getStreetLine2());
				indexService.saveTermsAsIndex(customerObj, "address", beanObj.getStreetLine3());
				indexService.saveTermsAsIndex(customerObj, "address", beanObj.getPostalCode());
				indexService.saveTermsAsIndex(customerObj, "address", beanObj.getCity());
				indexService.saveTermsAsIndex(customerObj, "address", beanObj.getState());
				indexService.saveTermsAsIndex(customerObj, "address", beanObj.getCountry());
			}
			
			for (CustomerContactBean beanObj : customerObj.contactList)
			{
				indexService.saveTermsAsIndex(customerObj, "contact", beanObj.getPhoneNumber());
				indexService.saveTermsAsIndex(customerObj, "contact", beanObj.getExtension());
			}
			
			for (CustomerPropertiesBean beanObj : customerObj.propertiesList)
			{
				indexService.saveTermsAsIndex(customerObj, "properties", beanObj.getPropValue());
			}
			
			for (CustomerProfileBean beanObj : customerObj.profileList)
			{
				for (CustomerProfilePropertiesBean childBeanObj : beanObj.propertiesList) 
				{
					indexService.saveTermsAsIndex(customerObj, "profile", childBeanObj.getPropValue());
				}
			}
		}
	} // .end of indexBean
	
	public void removeIndexBean(CustomerBean customerObj) 
	{
		indexService.removeTermsByBean(customerObj);
	} // .end of removeIndexBean
	
}