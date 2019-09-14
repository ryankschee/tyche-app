package com.tychees.core.dao;

import java.sql.Timestamp;
import java.util.Calendar;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.tychees.core.bean.BeanSuperClass;

public abstract class AbstractDAO {
    
	@Autowired  
	private SessionFactory sessionFactory;  
	
	// HQL Where Clause: 
	protected String HQL_CONDITION_EXCLUDE_DELETED = "OBJ.deletedOn is null ";
	
  
	public void setSessionFactory(SessionFactory sf) 
	{  
		this.sessionFactory = sf;  
	}  
	
	protected SessionFactory getSessionFactory() 
	{
		return this.sessionFactory;
	}
	
	//--------------------------------------------------------------------------
	// Abstract methods
	protected abstract String getBeanName();
	
	//--------------------------------------------------------------------------
	// Protected methods
	
	public void saveOrUpdate(BeanSuperClass beanObj, String userId) 
	{  
		beanObj.setUpdatedOn( new Timestamp(Calendar.getInstance().getTimeInMillis()) );
		beanObj.setUpdatedBy( userId );
		
		this.sessionFactory.getCurrentSession().saveOrUpdate(getBeanName(), beanObj);  
	}  
	
	public void delete(BeanSuperClass beanObj) 
	{  
		if (null != beanObj) 
		{  
			this.sessionFactory.getCurrentSession().delete(getBeanName(), beanObj);  
		}  
	}
	
	//--------------------------------------------------------------------------
	// Utils
	
	protected boolean isNullOrEmpty(Object obj) 
	{
		if (obj == null)
			return true;
			
		if (obj instanceof String)	
		{
			if (((String)obj).trim().length() == 0)
				return true;
		}	
		
		return false;
	} // .end of isNullOrEmpty
}