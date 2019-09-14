package com.tychees.core.dao.batch;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.batch.BatchRequestBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class BatchRequestDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return BatchRequestBean.class.getSimpleName();
	}
  
	public BatchRequestBean getBeanById(String id) 
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
			
			List<BatchRequestBean> list = query.list();
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
	
	public List<BatchRequestBean> getBeansByUserId(String userId, String placeId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(userId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " +
						 "OBJ.placeId = :placeId and " + 
						 "OBJ.userId = :userId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
				
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("placeId", placeId);
			query.setParameter("userId", userId);
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByUserId
}  
