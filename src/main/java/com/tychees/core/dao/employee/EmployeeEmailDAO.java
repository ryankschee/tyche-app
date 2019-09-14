package com.tychees.core.dao.employee;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.employee.EmployeeEmailBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class EmployeeEmailDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return EmployeeEmailBean.class.getSimpleName();
	}
    
	public EmployeeEmailBean getBeanById(String id) 
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
			
			List<EmployeeEmailBean> list = query.list();
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
	
	public List<EmployeeEmailBean> getBeansByEmployeeId(String employeeId)
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(employeeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.employeeId = :employeeId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED;
	
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("employeeId", employeeId);		
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByEmployeeId
}  
