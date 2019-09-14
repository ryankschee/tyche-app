package com.tychees.core.dao.document;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.document.DocumentPropertiesBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class DocumentPropertiesDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return DocumentPropertiesBean.class.getSimpleName();
	}
  
	public DocumentPropertiesBean getBeanById(String id) 
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
			
			List<DocumentPropertiesBean> list = query.list();
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
	
	public List<DocumentPropertiesBean> getBeansByDocumentId(String documentId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(documentId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.documentId = :documentId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED + " " +
						 "ORDER BY OBJ.propSeqno ASC";
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("documentId", documentId);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByDocumentId  
}  
