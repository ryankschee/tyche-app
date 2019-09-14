package com.tychees.core.dao.billing;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.console.controller.inventory.InventoryItemController;
import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
import com.tychees.core.service.criteria.BillingSearchCriteria;
  
@Repository  
public class BillingDAO 
	extends AbstractDAO 
{  
	private final static Logger LOGGER = Logger.getLogger(BillingDAO.class.getName());
	
	@Override
	public String getBeanName() 
	{
		return BillingBean.class.getSimpleName();
	}
	
	public BillingBean getBeanById(String id) 
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
			List<BillingBean> list = query.list();
			
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
	
	public BillingBean getBeanByBillingNo(String placeId, String billingNo) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(billingNo))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
			
			String hql = "from " + getBeanName() + " OBJ where " +
						 "OBJ.billingNo = :billingNo and " + 
						 "OBJ.placeId = :placeId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("billingNo", billingNo);
			query.setParameter("placeId", placeId);		
			List<BillingBean> list = query.list();
			
			if (list.size() > 0)
				return list.get(0);  
			else
				return null;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanByBillingNo

	public BillingBean getBeanByQuotationNo(String quotationNo) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(quotationNo))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
			
			String hql = "from " + getBeanName() + " OBJ where " +
						 "OBJ.quotationNo = :quotationNo and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("quotationNo", quotationNo);		
			List<BillingBean> list = query.list();
			
			if (list.size() > 0)
				return list.get(0);  
			else
				return null;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanByQuotationNo
	
	public List<BillingBean> getBeansByPlaceId(String placeId)
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
	
	public List<BillingBean> getBeansByPlaceId(BillingSearchCriteria criteria)
		throws DAOException 
	{  
		try 
		{
			if (isNullOrEmpty(criteria) || isNullOrEmpty(criteria.getPlaceId()))
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
	
	public List<BillingBean> getBeansByCustomerId(BillingSearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria) || isNullOrEmpty(criteria.getCustomerId()))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
			
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.customerId = :customerId and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("customerId", criteria.getCustomerId());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByCustomerId

	public List<BillingBean> getBeansByEmployeeId(String placeId, String employeeId)
		throws DAOException 
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
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
	
	public List<BillingBean> getBeansByBucketId(BillingSearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria) || isNullOrEmpty(criteria.getBucketId()))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
			
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.bucketId = :bucketId and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("bucketId", criteria.getBucketId());
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByBucketId
	
	public List<String> getBeanIdsByPlaceId(BillingSearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria) || isNullOrEmpty(criteria.getPlaceId()))
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
	} // .end of getBeansByPlaceId
	
	public List<BillingBean> getBeansByTimePeriod(BillingSearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria) || isNullOrEmpty(criteria.getPlaceId()))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
			
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			if (criteria.isFilterByBillingDate()) {
				hql.append( "OBJ.billingDate > :beginTime and " );
				hql.append( "OBJ.billingDate < :endTime and " );
			}
			if (criteria.isFilterByInvoiceDate()) {
				hql.append( "OBJ.invoiceDate > :beginTime and " );
				hql.append( "OBJ.invoiceDate < :endTime and " );
			}
			if (criteria.isFilterByLastSyncedTime()) {
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			}
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", criteria.getPlaceId());
			if (criteria.isFilterByBillingDate()) {
				query.setParameter("beginTime", new Timestamp(criteria.getBeginTime()));
				query.setParameter("endTime", new Timestamp(criteria.getEndTime()));
			}
			if (criteria.isFilterByInvoiceDate()) {
				query.setParameter("beginTime", new Timestamp(criteria.getBeginTime()));
				query.setParameter("endTime", new Timestamp(criteria.getEndTime()));
			}
			if (criteria.isFilterByLastSyncedTime()) {
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));	
			}
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByTimePeriod	
}  
