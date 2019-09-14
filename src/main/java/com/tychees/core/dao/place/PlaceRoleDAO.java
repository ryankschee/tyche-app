package com.tychees.core.dao.place;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.place.PlaceRoleBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class PlaceRoleDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return PlaceRoleBean.class.getSimpleName();
	}
	
	public List<PlaceRoleBean> getAll() 
		throws DAOException
	{  
		try 
		{
			String hql = "from " + getBeanName() + " OBJ where " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
				
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			List<PlaceRoleBean> list = query.list();
			
			if (list.size() == 0) 
				return new ArrayList<PlaceRoleBean>();  
			else 
				return list;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getAll
  
	public PlaceRoleBean getBeanById(String id) 
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
			
			List<PlaceRoleBean> list = query.list();
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
	
	public List<PlaceRoleBean> getBeansByPlaceId(String placeId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.placeId = :placeId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
					
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("placeId", placeId);	
			
			List<PlaceRoleBean> list = query.list();		
			if (list.size() == 0) 
				return new ArrayList<PlaceRoleBean>();  
			else 
				return list;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId
	
	public List<PlaceRoleBean> getBeansByUserId(String userId) 
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
			
			List<PlaceRoleBean> list = query.list();		
			if (list.size() == 0) 
				return new ArrayList<PlaceRoleBean>();  
			else 
				return list;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByUserId
}  
