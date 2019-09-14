package com.tychees.core.dao.customer;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.jboss.logging.Logger;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
import com.tychees.core.service.criteria.CustomerSearchCriteria;
  
@Repository  
public class CustomerDAO 
	extends AbstractDAO {  
  
	private final static Logger LOGGER = Logger.getLogger(CustomerDAO.class.getName());
	
	@Override
	public String getBeanName() 
	{
		return CustomerBean.class.getSimpleName();
	}
	
	public CustomerBean getBeanById(String id) 
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
			
			List<CustomerBean> list = query.list();
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

	public CustomerBean getBeanByCustomerNo(String customerNo) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(customerNo))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.customerNo = :customerNo and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
					
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("customerNo", customerNo);		
			
			List<CustomerBean> list = query.list();
			if (list.size() > 0)
				return list.get(0);  
			else
				return null;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanByCustomerNo

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
	
	public List<String> getTypesByPlaceId(String placeId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "select OBJ.templateName from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			hql.append( "OBJ.templateName is not null and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			hql.append( " GROUP BY OBJ.templateName" );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);
			
			return query.list();
			
			/*
			List<Object[]> listResult = query.list();
			
			LOGGER.error("placeId="+placeId);
			LOGGER.error(listResult.size());
			LOGGER.error(listResult);
			
			for (Object[] aRow : listResult) {
				String type = (String) aRow[0];
			    if (type == null)
			    	continue;
			    
			    result.add(type);
				LOGGER.error("TYPE: " + type);
			}
			return result;
			*/
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId
		
	public List<CustomerBean> getBeansByPlaceId(String placeId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId
	
	public List<CustomerBean> getBeansByEmployeeId(String placeId, String employeeId) 
			throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId) || isNullOrEmpty(employeeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			hql.append( "OBJ.employeeId = :employeeId and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);
			query.setParameter("employeeId", employeeId);
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByEmployeeId

	public List<CustomerBean> getBeansByKeywords(String placeId, String keywords) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			hql.append( "(upper(OBJ.customerNo) like :customerNo or " );
			hql.append( "upper(OBJ.lastName) like :lastName or " );
			hql.append( "upper(OBJ.firstName) like :firstName or " );
			hql.append( "upper(OBJ.contact) like :contact or " );
			hql.append( "upper(OBJ.email) like :email) and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);
			query.setParameter("customerNo", '%'+keywords.toUpperCase()+'%');
			query.setParameter("firstName", '%'+keywords.toUpperCase()+'%');
			query.setParameter("lastName", '%'+keywords.toUpperCase()+'%');
			query.setParameter("contact", '%'+keywords.toUpperCase()+'%');
			query.setParameter("email", '%'+keywords.toUpperCase()+'%');
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByKeywords
	
	public List<CustomerBean> getBeansByPlaceId(CustomerSearchCriteria criteria) 
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
			if (criteria.isFilterByCustomerType())
				hql.append( "OBJ.templateName = :templateName and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", criteria.getPlaceId());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			if (criteria.isFilterByCustomerType())
				query.setString("templateName", criteria.getCustomerType());	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId
	
	public List<String> getBeanIdsByPlaceId(CustomerSearchCriteria criteria) 
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
