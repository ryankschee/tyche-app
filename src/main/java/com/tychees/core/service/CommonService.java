package com.tychees.core.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.common.CommonTemplateBean;
import com.tychees.core.bean.common.CommonTemplatePropertiesBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.common.CommonTemplateDAO;
import com.tychees.core.dao.common.CommonTemplatePropertiesDAO;
  
@Service("commonService")  
public class CommonService {  
  
	@Autowired  
	CommonTemplateDAO commonTemplateDao; 
	@Autowired  
	CommonTemplatePropertiesDAO commonTemplatePropertiesDao; 
	
	//--------------------------------------------------------------------------
	
	@Transactional  
	public CommonTemplateBean getTemplateById(String id) 
	{  
		try 
		{
			CommonTemplateBean templateObj = commonTemplateDao.getBeanById(id);  
			return fillBean( templateObj );
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getTemplateById
	
	@Transactional  
	public List<CommonTemplateBean> getTemplatesByParentId(String parentId) 
	{  
		try 
		{
			List<CommonTemplateBean> templateList = commonTemplateDao.getBeansByParentId(parentId);  		
			return fillBeans( templateList );
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<CommonTemplateBean>();
		}
	} // .end of getTemplatesByParentId
	
	@Transactional  
	public void saveOrUpdateTemplate(CommonTemplateBean templateObj, String userId) 
	{  
		commonTemplateDao.saveOrUpdate(templateObj, userId);  
		
		for (CommonTemplatePropertiesBean beanObj : templateObj.propertiesList) 
		{
			beanObj.setTemplateId( templateObj.getId() );
			commonTemplatePropertiesDao.saveOrUpdate( beanObj, userId );
		}
	} // .end of saveOrUpdateTemplate
  
	@Transactional  
	public void deleteTemplate(CommonTemplateBean templateObj) 
	{  
		commonTemplateDao.delete(templateObj);  
	} // .end of deleteTemplate
	
	//--------------------------------------------------------------------------
	
	private List<CommonTemplateBean> fillBeans(List<CommonTemplateBean> templateList) 
	{
		for (CommonTemplateBean templateObj : templateList)
		{
			fillBean( templateObj );
		}
		
		return templateList;
	} // .end of fillBeans
	
	/**
	 * Full Structure of CommonTemplateBean
	 * -----------------------------
	 * CommonTemplateBean
	 *  |- propertiesList
	 */ 
	private CommonTemplateBean fillBean(CommonTemplateBean templateObj) 
	{  
		try
		{
			if (templateObj != null) 
			{
				templateObj.propertiesList = 
					commonTemplatePropertiesDao.getBeansByTemplateId( templateObj.getId() );
			}
			
			return templateObj;
		}
		catch (DAOException e) 
		{
			e.printStackTrace();
			return templateObj;
		}
	} // .end of fillBean
}
