package com.tychees.core.dao.billing;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.billing.BillingBucketBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
import com.tychees.core.service.criteria.BillingBucketSearchCriteria;
  
@Repository  
public class BillingBucketDAO 
	extends AbstractDAO 
{  
	@Override
	public String getBeanName() 
	{
		return BillingBucketBean.class.getSimpleName();
	}
	
	public BillingBucketBean getBeanById(String id) 
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
			List<BillingBucketBean> list = query.list();
			
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
	
	public List<BillingBucketBean> getBeansByPlaceId(BillingBucketSearchCriteria criteria)
		throws DAOException 
	{  
		try 
		{
			if (isNullOrEmpty(criteria) || isNullOrEmpty(criteria.getPlaceId()))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
			
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			if (criteria.isFilterByBucketStatus()) 
				hql.append( "OBJ.bucketStatus in (:bucketStatusList) and " );
			if (criteria.isFilterByLastSyncedTime())
				hql.append( "OBJ.updatedOn > :updatedOn and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", criteria.getPlaceId());
			if (criteria.isFilterByBucketStatus()) {
				StringTokenizer tokenizer = new StringTokenizer(criteria.getBucketStatus(), ",");
				List<String> statusList = new ArrayList<String>();
				while (tokenizer.hasMoreTokens())
					statusList.add(tokenizer.nextToken().trim());
				
				query.setParameterList("bucketStatusList", statusList);
			}
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
