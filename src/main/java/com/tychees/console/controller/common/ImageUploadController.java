package com.tychees.console.controller.common;

import java.util.Calendar;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.tychees.console.controller.common.response.UploadImageResponseBody;
import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.place.PlaceImageBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.controller.RequestStatus;
import com.tychees.core.service.BillingService;
import com.tychees.core.service.CustomerService;
import com.tychees.core.service.DocumentService;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.PlaceService;
import com.tychees.core.service.UserService;

  
@RestController  
public class ImageUploadController {  
   
	private static final Logger LOGGER = Logger.getLogger(ImageUploadController.class.getName());
	
	@Autowired
	AppConstants appConstants;
	@Autowired 
	BillingService billingService;  
	@Autowired 
	DocumentService documentService;  
	@Autowired 
	CustomerService customerService;   
	@Autowired 
	InventoryService inventoryService;  
	@Autowired 
	PlaceService placeService;  
	@Autowired 
	UserService userService;
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/console/uploadImage", method = RequestMethod.POST)  
	public ResponseEntity  uploadImageHandler(
			MultipartHttpServletRequest request, 
			@RequestParam("paramSessionId") String sessionId,
			@RequestParam("paramPlaceId") String placeId,
			@RequestParam("paramImageSource") String imageSource,
			@RequestParam("paramImageWidth") String imageWidth,
			@RequestParam("paramImageHeight") String imageHeight,
			@RequestParam("file") MultipartFile fileObj) 
	{  		
		UploadImageResponseBody responseBody = new UploadImageResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		LOGGER.info("sessionId="+sessionId);
		LOGGER.info("placeId="+placeId);
		LOGGER.info("imageSource="+imageSource);
		LOGGER.info("imageWidth="+imageWidth);
		LOGGER.info("imageHeight="+imageHeight);
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
	
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( sessionId );
		if (sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			if (imageSource == appConstants.FILE_CONTROL_PLACE_IMAGE)
			{
				// Extract/Validate variables for Upload
				/*ServletFileUpload upload = new ServletFileUpload();
		    	FileItemIterator iter = upload.getItemIterator(request);
					        
		    	while (iter.hasNext()) 
		        {
		            FileItemStream item = iter.next();	            
		            InputStream content = item.openStream();
		           
		            if (item.isFormField()) 
		            {
		            	byte[] str = new byte[content.available()];
	            		content.read(str);
	            		
	            		// Check #1: If null, then skip this loop
	            		if (item.getFieldName()==null)
	            			continue;
	            		
	            		logger.info("Field Name="+item.getFieldName());
	            		logger.info("Field Value="+new String(str,"UTF8"));
		            }
		        }*/
				
				// Store image file into Google Cloud Storage
				
				// Get public link of image
				
				// Prepare and save image object into place object.
				PlaceImageBean imageObj = new PlaceImageBean();
				imageObj.setPlaceId(placeId);
			    imageObj.setName("");    
			    imageObj.setUrl("");
			    imageObj.setType("");
			    imageObj.setAltText("");
			    imageObj.setLongDesc("");
			    imageObj.setWidth(Integer.parseInt(imageWidth));
			    imageObj.setHeight(Integer.parseInt(imageHeight));
			    
			    PlaceBean placeObj = placeService.getPlaceById( placeId, true );
			    placeObj.imageList.add(imageObj);
			    
			    placeService.saveOrUpdatePlace(placeObj, sessionObj.getUserId());
			    
			    // Prepare response object
			    responseBody.status = RequestStatus.REQUEST_SUCCESS;
			}
			
			//processFile(request, response);
			
			//InventoryItemBean itemObj = inventoryService.getItemById( requestBody.itemId );
			/*
			if (!file.isEmpty()) {
				try {
					byte[] bytes = file.getBytes();

					// Creating the directory to store file
					String rootPath = System.getProperty("catalina.home");
					File dir = new File(rootPath + File.separator + "tmpFiles");
					if (!dir.exists())
						dir.mkdirs();

					// Create the file on server
					File serverFile = new File(dir.getAbsolutePath()
							+ File.separator + "image.jpg");
					BufferedOutputStream stream = new BufferedOutputStream(
							new FileOutputStream(serverFile));
					stream.write(bytes);
					stream.close();

					logger.info("Server File Location="
							+ serverFile.getAbsolutePath());

					//return "You successfully uploaded file=" + requestBody.imageName;
				} catch (Exception e) {
					//return "You failed to upload " + requestBody.imageName + " => " + e.getMessage();
				}
			} else {
				//return "You failed to upload " + requestBody.imageName
				//		+ " because the file was empty.";
			}
			*/
			
			/*
			try {
				// Prepare variables for Upload
				ServletFileUpload upload = new ServletFileUpload();
		    	FileItemIterator iter = upload.getItemIterator(request);
					        
		    	while (iter.hasNext()) 
		        {
		            FileItemStream item = iter.next();	            
		            InputStream content = item.openStream();
		           
		            if (item.isFormField()) 
		            {
		            	byte[] str = new byte[content.available()];
	            		content.read(str);
	            		
	            		// Check #1: If null, then skip this loop
	            		if (item.getFieldName()==null)
	            			continue;
	            		
	            		logger.info("Field Name="+item.getFieldName());
	            		logger.info("Field Value="+new String(str,"UTF8"));
		            }
		        }
		    	
				responseBody.status = RequestStatus.REQUEST_SUCCESS;
			}
			catch (FileUploadException e) {
				e.printStackTrace();
			}
			catch (IOException e) {
				e.printStackTrace();
			}
			catch (Exception e) {
				e.printStackTrace();
			}*/
		}
		
		// TASKS: Post
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		//return responseBody;
		return new ResponseEntity<>("{}", HttpStatus.OK);
	} // .end of uploadItemImageHandler
	
	/*
	private void processFile(HttpServletRequest request, HttpServletResponse response) 
	{
		Storage storage = StorageOptions.getDefaultInstance().getService();
		
		final Part filePart = request.getPart("file");
	    final String fileName = filePart.getSubmittedFileName();
	
	    // Modify access list to allow all users with link to read file
	    List<Acl> acls = new ArrayList<>();
	    acls.add(Acl.of(Acl.User.ofAllUsers(), Acl.Role.READER));
	    // the inputstream is closed by default, so we don't need to close it here
	    Blob blob =
	        storage.create(
	            BlobInfo.newBuilder("", fileName).setAcl(acls).build(),
	            filePart.getInputStream());
	
	    // return the public download link
	    response.getWriter().print(blob.getMediaLink());
	}*/
}  