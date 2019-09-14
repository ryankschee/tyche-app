package com.tychees.core.service;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.document.DocumentBean;
import com.tychees.core.bean.document.DocumentPropertiesBean;
import com.tychees.core.bean.place.PlaceDocumentBean;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.document.DocumentDAO;
import com.tychees.core.dao.document.DocumentPropertiesDAO;
import com.tychees.core.dao.place.PlaceDocumentDAO;
import com.tychees.core.service.criteria.DocumentSearchCriteria;
  
@Service("documentService")  
public class DocumentService 
{ 
	@Autowired  
	DocumentDAO documentDao;  
	@Autowired  
	DocumentPropertiesDAO documentPropertiesDao;
	@Autowired  
	PlaceDocumentDAO placeDocumentDao;  
	
	private final static Logger LOGGER = Logger.getLogger(DocumentService.class.getName());
   
	//--------------------------------------------------------------------------
	
	@Transactional  
	public List<DocumentBean> getAll(DocumentSearchCriteria criteria) 
	{  
		try 
		{
			if (criteria.isFullBean() == true)
				return fillBeans( documentDao.getAll( criteria ) );  
			else
				return documentDao.getAll( criteria );
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<DocumentBean>();
		}
	} // .end of getAll

	@Transactional  
	public List<String> getAllDocumentIds(DocumentSearchCriteria criteria) 
	{  
		try 
		{
			List<String> documentIdList = documentDao.getAllBeanIds( criteria );  
			return documentIdList;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<String>();
		}
	} // .end of getDocumentById
	  
	@Transactional  
	public DocumentBean getDocumentById(DocumentSearchCriteria criteria) 
	{  
		try 
		{
			DocumentBean documentObj = documentDao.getBeanById( criteria );  
			return fillBean(documentObj);
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return null;
		}
	} // .end of getDocumentById

	@Transactional  
	public List<DocumentBean> getDocumentListByIds(String ids) 
	{  
		try 
		{
			List<DocumentBean> documentList = new ArrayList<DocumentBean>();
			StringTokenizer tokenizer = new StringTokenizer(ids, ", ");
			while (tokenizer.hasMoreTokens()) {
				documentList.add( documentDao.getBeanById(tokenizer.nextToken()) );
			}	  
			return fillBeans(documentList);
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return new ArrayList<DocumentBean>();
		}
	} // .end of getCustomerListByIds
	
	@Transactional  
	public List<DocumentBean> getDocumentsByPlaceId(String placeId) 
	{  
		try 
		{
			List<DocumentBean> documentList = new ArrayList<DocumentBean>();
			List<PlaceDocumentBean> placeDocumentList = placeDocumentDao.getBeansByPlaceId(placeId);
			
			for (PlaceDocumentBean placeDocumentObj : placeDocumentList) 
			{
				DocumentBean documentObj = documentDao.getBeanById( placeDocumentObj.getDocumentId() );
				
				if (documentObj != null)
				{
					fillBean(documentObj);
					documentList.add(documentObj);
				}
			}
			
			return documentList;
		}
		catch (DAOException e)
		{
			LOGGER.error(e.getMessage());
			return new ArrayList<DocumentBean>();
		}
	} // .end of getDocumentsByPlaceId

	@Transactional  
	public void saveOrUpdateDocument(DocumentBean documentObj, String userId) 
	{  
		documentDao.saveOrUpdate(documentObj, userId);  
		
		for (DocumentPropertiesBean beanObj : documentObj.propertiesList)
		{
			beanObj.setDocumentId( documentObj.getId() );
			documentPropertiesDao.saveOrUpdate( beanObj, userId );
		}
	} // .end of saveOrUpdateDocument
  
	@Transactional  
	public void deleteDocument(DocumentBean documentObj) 
	{  
		documentDao.delete(documentObj);  
	} // .end of deleteDocument
	
	//--------------------------------------------------------------------------
	
	private List<DocumentBean> fillBeans(List<DocumentBean> documentList) 
	{
		for (DocumentBean documentObj : documentList)
		{
			fillBean( documentObj );
		}
		
		return documentList;
	} // .end of fillBeans
	
	/**
	 * Full Structure of DocumentBean
	 * -----------------------------
	 * DocumentBean
	 *  |- propertiesList
	 */ 
	private DocumentBean fillBean(DocumentBean documentObj) 
	{  
		try 
		{
			if (documentObj != null)
			{
				// Set state - fullBeanLoaded
				documentObj.setFullBeanLoaded( true );
				
				documentObj.propertiesList = 
					documentPropertiesDao.getBeansByDocumentId(documentObj.getId());
			}
			
			return documentObj;
		}
		catch (DAOException e)
		{
			e.printStackTrace();
			return documentObj;
		}
	} // .end of fillBeans
}
