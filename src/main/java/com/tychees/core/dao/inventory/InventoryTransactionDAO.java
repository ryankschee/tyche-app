package com.tychees.core.dao.inventory;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
import com.tychees.core.service.criteria.InventorySearchCriteria;

@Repository  
public class InventoryTransactionDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return InventoryTransactionBean.class.getSimpleName();
	}
  
	public InventoryTransactionBean getBeanById(String id) 
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
			
			List<InventoryTransactionBean> list = query.list();
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
	
	public InventoryTransactionBean getBeanByThirdPartyId(String id) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(id))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.thirdPartyId = :id and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("id", id);
			
			List<InventoryTransactionBean> list = query.list();
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
	
	public List<InventoryTransactionBean> getBeansByPlaceId(InventorySearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", criteria.getPlaceId());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId
	
	public List<String> getBeanIdsByPlaceId(InventorySearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select id from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", criteria.getPlaceId());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanIdsByPlaceId
}  
