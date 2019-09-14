package com.tychees.core.dao.customer;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.customer.CustomerAddressBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class CustomerAddressDAO 
	extends AbstractDAO {  
  
	public String getParentName() 
	{
		return CustomerBean.class.getSimpleName();
	}
	
	@Override
	public String getBeanName() 
	{
		return CustomerAddressBean.class.getSimpleName();
	}
  
	public CustomerAddressBean getBeanById(String id) 
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
			
			List<CustomerAddressBean> list = query.list();
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
	
	public List<CustomerAddressBean> getBeansByCustomerId(String customerId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(customerId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.customerId = :customerId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
				
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("customerId", customerId);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByCustomerId
	
	public List<String> getStatesByPlaceId(String placeId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select OBJ.state from " + getBeanName() + " OBJ, " + getParentName() + " PARENT where " ); 
			hql.append( "OBJ.customerId = PARENT.id and " );
			hql.append( "PARENT.placeId = :placeId and " ); 
			hql.append( "OBJ.state is not null and " ); 
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			hql.append( " GROUP BY OBJ.state" );
				
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getStatesByPlaceId
	
	public List<String> getAreasByPlaceId(String placeId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select OBJ.area from " + getBeanName() + " OBJ, " + getParentName() + " PARENT where " ); 
			hql.append( "OBJ.customerId = PARENT.id and " );
			hql.append( "PARENT.placeId = :placeId and " ); 
			hql.append( "OBJ.area is not null and " ); 
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			hql.append( " GROUP BY OBJ.area" );
				
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getAreasByPlaceId
	

	public List<String> getCitiesByPlaceId(String placeId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select OBJ.city from " + getBeanName() + " OBJ, " + getParentName() + " PARENT where " ); 
			hql.append( "OBJ.customerId = PARENT.id and " );
			hql.append( "PARENT.placeId = :placeId and " ); 
			hql.append( "OBJ.city is not null and " ); 
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			hql.append( " GROUP BY OBJ.city" );
				
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getCitiesByPlaceId
}  
