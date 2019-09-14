package com.tychees.core.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonFactory;
import com.google.api.client.json.jackson.JacksonFactory;
import com.google.api.services.storage.model.ObjectAccessControl;
import com.google.cloud.storage.Storage;
import com.tychees.core.bean.document.DocumentBean;
import com.tychees.core.bean.document.DocumentPropertiesBean;
import com.tychees.core.dao.document.DocumentDAO;
import com.tychees.core.dao.document.DocumentPropertiesDAO;
import com.tychees.core.dao.googlecloud.GCStorageDAO;
  
@Service("gcStorageService")  
public class GCStorageService {  
  
	@Autowired  
	GCStorageDAO gcStorageDao;  
	/*
    public final static String FILE_PATH_GOOGLE_CLOUD_STORAGE_ROOT				= "bucket_place";
	public final static String FILE_SEPARATOR									= "/";
	public final static String MODULE_BILLING_DOCUMENT							= "module_billing_document";
	public final static String MODULE_INVENTORY_ITEM_IMAGE						= "module_inventory_item_image";
	public final static String MODULE_PLACE_COVER_IMAGE 						= "module_place_cover_image";
	public final static String MODULE_PLACE_OFFER_IMAGE 						= "module_place_offer_image";
	
	public final static ObjectAccessControl ACL_READ_PUBLIC 					= new ObjectAccessControl().setEntity("allUsers").setRole("READER");
	
	// Global instance of the JSON factory.
	private static final JsonFactory JSON_FACTORY								= JacksonFactory.getDefaultInstance();
	// [START get_service]
	private static Map<String, Storage> storageServiceMap						= new HashMap<String, Storage>();
	
	//--------------------------------------------------------------------------
	
	public String getFullObjectPath(String bucketName, String objectName) 
	{
    	return "http://storage.googleapis.com/" + bucketName + "/" + objectName;
	} // .end of getFullObjectPath
    
	public String getFullBucketName(String moduleName, String placeId) 
	{
		if (MODULE_BILLING_DOCUMENT.equals(moduleName)) {
			return FILE_PATH_GOOGLE_CLOUD_STORAGE_ROOT + "/" + placeId + "/billing/document";
		} else
    	if (MODULE_INVENTORY_ITEM_IMAGE.equals(moduleName)) {
    		return FILE_PATH_GOOGLE_CLOUD_STORAGE_ROOT + "/" + placeId + "/inventory";
    	} else
    	if (MODULE_PLACE_COVER_IMAGE.equals(moduleName)) {
    		return FILE_PATH_GOOGLE_CLOUD_STORAGE_ROOT + "/" + placeId + "/place/cover_story";
    	} else
    	if (MODULE_PLACE_OFFER_IMAGE.equals(moduleName)) {
    		return FILE_PATH_GOOGLE_CLOUD_STORAGE_ROOT + "/" + placeId + "/place/offer";
    	} else {
    		return null;
    	}
	} // .end of getFullBucketName
	
    public boolean saveFileToBucket(String fullBucketName, String fileName, byte[] fileByteArray) 
    {
    	try
    	{
    		gcsWriteFile(this.getGcsService(), fullBucketName, fileName, fileByteArray);
        	return true;
    	}
    	catch (IOException e) 
    	{
    		this.getLogger().warning("Unable to write file (" + fileName + ") to bucket (" + fullBucketName + ".");
    		return false;
    	}    	
    } // .end of saveFileToBucket
    
    public boolean deleteFileFromBucket(String fullBucketName, String objectName)
	{
    	try 
    	{
	    	// Construct bucket name and object name
			GcsFilename fileName = new GcsFilename(fullBucketName, objectName);
			
			// Delete file from GCS
			return this.getGcsService().delete(fileName);
    	}
    	catch (IOException e) 
    	{
    		this.getLogger().warning("Unable to delete object (" + objectName + ") to bucket (" + fullBucketName + ".");
    		return false;
    	}    	
	} // .end of deleteFileFromBucket
	*/
	//--------------------------------------------------------------------------
	
	/**
     * Returns an authenticated Storage object used to make service calls to Cloud Storage.
     */
	/*public Storage getStorageService(String appName) 
	{		
		try {
			if (storageServiceMap==null)
				storageServiceMap = new HashMap<String, Storage>();
			
			Storage storageService = storageServiceMap.get(appName);
			
			if (null == storageService) {
				GoogleCredential credential = GoogleCredential.getApplicationDefault();
			    // Depending on the environment that provides the default credentials (e.g. Compute Engine,
			    // App Engine), the credentials may require us to specify the scopes we need explicitly.
			    // Check for this case, and inject the Bigquery scope if required.
			    if (credential.createScopedRequired()) {
			        credential = credential.createScoped(StorageScopes.all());
			    }
			    HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
			    storageService = new Storage.Builder(httpTransport, JSON_FACTORY, credential)
			    	.setApplicationName(appName).build();
			    
			    storageServiceMap.put(appName, storageService);
		    }
		    
			return storageService;
		}
		catch (IOException e) {
			throw new ServiceException("TEST", e.getMessage());
		}
		catch (GeneralSecurityException e) {
			throw new ServiceException("TEST", e.getMessage());
		}
	}
	*/
	/**
	 * Fetch a list of the objects within the given bucket.
	 *
	 * @param bucketName the name of the bucket to list.
	 * @return a list of the contents of the specified bucket.
	 */
	/*public List<StorageObject> listBucket(String appName, String bucketName)
	{
		try {
		    Storage client = getStorageService(appName);
		    Storage.Objects.List listRequest = client.objects().list(bucketName);
	
		    List<StorageObject> results = new ArrayList<StorageObject>();
		    Objects objects;
	
		    // Iterate through each page of results, and add them to our results list.
		    do {
		      objects = listRequest.execute();
		      // Add the items in this page of results to the list we'll return.
		      results.addAll(objects.getItems());
	
		      // Get the next page, in the next iteration of this loop.
		      listRequest.setPageToken(objects.getNextPageToken());
		    } while (null != objects.getNextPageToken());
	
		    return results;
		}
		catch (IOException e) {
    		this.getLogger().warning("Unable to access object in bucket (" + bucketName + ".");
			throw new ServiceException("TEST", e.getMessage());
		}
	}*/

	/**
	 * Fetches the metadata for the given bucket.
	 *
	 * @param bucketName the name of the bucket to get metadata about.
	 * @return a Bucket containing the bucket's metadata.
	 */
	/*public Bucket getBucket(String appName, String bucketName) 
	{
		try {
		    Storage client = getStorageService(appName);
	
		    Storage.Buckets.Get bucketRequest = client.buckets().get(bucketName);
		    // Fetch the full set of the bucket's properties (e.g. include the ACLs in the response)
		    bucketRequest.setProjection("full");
		    return bucketRequest.execute();
		}
		catch (IOException e) {
			throw new ServiceException("TEST", e.getMessage());
		}
	}*/
		
	/**
	 * Uploads data to an object in a bucket, as publicly accessible (read).
	 *
	 * @param appName the name of the application.
	 * @param bucketName the name of the bucket to create the object in.
	 * @param objectName the name of the destination object.
	 * @param contentType the MIME type of the data.
	 * @param stream the data - for instance, you can use a FileInputStream to upload a file.
	 */
	/*public void uploadStreamAsPublicReadAccess(String appName, String bucketName, String objectName, String contentType, InputStream stream)
	{
		List<ObjectAccessControl> aclList = Arrays.asList(ACL_READ_PUBLIC);
		uploadStream(appName, bucketName, objectName, contentType, aclList, stream);
	}*/
	
	/**
	 * Uploads data to an object in a bucket.
	 *
	 * @param appName the name of the application.
	 * @param bucketName the name of the bucket to create the object in.
	 * @param objectName the name of the destination object.
	 * @param contentType the MIME type of the data.
	 * @param aclList the list of ObjectAccessControl objects.
	 * @param stream the data - for instance, you can use a FileInputStream to upload a file.
	 */
	/*public void uploadStream(String appName, String bucketName, String objectName, String contentType, List<ObjectAccessControl> aclList, InputStream stream)
	{
		try {
		    InputStreamContent contentStream = new InputStreamContent(contentType, stream);
		    StorageObject objectMetadata = new StorageObject()
		        // Set the destination object name
		        .setName(objectName)
		        // Set the access control list to publicly read-only
		        .setAcl(aclList);
	
		    // Do the insert
		    Storage client = getStorageService(appName);
		    Storage.Objects.Insert insertRequest = client.objects().insert(
		        bucketName, objectMetadata, contentStream);
	
		    insertRequest.execute();
		}
		catch (IOException e) {
			throw new ServiceException("TEST", e.getMessage());
		}
	}*/
	
	/**
	 * Deletes an object in a bucket.
	 *
	 * @param path the path to the object to delete.
	 * @param bucketName the bucket the object is contained in.
	 */
	/*public void deleteObject(String path, String appName, String bucketName)
	{
		try {
		    Storage client = getStorageService(appName);
		    client.objects().delete(bucketName, path).execute();
		}
		catch (IOException e) {
			throw new ServiceException("TEST", e.getMessage());
		}
	}*/
}
