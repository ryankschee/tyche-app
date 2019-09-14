package com.tychees.core.dao.place;

import java.util.List;


import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
import com.tychees.core.bean.place.PlaceDocumentTemplateComponentBean;
import com.tychees.core.constants.ExceptionConstants;;

@Repository  
public class PlaceDocumentTemplateComponentDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return PlaceDocumentTemplateComponentBean.class.getSimpleName();
	}
  
	public PlaceDocumentTemplateComponentBean getBeanById(String id) 
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
			
			List<PlaceDocumentTemplateComponentBean> list = query.list();
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
	
	public List<PlaceDocumentTemplateComponentBean> getBeansByTemplateId(String templateId)
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(templateId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.placeDocumentTemplateId = :templateId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("templateId", templateId);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByPlaceId
}  
