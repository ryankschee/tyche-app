package com.tychees.core.dao.place;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.place.PlaceNotificationBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class PlaceNotificationDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return PlaceNotificationBean.class.getSimpleName();
	}
	
	public PlaceNotificationBean getBeanById(String id) 
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
			
			List<PlaceNotificationBean> list = query.list();
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
		
	public List<PlaceNotificationBean> getBeansByUserId(String placeId, String userId, int recordCount) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(userId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
					
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.placeId = :placeId and " + 
						 "OBJ.userId = :userId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED + 
						 " order by OBJ.createdOn desc";
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("placeId", placeId);		
			query.setParameter("userId", userId);	
			query.setMaxResults(recordCount);
			
			List<PlaceNotificationBean> list = query.list();		
			if (list.size() == 0) 
				return new ArrayList<PlaceNotificationBean>();  
			else 
				return list;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByUserId
}  
