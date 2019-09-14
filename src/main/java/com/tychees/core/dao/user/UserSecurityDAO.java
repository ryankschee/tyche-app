package com.tychees.core.dao.user;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.user.UserSecurityBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
  
@Repository  
public class UserSecurityDAO 
	extends AbstractDAO {  
		
	@Override
	public String getBeanName() 
	{
		return UserSecurityBean.class.getSimpleName();
	}
	  
	public UserSecurityBean getBeanById(String id) 
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
			
			List<UserSecurityBean> list = query.list();
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
	
	public UserSecurityBean getBeanById(String id, long lastSyncedTime) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(id))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.id = :id and " + 
						 "OBJ.updatedOn > :updatedOn and " +
						 HQL_CONDITION_EXCLUDE_DELETED;
				
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("id", id);
			query.setTimestamp("updatedOn", new Date(lastSyncedTime));
			
			List<UserSecurityBean> list = query.list();
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
	
	public boolean updatePassword(String userId, String password) 
		throws DAOException 
	{
		try 
		{
			if (isNullOrEmpty(userId) || isNullOrEmpty(password))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "update " + getBeanName() + " OBJ set " +
						 "OBJ.password = :password " + 
						 "where OBJ.id = :userId";
				
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("userId", userId);	
			query.setParameter("password", password);	
			
			return query.executeUpdate() > 0;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	}
}  
