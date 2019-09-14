package com.tychees.core.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.channels.Channels;
import java.security.GeneralSecurityException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.storage.Storage;
import com.google.api.services.storage.StorageScopes;
import com.google.api.services.storage.model.Bucket;
/*import com.google.appengine.tools.cloudstorage.GcsFileOptions;
import com.google.appengine.tools.cloudstorage.GcsFilename;
import com.google.appengine.tools.cloudstorage.GcsInputChannel;
import com.google.appengine.tools.cloudstorage.GcsOutputChannel;
import com.google.appengine.tools.cloudstorage.GcsService;
import com.google.appengine.tools.cloudstorage.GcsServiceFactory;
*/
@Component
public class GCStorageUtil 
{
    /**Used below to determine the size of chucks to read in. Should be > 1kb and < 10MB */
  	private static final int BUFFER_SIZE = 2 * 1024 * 1024;
  	//private static GcsService gcsService;

    /** Global instance of the JSON factory. */
    private static final JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
    private static Storage storageService;
/*
  	public GcsService getGcsService() 
  	{
  		if (gcsService==null) 
  		{
  			gcsService = GcsServiceFactory.createGcsService();
  		}
  		return gcsService;
  	}
*/  	
  	/**
  	 * Expecting URI format: /gcs/bucket_name/object_name.
  	 * Parsed array: {"", "gcs", "bucket_name", "object_name"}
  	 * 
  	 * @param req
  	 * @return
  	 */
/*	public GcsFilename getFileName(HttpServletRequest req) 
	{
    	String[] splits = req.getRequestURI().split("/", 4);
    	if (!splits[0].equals("") || !splits[1].equals("gcs")) {
      		throw new IllegalArgumentException("The URL is not formed as expected. " + "Expecting /gcs/<bucket>/<object>");
    	}
    	return new GcsFilename(splits[2], splits[3]);
  	}
	*/
	/**
     * Transfer the data from the inputStream to the outputStream. Then close both streams.
     */
    private void copy(InputStream input, OutputStream output) 
    	throws IOException 
    {
    	try 
    	{
      		byte[] buffer = new byte[BUFFER_SIZE];
      		int bytesRead = input.read(buffer);
      		while (bytesRead != -1) 
      		{
        		output.write(buffer, 0, bytesRead);
        		bytesRead = input.read(buffer);
      		}
    	} 
    	finally 
    	{
      		input.close();
      		output.close();
    	}
    }
    
    private void copy(byte[] input, OutputStream output) 
    	throws IOException 
    {    	
    	try 
    	{
    		output.write(input);
    	} 
    	finally 
    	{
      		output.close();
    	}
    }
        
    /**
     * Writes the payload of the incoming post as the contents of a file to GCS.
     * If the request path is /gcs/Foo/Bar this will be interpreted as
     * a request to create a GCS file named Bar in bucket Foo.
     */
/*    public void gcsWriteFile(String bucketName, String objectName, InputStream inputStream) 
    	throws IOException
    {
    	GcsFilename fileName = new GcsFilename(bucketName, objectName);
    	    	
    	GcsOutputChannel outputChannel =
        	getGcsService().createOrReplace(fileName, GcsFileOptions.getDefaultInstance());
    	copy(inputStream, Channels.newOutputStream(outputChannel));	
    	
    	outputChannel.close();
    }
    
    public void gcsWriteFile(String bucketName, String objectName, byte[] inputStreamByteArray) 
    	throws IOException
    {
    	GcsFilename fileName = new GcsFilename(bucketName, objectName);
    	    	
    	GcsOutputChannel outputChannel =
        	getGcsService().createOrReplace(fileName, GcsFileOptions.getDefaultInstance());
    	copy(inputStreamByteArray, Channels.newOutputStream(outputChannel));	
    	
    	outputChannel.close();
    }
    
    public void gcsReadFile(String bucketName, String objectName, OutputStream outputStream) 
    	throws IOException
    {
    	GcsFilename fileName = new GcsFilename(bucketName, objectName);
    	
  		GcsInputChannel readChannel = getGcsService().openPrefetchingReadChannel(fileName, 0, BUFFER_SIZE);
  		copy(Channels.newInputStream(readChannel), outputStream);    	
    }
    */
    /**
     * Returns an authenticated Storage object used to make service calls to Cloud Storage.
     */
    private static Storage getService() 
		throws IOException, GeneralSecurityException 
    {
    	if (null == storageService) 
    	{
    		GoogleCredential credential = GoogleCredential.getApplicationDefault();
	        // Depending on the environment that provides the default credentials (e.g. Compute Engine,
	        // App Engine), the credentials may require us to specify the scopes we need explicitly.
	        // Check for this case, and inject the Bigquery scope if required.
	        if (credential.createScopedRequired()) 
	        {
	        	credential = credential.createScoped(StorageScopes.all());
	        }
        
	        HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
	        storageService = new Storage.Builder(httpTransport, JSON_FACTORY, credential)
	        					.setApplicationName("directme2208").build();
    	}
    	return storageService;
    }
    
    protected void createSubfolder(String placeId) 
    {
    	try 
    	{
			getService().buckets().insert("directme2208", new Bucket().setName(placeId)).execute();
		} 
    	catch (IOException | GeneralSecurityException e) 
    	{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}
