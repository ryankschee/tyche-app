package com.tychees.core.dao.customer;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.customer.CustomerProfilePropertiesBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class CustomerProfilePropertiesDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return CustomerProfilePropertiesBean.class.getSimpleName();
	}
  
	public CustomerProfilePropertiesBean getBeanById(String id) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(id))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.id = :id and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("id", id);		
			
			List<CustomerProfilePropertiesBean> list = query.list();
			if (list.size() > 0)
				return list.get(0);  
			else
				return null;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanById
	
	public List<CustomerProfilePropertiesBean> getBeansByProfileId(String profileId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(profileId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.profileId = :profileId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED + " " +
						 "ORDER BY OBJ.propSeqno ASC";
				
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("profileId", profileId);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByProfileId
}  
