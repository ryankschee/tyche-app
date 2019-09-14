package com.tychees.core.dao.common;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.common.CommonCalendarBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class CommonCalendarDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return CommonCalendarBean.class.getSimpleName();
	}
  
	public CommonCalendarBean getBeanById(String id) 
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
			
			List<CommonCalendarBean> list = query.list();
			if (list.size() == 0) 
				return null;  
			else 
				return list.get(0);
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanById 
	
	public List<CommonCalendarBean> getBeansByPlaceId(String placeId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.placeId = :placeId and " + 
						 "OBJ.userId = :userId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("placeId", placeId);			
			query.setParameter("userId", "");	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId
	
	public List<CommonCalendarBean> getBeansByUserId(String userId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(userId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.userId = :userId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("userId", userId);		
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByUserId
	
	public List<CommonCalendarBean> getBeansByForeignId(String foreignId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(foreignId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.foreignId = :foreignId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("foreignId", foreignId);		
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByForeignId
	
	public List<CommonCalendarBean> getBeansByCompositeId(String placeId, String userId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId) || isNullOrEmpty(userId))
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
	} // .end of getBeansByCompositeId
}  
