package com.tychees.core.dao.inventory;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.view.InventoryItemCompactViewBean;
import com.tychees.core.bean.inventory.view.InventoryItemViewBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
import com.tychees.core.service.criteria.InventorySearchCriteria;

@Repository  
public class InventoryItemDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return InventoryItemBean.class.getSimpleName();
	}
  
	public InventoryItemBean getBeanById(String id) 
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
			
			List<InventoryItemBean> list = query.list();
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

	public InventoryItemBean getBeanByName(String name) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(name))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.name = :name and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
						
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("name", name);	
			
			List<InventoryItemBean> list = query.list();
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
	
	public InventoryItemViewBean getViewBeanById(String id) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(id))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select id, categoryId, groupName, name, labels, posVisible, pwsVisible " );
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.id = :id and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("id", id);	
			
			List<Object[]> resultList = query.list();
			if (resultList.size()==0)
				return null;
			else
				return new InventoryItemViewBean(resultList.get(0));
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getViewBeanById

	public Long getBeanCountByPlaceId(String placeId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select count(*) from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);
			
			return (Long) query.uniqueResult();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanCountByPlaceId
	
	public List<InventoryItemBean> getAllBeans() 
		throws DAOException
	{  
		try 
		{
			String hql = "from " + getBeanName() + " OBJ where " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
						
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );		
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getAllBeans
	
	public List<InventoryItemBean> getBeansByLabel(String label) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(label))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.labels like :labels and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
						
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("labels", "%"+label+"%");	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanById

	public List<InventoryItemCompactViewBean> getCompactViewBeansByLabel(String label) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(label))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select id, itemType, name, labels, availability, quantity, unitCost, unitPrice, taxInclusive, taxDiscountPercentage, taxDiscountAmount " );
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.labels like :labels and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("labels", "%"+label+"%");	
			
			List<InventoryItemCompactViewBean> viewList = new ArrayList<InventoryItemCompactViewBean>();
			for (Object result : query.list()) 
			{
				InventoryItemCompactViewBean viewObj = new InventoryItemCompactViewBean( (Object[]) result );			
				viewList.add(viewObj);
			}
			return viewList;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanById
	
	public List<InventoryItemBean> getBeansByCategoryId(InventorySearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.categoryId = :categoryId and " );
			if (criteria.isFilterByGroupName())
				hql.append( "OBJ.groupName = :groupName and " );
			if (criteria.isFilterByPosVisible())
				hql.append( "OBJ.posVisible = :posVisible and " );
			if (criteria.isFilterByPwsVisible())
				hql.append( "OBJ.pwsVisible = :pwsVisible and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("categoryId", criteria.getCategoryId());
			if (criteria.isFilterByGroupName())
				query.setParameter("groupName", criteria.getGroupName());
			if (criteria.isFilterByPosVisible())
				query.setBoolean("posVisible", criteria.isPosVisible());
			if (criteria.isFilterByPwsVisible())
				query.setBoolean("pwsVisible", criteria.isPwsVisible());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByCategoryId
	
	public List<InventoryItemViewBean> getViewBeansByCategoryId(InventorySearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select id, categoryId, groupName, name, labels, posVisible, pwsVisible " );
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.categoryId = :categoryId and " );
			if (criteria.isFilterByGroupName())
				hql.append( "OBJ.groupName = :groupName and " );
			if (criteria.isFilterByPosVisible())
				hql.append( "OBJ.posVisible = :posVisible and " );
			if (criteria.isFilterByPwsVisible())
				hql.append( "OBJ.pwsVisible = :pwsVisible and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("categoryId", criteria.getCategoryId());
			if (criteria.isFilterByGroupName())
				query.setParameter("groupName", criteria.getGroupName());
			if (criteria.isFilterByPosVisible())
				query.setBoolean("posVisible", criteria.isPosVisible());
			if (criteria.isFilterByPwsVisible())
				query.setBoolean("pwsVisible", criteria.isPwsVisible());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			List<InventoryItemViewBean> viewList = new ArrayList<InventoryItemViewBean>();
			for (Object result : query.list()) {
				InventoryItemViewBean viewObj = new InventoryItemViewBean( (Object[]) result );			
				viewList.add(viewObj);
			}
			return viewList;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getViewBeansByCategoryId
	
	public List<InventoryItemBean> getBeansByPlaceId(InventorySearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			if (criteria.isFilterByPosVisible())
				hql.append( "OBJ.posVisible = :posVisible and " );
			if (criteria.isFilterByPwsVisible())
				hql.append( "OBJ.pwsVisible = :pwsVisible and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", criteria.getPlaceId());
			if (criteria.isFilterByPosVisible())
				query.setBoolean("posVisible", criteria.isPosVisible());
			if (criteria.isFilterByPwsVisible())
				query.setBoolean("pwsVisible", criteria.isPwsVisible());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId

	public Long getBeanCountByPlaceId(InventorySearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select count(*) from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			if (criteria.isFilterByPosVisible())
				hql.append( "OBJ.posVisible = :posVisible and " );
			if (criteria.isFilterByPwsVisible())
				hql.append( "OBJ.pwsVisible = :pwsVisible and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", criteria.getPlaceId());
			if (criteria.isFilterByPosVisible())
				query.setBoolean("posVisible", criteria.isPosVisible());
			if (criteria.isFilterByPwsVisible())
				query.setBoolean("pwsVisible", criteria.isPwsVisible());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			return (Long) query.uniqueResult();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanCountByPlaceId
	
	public Long getBeanCountByCategoryId(InventorySearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select count(*) from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.categoryId = :categoryId and " );
			if (criteria.isFilterByGroupName())
				hql.append( "OBJ.groupName = :groupName and " );
			if (criteria.isFilterByPosVisible())
				hql.append( "OBJ.posVisible = :posVisible and " );
			if (criteria.isFilterByPwsVisible())
				hql.append( "OBJ.pwsVisible = :pwsVisible and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("categoryId", criteria.getCategoryId());
			if (criteria.isFilterByGroupName())
				query.setParameter("groupName", criteria.getGroupName());
			if (criteria.isFilterByPosVisible())
				query.setBoolean("posVisible", criteria.isPosVisible());
			if (criteria.isFilterByPwsVisible())
				query.setBoolean("pwsVisible", criteria.isPwsVisible());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			return (Long) query.uniqueResult();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanCountByCategoryId
	
	public List<String> getBeanGroupsByCategoryId(String categoryId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(categoryId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select distinct groupName from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.categoryId = :categoryId and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("categoryId", categoryId);
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanCountByCategoryId

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
			if (criteria.isFilterByPosVisible())
				hql.append( "OBJ.posVisible = :posVisible and " );
			if (criteria.isFilterByPwsVisible())
				hql.append( "OBJ.pwsVisible = :pwsVisible and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", criteria.getPlaceId());
			if (criteria.isFilterByPosVisible())
				query.setBoolean("posVisible", criteria.isPosVisible());
			if (criteria.isFilterByPwsVisible())
				query.setBoolean("pwsVisible", criteria.isPwsVisible());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId
	
}  
