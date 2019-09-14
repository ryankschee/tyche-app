package com.tychees.core.dao._patch;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.patch.PatchCustomerBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class PatchCustomerDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return PatchCustomerBean.class.getSimpleName();
	}
  
	public List<PatchCustomerBean> getAll() 
			throws DAOException
		{  
			try 
			{		
				String hql = "from " + getBeanName() + " OBJ";
					
				Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
				
				return query.list();
			} 
			catch (Exception e) 
			{
				throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
			}
		} // .end of getBeansByUserId
	
	public PatchCustomerBean getBeanById(String id) 
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
			
			List<PatchCustomerBean> list = query.list();
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
}  
