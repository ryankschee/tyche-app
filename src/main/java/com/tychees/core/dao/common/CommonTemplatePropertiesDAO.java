package com.tychees.core.dao.common;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.common.CommonTemplatePropertiesBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class CommonTemplatePropertiesDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return CommonTemplatePropertiesBean.class.getSimpleName();
	}
  
	public CommonTemplatePropertiesBean getBeanById(String id) 
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
			
			List<CommonTemplatePropertiesBean> list = query.list();
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
	
	public List<CommonTemplatePropertiesBean> getBeansByTemplateId(String templateId)
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(templateId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.templateId = :templateId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("templateId", templateId);		
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByTemplateId
}  
