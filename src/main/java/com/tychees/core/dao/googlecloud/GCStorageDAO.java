package com.tychees.core.dao.googlecloud;

import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.api.services.storage.model.ObjectAccessControl;
//import com.google.appengine.tools.cloudstorage.GcsFilename;
import com.tychees.core.util.GCStorageUtil;

@Repository  
public class GCStorageDAO {  
  
	// Class Logger
	private static final Logger LOGGER = Logger.getLogger(GCStorageDAO.class.getName());
	
	@Autowired  
	GCStorageUtil gcStorageUtil;  
	
	public final static String APP_NAME = "directme2208";
	public final static String FILE_PATH_GC_STORAGE_ROOT = "bucket_place";
	public final static String FILE_SEPARATOR = "/";
	public final static String MODULE_BILLING_DOCUMENT = "module_billing_document";
	public final static String MODULE_INVENTORY_ITEM_IMAGE = "module_inventory_item_image";
	public final static String MODULE_PLACE_COVER_IMAGE = "module_place_cover_image";
	public final static String MODULE_PLACE_OFFER_IMAGE = "module_place_offer_image";
	public final static String MODULE_PLACE_IMAGE = "module_place_image";
	
	// Object Access Contro: Publicly Accessible
	public final static ObjectAccessControl ACL_READ_PUBLIC = 
		new ObjectAccessControl().setEntity("allUsers").setRole("READER");
	
    public boolean saveFileToBucket(String fullBucketName, String fileName, byte[] fileByteArray) 
    {
    	/*try
    	{
    		gcStorageUtil.gcsWriteFile(fullBucketName, fileName, fileByteArray);
        	return true;
    	}
    	catch (IOException e) 
    	{
    		LOGGER.warn("Unable to write file (" + fileName + ") to bucket (" + fullBucketName + ".");
    		return false;
    	}   */return false; 	
    } // .end of saveFileToBucket
    
    public boolean deleteFileFromBucket(String fullBucketName, String objectName)
	{
    	/*try 
    	{
	    	// Construct bucket name and object name
			GcsFilename fileName = new GcsFilename(fullBucketName, objectName);
			
			// Delete file from GCS
			return gcStorageUtil.getGcsService().delete(fileName);
    	}
    	catch (IOException e) 
    	{
    		LOGGER.warn("Unable to delete object (" + objectName + ") to bucket (" + fullBucketName + ".");
    		return false;
    	}   */ return false; 	
	} // .end of deleteFileFromBucket
	
	
	public String getFullObjectPath(String bucketName, String objectName) 
	{
    	return "http://storage.googleapis.com/" + bucketName + "/" + objectName;
	}
    
	public String getFullBucketName(String moduleName, String placeId) 
	{
		if (MODULE_BILLING_DOCUMENT.equals(moduleName)) {
			return FILE_PATH_GC_STORAGE_ROOT + "/" + placeId + "/billing/document";
		} else
    	if (MODULE_INVENTORY_ITEM_IMAGE.equals(moduleName)) {
    		return FILE_PATH_GC_STORAGE_ROOT + "/" + placeId + "/inventory";
    	} else
    	if (MODULE_PLACE_COVER_IMAGE.equals(moduleName)) {
    		return FILE_PATH_GC_STORAGE_ROOT + "/" + placeId + "/place/cover_story";
    	} else
    	if (MODULE_PLACE_OFFER_IMAGE.equals(moduleName)) {
    		return FILE_PATH_GC_STORAGE_ROOT + "/" + placeId + "/place/offer";
    	} else
    	if (MODULE_PLACE_IMAGE.equals(moduleName)) {
    		return FILE_PATH_GC_STORAGE_ROOT + "/" + placeId + "/images";
    	} else {
    		return null;
    	}
	}	
}  
