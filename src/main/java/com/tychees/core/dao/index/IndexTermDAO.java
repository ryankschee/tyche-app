package com.tychees.core.dao.index;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.index.IndexTermBean;
import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
  
@Repository  
public class IndexTermDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return IndexTermBean.class.getSimpleName();
	} // .end of getBeanName
	
	public IndexTermBean getBeanById(String id) 
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
			
			List<IndexTermBean> list = query.list();
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
	
	public IndexTermBean getBeanByCompositeId(String beanId, String term) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(beanId) || isNullOrEmpty(term))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.beanId = :beanId and " );
			hql.append( "OBJ.term = :term and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			hql.append( " order by frequency asc" );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("beanId", beanId);	
			query.setParameter("term", term);	
			
			List<IndexTermBean> list = query.list();
			if (list.size() > 0)
				return list.get(0);  
			else
				return null;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId
	
	public List<IndexTermBean> getBeansByBeanId(String beanId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(beanId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.beanId = :beanId and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			hql.append( " order by frequency asc" );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("beanId", beanId);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByBeanId
	
	public List<IndexTermBean> getBeansByTerm_exactMatch(String placeId, String term) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId) || isNullOrEmpty(term))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			hql.append( "OBJ.term = :term and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			hql.append( " order by frequency asc" );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);	
			query.setParameter("term", term);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByTerm_exactMatch
	
	public List<IndexTermBean> getBeansByTerm_wildcardMatch(String placeId, String term, boolean caseSensitive, 
			boolean searchByCustomer, boolean searchByBilling, boolean searchByCategory, boolean searchByItem, boolean searchByPlace) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "from " + getBeanName() + " OBJ where " );
			hql.append( "OBJ.placeId = :placeId and " );
			if (caseSensitive)
				hql.append( "OBJ.term like :term and " );
			else
				hql.append( "upper(OBJ.term) like :term and " );

			hql.append( "OBJ.beanClassName in (:classList) and " );			
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			hql.append( " order by frequency asc" );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);	
			if (caseSensitive)
				query.setParameter("term", "%" + term + "%");	
			else
				query.setParameter("term", "%" + term.toUpperCase() + "%");	
			
			List<String> classList = new ArrayList<String>();
			if (searchByCustomer)
				classList.add(CustomerBean.class.getName());	
			if (searchByBilling)
				classList.add(BillingBean.class.getName());
			if (searchByCategory)
				classList.add(InventoryCategoryBean.class.getName());
			if (searchByItem)
				classList.add(InventoryItemBean.class.getName());
			if (searchByPlace)
				classList.add(PlaceBean.class.getName());
			query.setParameterList("classList", classList);
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByTerm_wildcardMatch
	
	public List<IndexTermBean> getBeansByTerm_exactMatch(String placeId, List<String> terms, boolean caseSensitive, 
			boolean searchByCustomer, boolean searchByBilling, boolean searchByCategory, boolean searchByItem, boolean searchByPlace) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			StringBuilder hql = new StringBuilder();
			hql.append( "SELECT obj0 FROM " );
			for (int i = 0 ; i < terms.size() ; i++) {
				hql.append( getBeanName() + " obj" + i);
				if (i == terms.size()-1)
					hql.append( " " );
				else
					hql.append( ", " );
			}
			
			hql.append( "WHERE " );
			
			for (int i = 0 ; i < terms.size() ; i++) {
				hql.append( "obj" + i + ".placeId = :placeId");
				if (i == terms.size()-1)
					hql.append( " AND " );
				else
					hql.append( " AND " );
			}
			
			for (int i = 0 ; i < terms.size() ; i++) {
				if (caseSensitive)
					hql.append( "obj" + i + ".term = :term" + i );
				else
					hql.append( "UPPER(obj" + i + ".term) = :term" + i );
					
				if (i == terms.size()-1)
					hql.append( " AND " );
				else
					hql.append( " AND " );
			}
			
			for (int i = 0 ; i < terms.size() ; i++) {
				hql.append( "obj" + i + ".beanClassName IN (:classList)");
				if (i == terms.size()-1)
					hql.append( " AND " );
				else 
					hql.append( " AND " );
			}
			
			for (int i = 0 ; i < terms.size() ; i++) {
				if (i == terms.size()-1) {
					
				} else {
					hql.append( "obj" + i + ".beanId = obj" + (i+1) + ".beanId");
					hql.append( " AND " );
				}
			}

			for (int i = 0 ; i < terms.size() ; i++) {		
				if (i == terms.size()-1) {		
					hql.append( "obj" + i + ".deletedOn IS NULL ");
				} else {
					hql.append( "obj" + i + ".deletedOn IS NULL AND ");
				}
			}
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);	

			for (int i = 0 ; i < terms.size() ; i++) {
				if (caseSensitive)
					query.setParameter("term" + i, terms.get(i));	
				else
					query.setParameter("term" + i, terms.get(i).toUpperCase());	
			}
			
			List<String> classList = new ArrayList<String>();
			if (searchByCustomer)
				classList.add(CustomerBean.class.getName());	
			if (searchByBilling)
				classList.add(BillingBean.class.getName());
			if (searchByCategory)
				classList.add(InventoryCategoryBean.class.getName());
			if (searchByItem)
				classList.add(InventoryItemBean.class.getName());
			if (searchByPlace)
				classList.add(PlaceBean.class.getName());
			query.setParameterList("classList", classList);
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByTerm_exactMatch
}  
