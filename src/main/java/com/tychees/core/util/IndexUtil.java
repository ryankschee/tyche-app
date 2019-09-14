package com.tychees.core.util;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.stereotype.Component;

import com.tychees.core.bean.BeanSuperClass;
import com.tychees.core.bean.index.IndexMasterBean;
import com.tychees.core.bean.index.IndexTermBean;

@Component
public class IndexUtil 
{
    // User ID for bean indexing purpose
    public final static String USER_SYSTEM_INDEXER = "SYSTEM_INDEXER";
    
    
    public IndexMasterBean newIndexMasterObj(String placeId)
    {
        IndexMasterBean indexObj = new IndexMasterBean();
        indexObj.setId( UUID.randomUUID().toString() );
        indexObj.setPlaceId(placeId);
        indexObj.setCreatedBy(USER_SYSTEM_INDEXER);
        indexObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
        
        return indexObj;
    } // .end of newIndexMasterObj
    
    public IndexMasterBean newIndexMasterObj(String placeId, BeanSuperClass beanObj)
    {
        IndexMasterBean indexObj = newIndexMasterObj(placeId);
        indexObj.setBeanId( beanObj.getId() );
		indexObj.setLastIndexedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
			
        return indexObj;
    } // .end of newIndexMasterObj
    
    public IndexTermBean newIndexTermObj()
    {
        IndexTermBean indexObj = new IndexTermBean();
        indexObj.setId( UUID.randomUUID().toString() );
        indexObj.setCreatedBy(USER_SYSTEM_INDEXER);
        indexObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
        
        return indexObj;
    } // .end of newIndexTermObj
    
    public boolean isTermIndexable(String term)
    {
        if (term==null)
            return false;
        if ("".equals(term.trim()))
            return false;
            
        return true;
    } // .end of isTermIndexable
}