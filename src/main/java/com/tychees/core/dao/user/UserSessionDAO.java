package com.tychees.core.dao.user;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class UserSessionDAO 
	extends AbstractDAO {  
  	
	@Override
	public String getBeanName() 
	{
		return UserSessionBean.class.getSimpleName();
	}
  
	public UserSessionBean getBeanById(String id) 
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
			
			List<UserSessionBean> list = query.list();
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
	
	public List<UserSessionBean> getBeansByUserId(String userId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(userId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.userId = :userId and " +
						 "OBJ.active = :active and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("userId", userId);		
			query.setParameter("active", true);		
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByUserId
}  
