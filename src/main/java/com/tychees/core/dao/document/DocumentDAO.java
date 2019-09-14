package com.tychees.core.dao.document;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.document.DocumentBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
import com.tychees.core.service.criteria.DocumentSearchCriteria;

@Repository  
public class DocumentDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return DocumentBean.class.getSimpleName();
	}

	public DocumentBean getBeanById(String id) 
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
			
			List<DocumentBean> list = query.list();
			if (list.size() > 0) 
			{
				try {
					DocumentBean documentObj = list.get(0);
					setDocumentContent(documentObj);
					return documentObj;
				} catch (IOException e) {
					return null;
				}
			} 
			else
			{
				return null;
			}
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanById
	
	public List<DocumentBean> getAll(DocumentSearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "";
			hql += "from " + getBeanName() + " OBJ where "; 
			if (criteria.isFilterByLastSyncedTime())
				hql += "OBJ.updatedOn > :updatedOn and ";
			hql += HQL_CONDITION_EXCLUDE_DELETED;
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));
			List<DocumentBean> list = query.list();
			
			if (list.size() == 0) 
				return new ArrayList<DocumentBean>();  
			else 
			{
				for (DocumentBean documentObj : list) {
					try {
						setDocumentContent(documentObj);
					} catch (IOException e) {
						
					}
				}
				
				return list;
			}
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getAll
	
	public List<String> getAllBeanIds(DocumentSearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "";
			hql += "select id from " + getBeanName() + " OBJ where "; 
			if (criteria.isFilterByLastSyncedTime())
				hql += "OBJ.updatedOn > :updatedOn and ";
			hql += HQL_CONDITION_EXCLUDE_DELETED;
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}		
	} // .end of getAll
	
	public DocumentBean getBeanById(DocumentSearchCriteria criteria) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(criteria))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "";
			hql += "from " + getBeanName() + " OBJ where ";
			hql += "OBJ.id = :id and ";
			if (criteria.isFilterByLastSyncedTime())
				hql += "OBJ.updatedOn > :updatedOn and ";
			hql += HQL_CONDITION_EXCLUDE_DELETED;
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("id", criteria.getDocumentId());		
			if (criteria.isFilterByLastSyncedTime())
				query.setTimestamp("updatedOn", new Date(criteria.getLastSyncedTime()));
			
			List<DocumentBean> list = query.list();
			if (list.size() == 0) 
				return null;  
			else 
			{
				DocumentBean documentObj = list.get(0);
				try {
					setDocumentContent(documentObj);
				} catch (IOException e) {
					
				}
				return documentObj;
			}
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeanById
	
	private void setDocumentContent(DocumentBean documentObj)
		throws DAOException, IOException
	{  
		try 
		{
			if (isNullOrEmpty(documentObj))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			if (documentObj==null || documentObj.getDocUrl()==null || documentObj.getDocUrl().length()==0)
				return;
			
			URL url = new URL( documentObj.getDocUrl() );
			InputStream in = url.openStream();
			
			String docContent = IOUtils.toString( in );
			documentObj.setDocContent(docContent);
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of setDocumentContent
}  
