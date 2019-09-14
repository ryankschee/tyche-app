package com.tychees.core.dao.inventory;

import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.tychees.core.bean.inventory.InventoryItemPropertiesBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;

@Repository  
public class InventoryItemPropertiesDAO 
	extends AbstractDAO {  
  
	@Override
	public String getBeanName() 
	{
		return InventoryItemPropertiesBean.class.getSimpleName();
	}
  
	public InventoryItemPropertiesBean getBeanById(String id) 
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
			
			List<InventoryItemPropertiesBean> list = query.list();
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
	
	public List<InventoryItemPropertiesBean> getBeansByItemId(String itemId) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(itemId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			String hql = "from " + getBeanName() + " OBJ where " + 
						 "OBJ.itemId = :itemId and " + 
						 HQL_CONDITION_EXCLUDE_DELETED + " " +
						 "ORDER BY OBJ.propSeqno ASC";
						 
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql );
			query.setParameter("itemId", itemId);	
			
			return query.list();
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getBeansByItemId
}  
