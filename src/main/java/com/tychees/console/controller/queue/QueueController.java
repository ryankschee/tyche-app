package com.tychees.console.controller.queue;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.TreeMap;
import java.util.UUID;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.bind.annotation.RequestMethod;  
import org.springframework.web.bind.annotation.RestController;

import com.tychees.core.bean.batch.BatchRequestBean;
import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.billing.BillingLineBean;
import com.tychees.core.bean.billing.BillingPaymentBean;
import com.tychees.core.bean.billing.BillingWorkflowBean;
import com.tychees.core.bean.billing.BillingWorkflowEventBean;
import com.tychees.core.bean.customer.CustomerAddressBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.customer.CustomerContactBean;
import com.tychees.core.bean.customer.CustomerEmailBean;
import com.tychees.core.bean.customer.CustomerPropertiesBean;
import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.inventory.InventoryCategoryPropertiesBean;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.InventoryItemPropertiesBean;
import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.bean.patch.PatchCustomerBean;
import com.tychees.core.bean.patch.PatchMeasureBean;
import com.tychees.core.bean.patch.PatchMeasureBillingBean;
import com.tychees.core.bean.patch.PatchPaymentBean;
import com.tychees.core.bean.place.PlaceNotificationBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.constants.BillingConstants;
import com.tychees.core.constants.InventoryConstants;
import com.tychees.core.constants.ModuleConstants;
import com.tychees.core.controller.RequestStatus;
import com.tychees.core.service.BatchService;
import com.tychees.core.service.BillingService;
import com.tychees.core.service.CustomerService;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.PatchService;
import com.tychees.core.service.PlaceService;
import com.tychees.core.service.UserService;
import com.tychees.core.service.criteria.BillingSearchCriteria;
import com.tychees.core.service.criteria.CustomerSearchCriteria;
import com.tychees.core.service.criteria.InventorySearchCriteria;
import com.tychees.core.util.BeanUtil;
import com.tychees.core.util.BillingUtil;
import com.tychees.core.util.CustomerUtil;
import com.tychees.core.util.InventoryUtil;
import com.tychees.console.controller.queue.request.PatchBillingRequestBody;
import com.tychees.console.controller.queue.request.PatchCustomerRequestBody;
import com.tychees.console.controller.queue.request.PatchRequestBody;
import com.tychees.console.controller.queue.request.QueueBatchDownloadCustomerAddressesRequestBody;
import com.tychees.console.controller.queue.request.QueueBatchDownloadCustomerContactsRequestBody;
import com.tychees.console.controller.queue.request.QueueBatchDownloadCustomerEmailsRequestBody;
import com.tychees.console.controller.queue.request.QueueBatchDownloadCustomersRequestBody;
import com.tychees.console.controller.queue.request.QueueBatchDownloadItemsRequestBody;
import com.tychees.console.controller.queue.response.PatchBillingResponseBody;
import com.tychees.console.controller.queue.response.PatchCustomerResponseBody;
import com.tychees.console.controller.queue.response.PatchResponseBody;
import com.tychees.console.controller.queue.response.QueueBatchDownloadCustomerAddressesResponseBody;
import com.tychees.console.controller.queue.response.QueueBatchDownloadCustomerContactsResponseBody;
import com.tychees.console.controller.queue.response.QueueBatchDownloadCustomerEmailsResponseBody;
import com.tychees.console.controller.queue.response.QueueBatchDownloadCustomersResponseBody;
import com.tychees.console.controller.queue.response.QueueBatchDownloadItemsResponseBody;

@RestController  
public class QueueController {  
   
	@Autowired
	AppConstants appConstants;
	@Autowired
	BillingConstants billingConstants;
	@Autowired
	ModuleConstants moduleConstants;
	@Autowired 
	BatchService batchService;  
	@Autowired 
	BillingService billingService;  
	@Autowired 
	CustomerService customerService; 
	@Autowired 
	InventoryConstants inventoryConstants; 
	@Autowired 
	InventoryService inventoryService; 
	@Autowired 
	PlaceService placeService; 
	@Autowired 
	UserService userService;  
	@Autowired 
	PatchService patchService;  
	@Autowired
	BeanUtil beanUtil;
	@Autowired
	BillingUtil billingUtil;
	@Autowired
	CustomerUtil customerUtil;
	@Autowired
	InventoryUtil inventoryUtil;

	private final static Logger LOGGER = Logger.getLogger(QueueController.class.getName());
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/queue/batchDownloadItemsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadItemsResponseBody batchDownloadItemsTest(HttpServletRequest request, @RequestBody QueueBatchDownloadItemsRequestBody requestBody) 
	{  
		return batchDownloadItems(request, requestBody);
	} // .end of batchDownloadItemsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/queue/batchDownloadItems", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadItemsResponseBody batchDownloadItems(HttpServletRequest request, @RequestBody QueueBatchDownloadItemsRequestBody requestBody) 
	{  
		QueueBatchDownloadItemsResponseBody responseBody = new QueueBatchDownloadItemsResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		LOGGER.info("BEGIN");
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			// Create batch request 
			BatchRequestBean requestObj = batchService.newBatchRequest(requestBody.placeId, sessionObj.getUserId());
			requestObj.setActionId("DOWNLOAD_ITEMS");
			requestObj.setActionName("Download Items");
			requestObj.setActionDesc("Download full set of items from category ()");
			requestObj.setActionStatus("RUNNING");
			requestObj.setStartedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
			batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
						
			InventorySearchCriteria criteria = new InventorySearchCriteria( requestBody.placeId );
			criteria.setFullBean( true );
			criteria.setLoadComponentItems( requestBody.loadComponentItems );
			criteria.setFilterByLastSyncedTime( false );
			criteria.setLastSyncedTime( requestBody.lastSyncedTime.longValue() );
			criteria.setCategoryId( requestBody.categoryId );
			criteria.setFilterByGroupName( requestBody.filterByGroupName );
			criteria.setGroupName( requestBody.groupName );
			
			List<InventoryItemBean> itemList = inventoryService.getItemsByCategoryId( criteria );
			InventoryCategoryBean categoryObj = inventoryService.getCategoryById(requestBody.categoryId, true);

			LOGGER.info("categoryObj = " + categoryObj.getName());
			LOGGER.info("itemList = " + itemList.size());
			
			if (itemList.size() == 0)
			{
				// Update status
				requestObj.setActionStatus("COMPLETED");
				requestObj.setActionStatusDesc("Processed Items: " + itemList.size());
				requestObj.setEndedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
			}
			else
			{				
			    // This data needs to be written (Object[])
			    Map<String, Object[]> rowList = new TreeMap<String, Object[]>();
			    rowList.put("1", new Object[] {"INSTRUCTION: (1) Insert record from row	5 onward. (2) DO NOT Change Row 1-4."});
			    rowList.put("2", new Object[] {"Category ID:", categoryObj.getId(), "Category Name:", categoryObj.getName(), "Item Type:", categoryObj.getItemType()});
			    // Prepare table header (column names & type)
			    List<Object> headerColumnNameList = new ArrayList<Object>();
			    List<Object> headerColumnTypeList = new ArrayList<Object>();
			    headerColumnNameList.add("Action");
			    headerColumnNameList.add("ID");
			    headerColumnNameList.add("Group Name");
			    headerColumnNameList.add("Item Name");
			    headerColumnNameList.add("Keywords");
			    headerColumnNameList.add("POS Visible");
			    headerColumnNameList.add("PWS Visible");
			    
			    headerColumnTypeList.add("DEL/UPD/NO");
			    headerColumnTypeList.add("Text");
			    headerColumnTypeList.add("Text");
			    headerColumnTypeList.add("Text");
			    headerColumnTypeList.add("Text with Comma");
			    headerColumnTypeList.add("Y/N");
			    headerColumnTypeList.add("Y/N");
			    
			    if (inventoryConstants.ITEM_TYPE_PRODUCT.equals(categoryObj.getItemType()) ||
			        inventoryConstants.ITEM_TYPE_SERVICE.equals(categoryObj.getItemType()) ||
			        inventoryConstants.ITEM_TYPE_EVENT.equals(categoryObj.getItemType()) ||
			        inventoryConstants.ITEM_TYPE_RAW.equals(categoryObj.getItemType()))
			    {
			    	headerColumnNameList.add("Measurement Unit");
					headerColumnNameList.add("Quantity Optional");
					headerColumnNameList.add("Minimum Quantity");
					headerColumnNameList.add("Quantity");
					headerColumnNameList.add("Unit Cost");
					headerColumnNameList.add("Unit Price");
					
			    	headerColumnTypeList.add("Number");
					headerColumnTypeList.add("Y/N");
					headerColumnTypeList.add("Number");
					headerColumnTypeList.add("Number");
					headerColumnTypeList.add("Number");
					headerColumnTypeList.add("Number");
			    }
			    else
			    {
			    	headerColumnNameList.add("Tax Inclusive");
					headerColumnNameList.add("In Percentage");
					headerColumnNameList.add("In Amount");
					headerColumnNameList.add("Percentage");
					headerColumnNameList.add("Amount");
					
			    	headerColumnTypeList.add("Y/N");
					headerColumnTypeList.add("Y/N");
					headerColumnTypeList.add("Y/N");
					headerColumnTypeList.add("Number");
					headerColumnTypeList.add("Number");
			    }
			    
			    for (InventoryCategoryPropertiesBean categoryPropObj : categoryObj.propertiesList)
			    {
			    	headerColumnNameList.add(categoryPropObj.getPropName());
			    	
			    	if (inventoryConstants.PROP_TYPE_TEXT.equals(categoryPropObj.getPropType()))
    					headerColumnTypeList.add("Text");
    				if (inventoryConstants.PROP_TYPE_NUMBER.equals(categoryPropObj.getPropType()))
    					headerColumnTypeList.add("Number");
    				if (inventoryConstants.PROP_TYPE_BOOLEAN.equals(categoryPropObj.getPropType()))
    					headerColumnTypeList.add("Y/N");
    				if (inventoryConstants.PROP_TYPE_LIST.equals(categoryPropObj.getPropType()))
    					headerColumnTypeList.add("Text with Comma");
			    }
			    
			    rowList.put("3", headerColumnNameList.toArray());
			    rowList.put("4", headerColumnTypeList.toArray());
			    
			    int rowCount = 5;
			    for (InventoryItemBean itemObj : itemList)
			    {
			    	List<Object> cellList = new ArrayList<Object>();
			    	cellList.add("NO");
			    	cellList.add(itemObj.getId());
			    	cellList.add(itemObj.getGroupName());
			    	cellList.add(itemObj.getName());
			    	cellList.add(itemObj.getLabels());
			    	cellList.add(itemObj.isPosVisible() ? "Y" : "N");
			    	cellList.add(itemObj.isPwsVisible() ? "Y" : "N");
			    	
			    	if (inventoryConstants.ITEM_TYPE_PRODUCT.equals(categoryObj.getItemType()) ||
				        inventoryConstants.ITEM_TYPE_SERVICE.equals(categoryObj.getItemType()) ||
				        inventoryConstants.ITEM_TYPE_EVENT.equals(categoryObj.getItemType()) ||
				        inventoryConstants.ITEM_TYPE_RAW.equals(categoryObj.getItemType()))
				    {
				    	cellList.add(itemObj.getMeasurementUnit());
						cellList.add(itemObj.isQuantityOptional() ? "Y" : "N");
						cellList.add(itemObj.getMinimumQuantity());
						cellList.add(itemObj.getQuantity());
						cellList.add(itemObj.getUnitCost());
						cellList.add(itemObj.getUnitPrice());
				    }
				    else
				    {
				    	cellList.add(itemObj.isTaxInclusive() ? "Y" : "N");
						cellList.add(itemObj.isTaxDiscountInPercentage() ? "Y" : "N");
						cellList.add(itemObj.isTaxDiscountInAmount() ? "Y" : "N");
						cellList.add(itemObj.getTaxDiscountPercentage());
						cellList.add(itemObj.getTaxDiscountAmount());	
				    }

			    	for (InventoryCategoryPropertiesBean categoryPropObj : categoryObj.propertiesList)
			    	{
			    		for (InventoryItemPropertiesBean itemPropObj : itemObj.propertiesList)
			    		{
			    			if (categoryPropObj.getId().equals(itemPropObj.getCategoryPropertiesId()))
			    			{
			    				if (inventoryConstants.PROP_TYPE_TEXT.equals(itemPropObj.getPropType()))
			    					cellList.add(itemPropObj.getPropValue());
			    				if (inventoryConstants.PROP_TYPE_NUMBER.equals(itemPropObj.getPropType()))
			    					cellList.add(itemPropObj.getPropValue());
			    				if (inventoryConstants.PROP_TYPE_BOOLEAN.equals(itemPropObj.getPropType()))
			    					cellList.add(beanUtil.getBooleanValue(itemPropObj.getPropValue()) ? "Y" : "N");
			    				if (inventoryConstants.PROP_TYPE_LIST.equals(itemPropObj.getPropType()))
			    					cellList.add(itemPropObj.getPropValue());
			    			}
			    		}
			    	}
			    	
			    	// Add to current row
			    	rowList.put(String.valueOf(rowCount), cellList.toArray());
			    	// Go to next row
			    	rowCount++;
			    } // .end of FOR-LOOP
			    
			    //Create blank workbook
			    XSSFWorkbook workbook = new XSSFWorkbook(); 
			    //Create a blank sheet
			    XSSFSheet spreadsheet = workbook.createSheet("ITEMS");			    
			    //Create row object
			    XSSFRow row;
			    
			    for (int i = 1 ; i < rowCount ; i++) {
			    	// Create a new row within the sheet
			    	row = spreadsheet.createRow(i-1);
			    	// Get array of record in this row
			    	Object [] objectArray = rowList.get(String.valueOf(i));
			    	
			        int cellIndex = 0;
			        for (Object obj : objectArray)
			        {
			            Cell cell = row.createCell(cellIndex++);
			            if (obj instanceof Double)
			            	cell.setCellValue(((Double)obj).doubleValue());
			            else
			            	cell.setCellValue(String.valueOf(obj));
			        }
			    }
			    
			    // Write to byte array
			    ByteArrayOutputStream bos = new ByteArrayOutputStream();
				try {
				    workbook.write(bos);
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						workbook.close();
						bos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				
				byte[] bytes = bos.toByteArray();				
				String base64 = Base64.encodeBase64String(bytes);
				
				// Update Batch Request
				requestObj.setActionStatus("COMPLETED");
				requestObj.setActionStatusDesc("Processed Items: " + itemList.size());
				requestObj.setEndedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				requestObj.setFileName(categoryObj.getName() + ".xlsx");
				requestObj.setBase64(base64);
				batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
				
				// Create notification
				PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
				notificationObj.setName("Batch Download Ready");
				notificationObj.setDescription("Batch file (" + categoryObj.getName() + ") is ready for download.");
				notificationObj.setStatus("COMPLETED");
				notificationObj.setRequestId(requestObj.getId());
				notificationObj.setDownloadAvailable(true);
				notificationObj.setNotificationRead(false);
				notificationObj.setNotificationReadOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));				
				placeService.saveOrUpdatePlaceNotification(notificationObj, sessionObj.getUserId());
			}
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadItems
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/queue/batchDownloadCustomersTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadCustomersResponseBody batchDownloadCustomersTest(HttpServletRequest request, @RequestBody QueueBatchDownloadCustomersRequestBody requestBody) 
	{  
		return batchDownloadCustomers(request, requestBody);
	} // .end of batchDownloadCustomersTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/queue/batchDownloadCustomers", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadCustomersResponseBody batchDownloadCustomers(HttpServletRequest request, @RequestBody QueueBatchDownloadCustomersRequestBody requestBody) 
	{  
		QueueBatchDownloadCustomersResponseBody responseBody = new QueueBatchDownloadCustomersResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		LOGGER.info("BEGIN");
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			LOGGER.info("Download Customer");
			
			String pattern = "dd/MM/yyyy";
			SimpleDateFormat dateFormatter = new SimpleDateFormat(pattern);
			
			List<String> customerTypeList = new ArrayList<String>();
			StringTokenizer tokenizer = new StringTokenizer(requestBody.customerTypeList, ",");
			while (tokenizer.hasMoreTokens()) {
				String customerType = tokenizer.nextToken().trim();
				if (!"".equals(customerType)) {
					customerTypeList.add(customerType.trim());
				}
			}
			
			for (String customerType : customerTypeList) {
				// Create batch request 			
				BatchRequestBean requestObj = batchService.newBatchRequest(requestBody.placeId, sessionObj.getUserId());
				requestObj.setActionId("DOWNLOAD_CUSTOMERS");
				requestObj.setActionName("Download Customers");
				requestObj.setActionDesc("Download full set of customers (type:" + requestBody.customerTypeList + ")");
				requestObj.setActionStatus("RUNNING");
				requestObj.setStartedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
							
				CustomerSearchCriteria criteria = new CustomerSearchCriteria( requestBody.placeId );
				criteria.setFullBean( true );	
				if ("ANY".equals(customerType) || "".equals(customerType)) {
					criteria.setFilterByCustomerType(false);					
				} else {
					criteria.setFilterByCustomerType(true);
					criteria.setCustomerType(customerType);
				}
				
				List<CustomerBean> customerList = customerService.getCustomersByPlaceId( criteria );
	
				LOGGER.info("customer type: " + customerType + ", size: " + customerList.size());
				
				if (customerList.size() == 0)
				{
					// Update status
					requestObj.setActionStatus("COMPLETED");
					requestObj.setActionStatusDesc("Processed Customers: " + customerList.size());
					requestObj.setEndedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
					batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
				}
				else
				{				
				    // This data needs to be written (Object[])
				    Map<String, Object[]> rowList = new TreeMap<String, Object[]>();
				    rowList.put("1", new Object[] {"INSTRUCTION: (1) Insert record from row	5 onward. (2) DO NOT Change Row 1-4."});
				    rowList.put("2", new Object[] {"Customer Type:", customerType});
				    // Prepare table header (column names & type)
				    List<Object> headerColumnNameList = new ArrayList<Object>();
				    List<Object> headerColumnTypeList = new ArrayList<Object>();
				    headerColumnNameList.add("Action");
				    headerColumnNameList.add("ID");
				    headerColumnNameList.add("Customer No");
				    headerColumnNameList.add("First Name");
				    headerColumnNameList.add("Last Name");
				    headerColumnNameList.add("Gender");
				    headerColumnNameList.add("DOB");
				    headerColumnNameList.add("Description");
				    
				    headerColumnTypeList.add("DEL/UPD/NO");
				    headerColumnTypeList.add("Text");
				    headerColumnTypeList.add("Text");
				    headerColumnTypeList.add("Text");
				    headerColumnTypeList.add("Text");
				    headerColumnTypeList.add("M/F");
				    headerColumnTypeList.add("Date (dd/MM/yyyy)");
				    headerColumnTypeList.add("Text");
	
				    if (customerList.size() > 0) {
				    	for (CustomerPropertiesBean propObj : customerList.get(0).propertiesList) {
				    		headerColumnNameList.add(propObj.getPropName());
				    		
				    		if (inventoryConstants.PROP_TYPE_TEXT.equals(propObj.getPropType()))
		    					headerColumnTypeList.add("Text");
		    				if (inventoryConstants.PROP_TYPE_NUMBER.equals(propObj.getPropType()))
		    					headerColumnTypeList.add("Number");
		    				if (inventoryConstants.PROP_TYPE_BOOLEAN.equals(propObj.getPropType()))
		    					headerColumnTypeList.add("Y/N");
		    				if (inventoryConstants.PROP_TYPE_LIST.equals(propObj.getPropType()))
		    					headerColumnTypeList.add("Text with Comma");
				    	}
				    }
				    
				    rowList.put("3", headerColumnNameList.toArray());
				    rowList.put("4", headerColumnTypeList.toArray());
				    
				    int rowCount = 5;
				    for (CustomerBean customerObj : customerList)
				    {
				    	List<Object> cellList = new ArrayList<Object>();
				    	cellList.add("NO");
				    	cellList.add(customerObj.getId()==null ? "" : customerObj.getId());
				    	cellList.add(customerObj.getCustomerNo()==null ? "" : customerObj.getCustomerNo());
				    	cellList.add(customerObj.getFirstName()==null ? "" : customerObj.getFirstName());
				    	cellList.add(customerObj.getLastName()==null ? "" : customerObj.getLastName());
				    	cellList.add(customerObj.getGender()==null ? "" : customerObj.getGender());
				    	cellList.add(customerObj.getDob()==null ? "" : dateFormatter.format(customerObj.getDob()));
				    	cellList.add(customerObj.getDescription()==null ? "" : customerObj.getDescription());
				    	
				    	for (CustomerPropertiesBean propObj : customerObj.propertiesList) {
						    if (inventoryConstants.PROP_TYPE_TEXT.equals(propObj.getPropType()))
		    					cellList.add(propObj.getPropValue()==null ? "" : propObj.getPropValue());
		    				if (inventoryConstants.PROP_TYPE_NUMBER.equals(propObj.getPropType()))
		    					cellList.add(propObj.getPropValue()==null ? "" : propObj.getPropValue());
		    				if (inventoryConstants.PROP_TYPE_BOOLEAN.equals(propObj.getPropType()))
		    					cellList.add(beanUtil.getBooleanValue(propObj.getPropValue()) ? "Y" : "N");
		    				if (inventoryConstants.PROP_TYPE_LIST.equals(propObj.getPropType()))
		    					cellList.add(propObj.getPropValue()==null ? "" : propObj.getPropValue());
				    	}
				    	
				    	// Add to current row
				    	rowList.put(String.valueOf(rowCount), cellList.toArray());
				    	// Go to next row
				    	rowCount++;
				    } // .end of FOR-LOOP
				    
				    //Create blank workbook
				    XSSFWorkbook workbook = new XSSFWorkbook(); 
				    //Create a blank sheet
				    XSSFSheet spreadsheet = workbook.createSheet("CUSTOMERS");			    
				    //Create row object
				    XSSFRow row;
				    
				    for (int i = 1 ; i < rowCount ; i++) {
				    	// Create a new row within the sheet
				    	row = spreadsheet.createRow(i-1);
				    	// Get array of record in this row
				    	Object [] objectArray = rowList.get(String.valueOf(i));
				    	
				    	if (objectArray != null) {
					        int cellIndex = 0;
					        for (Object obj : objectArray)
					        {
					            Cell cell = row.createCell(cellIndex++);
					            if (obj instanceof Double)
					            	cell.setCellValue(((Double)obj).doubleValue());
					            else
					            	cell.setCellValue(String.valueOf(obj));
					        }
				    	}
				    }
				    
				    // Write to byte array
				    ByteArrayOutputStream bos = new ByteArrayOutputStream();
					try {
					    workbook.write(bos);
					} catch (IOException e) {
						e.printStackTrace();
					} finally {
						try {
							workbook.close();
							bos.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					
					byte[] bytes = bos.toByteArray();				
					String base64 = Base64.encodeBase64String(bytes);
					
					// Update Batch Request
					requestObj.setActionStatus("COMPLETED");
					requestObj.setActionStatusDesc("Processed Items: " + customerList.size());
					requestObj.setEndedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
					requestObj.setFileName("customer (" + customerType + ").xlsx");
					requestObj.setBase64(base64);
					batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
					
					// Create notification
					PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
					notificationObj.setName("Batch Download Ready");
					notificationObj.setDescription("Batch file (Customer, " + customerType + ") is ready for download.");
					notificationObj.setStatus("COMPLETED");
					notificationObj.setRequestId(requestObj.getId());
					notificationObj.setDownloadAvailable(true);
					notificationObj.setNotificationRead(false);
					notificationObj.setNotificationReadOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));				
					placeService.saveOrUpdatePlaceNotification(notificationObj, sessionObj.getUserId());
				}
			}
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadCustomers
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/queue/batchDownloadCustomerContactsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadCustomerContactsResponseBody batchDownloadCustomerContactsTest(HttpServletRequest request, @RequestBody QueueBatchDownloadCustomerContactsRequestBody requestBody) 
	{  
		return batchDownloadCustomerContacts(request, requestBody);
	} // .end of batchDownloadCustomerContactsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/queue/batchDownloadCustomerContacts", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadCustomerContactsResponseBody batchDownloadCustomerContacts(HttpServletRequest request, @RequestBody QueueBatchDownloadCustomerContactsRequestBody requestBody) 
	{  
		QueueBatchDownloadCustomerContactsResponseBody responseBody = new QueueBatchDownloadCustomerContactsResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			LOGGER.info("Download Customer Contact");
			
			List<String> customerTypeList = new ArrayList<String>();
			StringTokenizer tokenizer = new StringTokenizer(requestBody.customerTypeList, ",");
			while (tokenizer.hasMoreTokens()) {
				String customerType = tokenizer.nextToken().trim();
				if (!"".equals(customerType)) {
					customerTypeList.add(customerType.trim());
				}
			}
			
			int rowCount = 5;
			for (String customerType : customerTypeList) {
				// Create batch request 			
				BatchRequestBean requestObj = batchService.newBatchRequest(requestBody.placeId, sessionObj.getUserId());
				requestObj.setActionId("DOWNLOAD_CUSTOMER_CONTACTS");
				requestObj.setActionName("Download Customer contacts");
				requestObj.setActionDesc("Download full set of customer contacts (type:" + requestBody.customerTypeList + ")");
				requestObj.setActionStatus("RUNNING");
				requestObj.setStartedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
							
				CustomerSearchCriteria criteria = new CustomerSearchCriteria( requestBody.placeId );
				criteria.setFullBean( false );	
				if ("ANY".equals(customerType) || "".equals(customerType)) {
					criteria.setFilterByCustomerType(false);					
				} else {
					criteria.setFilterByCustomerType(true);
					criteria.setCustomerType(customerType);
				}
				
				// This data needs to be written (Object[])
			    Map<String, Object[]> rowList = new TreeMap<String, Object[]>();
			    rowList.put("1", new Object[] {"INSTRUCTION: (1) Insert record from row	5 onward. (2) DO NOT Change Row 1-4."});
			    rowList.put("2", new Object[] {"Customer Type:", customerType});

			    // Get all customers with match type
				List<CustomerBean> customerList = customerService.getCustomersByPlaceId( criteria );
				LOGGER.info("customer type: " + customerType + ", size: " + customerList.size());

				for (CustomerBean customerObj : customerList) {
					List<CustomerContactBean> contactList = customerService.getContactsByCustomer(customerObj.getId());
					LOGGER.info("contact list size: " + contactList.size());
					
					if (contactList.size() > 0)
					{
					    // Prepare table header (column names & type)
					    List<Object> headerColumnNameList = new ArrayList<Object>();
					    List<Object> headerColumnTypeList = new ArrayList<Object>();
					    headerColumnNameList.add("Action");
					    headerColumnNameList.add("ID");
					    headerColumnNameList.add("Customer ID");
					    headerColumnNameList.add("Customer Name");
					    headerColumnNameList.add("Type");
					    headerColumnNameList.add("Country Code");
					    headerColumnNameList.add("Area Code");
					    headerColumnNameList.add("Number");
					    headerColumnNameList.add("Extension");
					    headerColumnNameList.add("Default Contact");
					    
					    headerColumnTypeList.add("DEL/UPD/NO");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Home/Mobile/Office");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Y/N");
		
					    rowList.put("3", headerColumnNameList.toArray());
					    rowList.put("4", headerColumnTypeList.toArray());
					    
					    String customerName = customerObj.getFirstName()==null ? "" : customerObj.getFirstName().trim();
					    customerName += customerObj.getLastName()==null ? "" : customerObj.getLastName().trim();
					    customerName = customerName.trim();
					    
					    for (CustomerContactBean contactObj : contactList)
					    {
					    	List<Object> cellList = new ArrayList<Object>();
					    	cellList.add("NO");
					    	cellList.add(contactObj.getId());
					    	cellList.add(customerObj.getId());
					    	cellList.add(customerName);
					    	cellList.add(contactObj.getType()==null ? "" : contactObj.getType());
					    	cellList.add(contactObj.getCountryCode());
					    	cellList.add(contactObj.getAreaCode());
					    	cellList.add(contactObj.getPhoneNumber());
					    	cellList.add(contactObj.getExtension());
					    	cellList.add(contactObj.isDefaultContact() ? "Y" : "N");
					    	
					    	// Add to current row
					    	rowList.put(String.valueOf(rowCount), cellList.toArray());
					    	// Go to next row
					    	rowCount++;
					    } // .end of FOR-LOOP
					}
				}
			    
			    //Create blank workbook
			    XSSFWorkbook workbook = new XSSFWorkbook(); 
			    //Create a blank sheet
			    XSSFSheet spreadsheet = workbook.createSheet("CUSTOMER CONTACTS");			    
			    //Create row object
			    XSSFRow row;
			    
			    for (int i = 1 ; i < rowCount ; i++) {
			    	// Create a new row within the sheet
			    	row = spreadsheet.createRow(i-1);
			    	// Get array of record in this row
			    	Object [] objectArray = rowList.get(String.valueOf(i));
			    	
			    	if (objectArray != null) {
				        int cellIndex = 0;
				        for (Object obj : objectArray)
				        {
				            Cell cell = row.createCell(cellIndex++);
				            if (obj instanceof Double)
				            	cell.setCellValue(((Double)obj).doubleValue());
				            else
				            	cell.setCellValue(String.valueOf(obj));
				        }
			    	}
			    }
			    
			    // Write to byte array
			    ByteArrayOutputStream bos = new ByteArrayOutputStream();
				try {
				    workbook.write(bos);
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						workbook.close();
						bos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				
				byte[] bytes = bos.toByteArray();				
				String base64 = Base64.encodeBase64String(bytes);
				
				// Update Batch Request
				requestObj.setActionStatus("COMPLETED");
				requestObj.setActionStatusDesc("Processed Contacts: " + customerList.size());
				requestObj.setEndedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				requestObj.setFileName("customer_contact (" + customerType + ").xlsx");
				requestObj.setBase64(base64);
				batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
				
				// Create notification
				PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
				notificationObj.setName("Batch Download Ready");
				notificationObj.setDescription("Batch file (Customer Contact, " + customerType + ") is ready for download.");
				notificationObj.setStatus("COMPLETED");
				notificationObj.setRequestId(requestObj.getId());
				notificationObj.setDownloadAvailable(true);
				notificationObj.setNotificationRead(false);
				notificationObj.setNotificationReadOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));				
				placeService.saveOrUpdatePlaceNotification(notificationObj, sessionObj.getUserId());
			}
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadCustomerContacts
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/queue/batchDownloadCustomerEmailsTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadCustomerEmailsResponseBody batchDownloadCustomerEmailsTest(HttpServletRequest request, @RequestBody QueueBatchDownloadCustomerEmailsRequestBody requestBody) 
	{  
		return batchDownloadCustomerEmails(request, requestBody);
	} // .end of batchDownloadCustomerEmailsTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/queue/batchDownloadCustomerEmails", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadCustomerEmailsResponseBody batchDownloadCustomerEmails(HttpServletRequest request, @RequestBody QueueBatchDownloadCustomerEmailsRequestBody requestBody) 
	{  
		QueueBatchDownloadCustomerEmailsResponseBody responseBody = new QueueBatchDownloadCustomerEmailsResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			LOGGER.info("Download Customer Email");

			List<String> customerTypeList = new ArrayList<String>();
			StringTokenizer tokenizer = new StringTokenizer(requestBody.customerTypeList, ",");
			while (tokenizer.hasMoreTokens()) {
				String customerType = tokenizer.nextToken().trim();
				if (!"".equals(customerType)) {
					customerTypeList.add(customerType.trim());
				}
			}
			
			int rowCount = 5;
			for (String customerType : customerTypeList) {
				// Create batch request 			
				BatchRequestBean requestObj = batchService.newBatchRequest(requestBody.placeId, sessionObj.getUserId());
				requestObj.setActionId("DOWNLOAD_CUSTOMER_EMAILS");
				requestObj.setActionName("Download Customer Emails");
				requestObj.setActionDesc("Download full set of customer emails (type:" + requestBody.customerTypeList + ")");
				requestObj.setActionStatus("RUNNING");
				requestObj.setStartedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
							
				CustomerSearchCriteria criteria = new CustomerSearchCriteria( requestBody.placeId );
				criteria.setFullBean( false );	
				if ("ANY".equals(customerType) || "".equals(customerType)) {
					criteria.setFilterByCustomerType(false);					
				} else {
					criteria.setFilterByCustomerType(true);
					criteria.setCustomerType(customerType);
				}
				
				// This data needs to be written (Object[])
			    Map<String, Object[]> rowList = new TreeMap<String, Object[]>();
			    rowList.put("1", new Object[] {"INSTRUCTION: (1) Insert record from row	5 onward. (2) DO NOT Change Row 1-4."});
			    rowList.put("2", new Object[] {"Customer Type:", customerType});

			    // Get all customers with match type
				List<CustomerBean> customerList = customerService.getCustomersByPlaceId( criteria );
				LOGGER.info("customer type: " + customerType + ", size: " + customerList.size());

				for (CustomerBean customerObj : customerList) {
					List<CustomerEmailBean> emailList = customerService.getEmailsByCustomer(customerObj.getId());
					LOGGER.info("email list size: " + emailList.size());
					
					if (emailList.size() > 0)
					{
					    // Prepare table header (column names & type)
					    List<Object> headerColumnNameList = new ArrayList<Object>();
					    List<Object> headerColumnTypeList = new ArrayList<Object>();
					    headerColumnNameList.add("Action");
					    headerColumnNameList.add("ID");
					    headerColumnNameList.add("Customer ID");
					    headerColumnNameList.add("Customer Name");
					    headerColumnNameList.add("Type");
					    headerColumnNameList.add("Email");
					    headerColumnNameList.add("Default Email");
					    
					    headerColumnTypeList.add("DEL/UPD/NO");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Personal/Office");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Y/N");
		
					    rowList.put("3", headerColumnNameList.toArray());
					    rowList.put("4", headerColumnTypeList.toArray());
					    
					    String customerName = customerObj.getFirstName()==null ? "" : customerObj.getFirstName().trim();
					    customerName += customerObj.getLastName()==null ? "" : customerObj.getLastName().trim();
					    customerName = customerName.trim();
					    
					    for (CustomerEmailBean emailObj : emailList)
					    {
					    	List<Object> cellList = new ArrayList<Object>();
					    	cellList.add("NO");
					    	cellList.add(emailObj.getId());
					    	cellList.add(customerObj.getId());
					    	cellList.add(customerName);
					    	cellList.add(emailObj.getType()==null ? "" : emailObj.getType());
					    	cellList.add(emailObj.getEmailAddress());
					    	cellList.add(emailObj.isDefaultEmail() ? "Y" : "N");
					    	
					    	// Add to current row
					    	rowList.put(String.valueOf(rowCount), cellList.toArray());
					    	// Go to next row
					    	rowCount++;
					    } // .end of FOR-LOOP
					}
				}
			    
			    //Create blank workbook
			    XSSFWorkbook workbook = new XSSFWorkbook(); 
			    //Create a blank sheet
			    XSSFSheet spreadsheet = workbook.createSheet("CUSTOMER EMAILS");			    
			    //Create row object
			    XSSFRow row;
			    
			    for (int i = 1 ; i < rowCount ; i++) {
			    	// Create a new row within the sheet
			    	row = spreadsheet.createRow(i-1);
			    	// Get array of record in this row
			    	Object [] objectArray = rowList.get(String.valueOf(i));
			    	
			    	if (objectArray != null) {
				        int cellIndex = 0;
				        for (Object obj : objectArray)
				        {
				            Cell cell = row.createCell(cellIndex++);
				            if (obj instanceof Double)
				            	cell.setCellValue(((Double)obj).doubleValue());
				            else
				            	cell.setCellValue(String.valueOf(obj));
				        }
			    	}
			    }
			    
			    // Write to byte array
			    ByteArrayOutputStream bos = new ByteArrayOutputStream();
				try {
				    workbook.write(bos);
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						workbook.close();
						bos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				
				byte[] bytes = bos.toByteArray();				
				String base64 = Base64.encodeBase64String(bytes);
				
				// Update Batch Request
				requestObj.setActionStatus("COMPLETED");
				requestObj.setActionStatusDesc("Processed Emails: " + customerList.size());
				requestObj.setEndedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				requestObj.setFileName("customer_email (" + customerType + ").xlsx");
				requestObj.setBase64(base64);
				batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
				
				// Create notification
				PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
				notificationObj.setName("Batch Download Ready");
				notificationObj.setDescription("Batch file (Customer Email, " + customerType + ") is ready for download.");
				notificationObj.setStatus("COMPLETED");
				notificationObj.setRequestId(requestObj.getId());
				notificationObj.setDownloadAvailable(true);
				notificationObj.setNotificationRead(false);
				notificationObj.setNotificationReadOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));				
				placeService.saveOrUpdatePlaceNotification(notificationObj, sessionObj.getUserId());
			}
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadCustomerEmails
	
	//--------------------------------------------------------------------------
	
	@RequestMapping(value = "/queue/batchDownloadCustomerAddressesTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadCustomerAddressesResponseBody batchDownloadCustomerAddressesTest(HttpServletRequest request, @RequestBody QueueBatchDownloadCustomerAddressesRequestBody requestBody) 
	{  
		return batchDownloadCustomerAddresses(request, requestBody);
	} // .end of batchDownloadCustomerAddressesTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/queue/batchDownloadCustomerAddresses", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public QueueBatchDownloadCustomerAddressesResponseBody batchDownloadCustomerAddresses(HttpServletRequest request, @RequestBody QueueBatchDownloadCustomerAddressesRequestBody requestBody) 
	{  
		QueueBatchDownloadCustomerAddressesResponseBody responseBody = new QueueBatchDownloadCustomerAddressesResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre
		long startTime = Calendar.getInstance().getTimeInMillis();
		// Validate Session
		UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
	    if (sessionObj==null || sessionObj.isActive()==false)
		{
			responseBody.status = RequestStatus.INVALID_SESSION;
		}
		else
		{
			LOGGER.info("Download Customer Address");

			List<String> customerTypeList = new ArrayList<String>();
			StringTokenizer tokenizer = new StringTokenizer(requestBody.customerTypeList, ",");
			while (tokenizer.hasMoreTokens()) {
				String customerType = tokenizer.nextToken().trim();
				if (!"".equals(customerType)) {
					customerTypeList.add(customerType.trim());
				}
			}
			
			int rowCount = 5;
			for (String customerType : customerTypeList) {
				// Create batch request 			
				BatchRequestBean requestObj = batchService.newBatchRequest(requestBody.placeId, sessionObj.getUserId());
				requestObj.setActionId("DOWNLOAD_CUSTOMER ADDRESSES");
				requestObj.setActionName("Download Customer Addresses");
				requestObj.setActionDesc("Download full set of customer addresses (type:" + requestBody.customerTypeList + ")");
				requestObj.setActionStatus("RUNNING");
				requestObj.setStartedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
							
				CustomerSearchCriteria criteria = new CustomerSearchCriteria( requestBody.placeId );
				criteria.setFullBean( false );	
				if ("ANY".equals(customerType) || "".equals(customerType)) {
					criteria.setFilterByCustomerType(false);					
				} else {
					criteria.setFilterByCustomerType(true);
					criteria.setCustomerType(customerType);
				}
				
				// This data needs to be written (Object[])
			    Map<String, Object[]> rowList = new TreeMap<String, Object[]>();
			    rowList.put("1", new Object[] {"INSTRUCTION: (1) Insert record from row	5 onward. (2) DO NOT Change Row 1-4."});
			    rowList.put("2", new Object[] {"Customer Type:", customerType});

			    // Get all customers with match type
				List<CustomerBean> customerList = customerService.getCustomersByPlaceId( criteria );
				LOGGER.info("customer type: " + customerType + ", size: " + customerList.size());

				for (CustomerBean customerObj : customerList) {
					List<CustomerAddressBean> addressesList = customerService.getAddressesByCustomer(customerObj.getId());
					LOGGER.info("address list size: " + addressesList.size());
					
					if (addressesList.size() > 0)
					{
					    // Prepare table header (column names & type)
					    List<Object> headerColumnNameList = new ArrayList<Object>();
					    List<Object> headerColumnTypeList = new ArrayList<Object>();
					    headerColumnNameList.add("Action");
					    headerColumnNameList.add("ID");
					    headerColumnNameList.add("Customer ID");
					    headerColumnNameList.add("Customer Name");
					    headerColumnNameList.add("Type");
					    headerColumnNameList.add("Attention To");
					    headerColumnNameList.add("Street Line 1");
					    headerColumnNameList.add("Street Line 2");
					    headerColumnNameList.add("Street Line 3");
					    headerColumnNameList.add("Postal Code");
					    headerColumnNameList.add("City");
					    headerColumnNameList.add("State");
					    headerColumnNameList.add("Country");
					    headerColumnNameList.add("Default Address");
					    
					    headerColumnTypeList.add("DEL/UPD/NO");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Home/Office");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Text");
					    headerColumnTypeList.add("Y/N");
		
					    rowList.put("3", headerColumnNameList.toArray());
					    rowList.put("4", headerColumnTypeList.toArray());
					    
					    String customerName = customerObj.getFirstName()==null ? "" : customerObj.getFirstName().trim();
					    customerName += customerObj.getLastName()==null ? "" : customerObj.getLastName().trim();
					    customerName = customerName.trim();
					    
					    for (CustomerAddressBean addressObj : addressesList)
					    {
					    	List<Object> cellList = new ArrayList<Object>();
					    	cellList.add("NO");
					    	cellList.add(addressObj.getId());
					    	cellList.add(customerObj.getId());
					    	cellList.add(customerName);
					    	cellList.add(addressObj.getType()==null ? "" : addressObj.getType());
					    	cellList.add(addressObj.getAttentionTo());
					    	cellList.add(addressObj.getStreetLine1());
					    	cellList.add(addressObj.getStreetLine2());
					    	cellList.add(addressObj.getStreetLine3());
					    	cellList.add(addressObj.getPostalCode());
					    	cellList.add(addressObj.getCity());
					    	cellList.add(addressObj.getState());
					    	cellList.add(addressObj.getCountry());
					    	cellList.add(addressObj.isDefaultAddress() ? "Y" : "N");
					    	
					    	// Add to current row
					    	rowList.put(String.valueOf(rowCount), cellList.toArray());
					    	// Go to next row
					    	rowCount++;
					    } // .end of FOR-LOOP
					}
				}
			    
			    //Create blank workbook
			    XSSFWorkbook workbook = new XSSFWorkbook(); 
			    //Create a blank sheet
			    XSSFSheet spreadsheet = workbook.createSheet("CUSTOMER ADDRESSES");			    
			    //Create row object
			    XSSFRow row;
			    
			    for (int i = 1 ; i < rowCount ; i++) {
			    	// Create a new row within the sheet
			    	row = spreadsheet.createRow(i-1);
			    	// Get array of record in this row
			    	Object [] objectArray = rowList.get(String.valueOf(i));
			    	
			    	if (objectArray != null) {
				        int cellIndex = 0;
				        for (Object obj : objectArray)
				        {
				            Cell cell = row.createCell(cellIndex++);
				            if (obj instanceof Double)
				            	cell.setCellValue(((Double)obj).doubleValue());
				            else
				            	cell.setCellValue(String.valueOf(obj));
				        }
			    	}
			    }
			    
			    // Write to byte array
			    ByteArrayOutputStream bos = new ByteArrayOutputStream();
				try {
				    workbook.write(bos);
				} catch (IOException e) {
					e.printStackTrace();
				} finally {
					try {
						workbook.close();
						bos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				
				byte[] bytes = bos.toByteArray();				
				String base64 = Base64.encodeBase64String(bytes);
				
				// Update Batch Request
				requestObj.setActionStatus("COMPLETED");
				requestObj.setActionStatusDesc("Processed Addresses: " + customerList.size());
				requestObj.setEndedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				requestObj.setFileName("customer_address (" + customerType + ").xlsx");
				requestObj.setBase64(base64);
				batchService.saveOrUpdateRequest(requestObj, sessionObj.getUserId());
				
				// Create notification
				PlaceNotificationBean notificationObj = placeService.newNotification(requestBody.placeId, sessionObj.getUserId());
				notificationObj.setName("Batch Download Ready");
				notificationObj.setDescription("Batch file (Customer Address, " + customerType + ") is ready for download.");
				notificationObj.setStatus("COMPLETED");
				notificationObj.setRequestId(requestObj.getId());
				notificationObj.setDownloadAvailable(true);
				notificationObj.setNotificationRead(false);
				notificationObj.setNotificationReadOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));				
				placeService.saveOrUpdatePlaceNotification(notificationObj, sessionObj.getUserId());
			}
			
			responseBody.status = RequestStatus.REQUEST_SUCCESS;
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of batchDownloadCustomerAddresses
	
	//--------------------------------------------------------------------------	
	
	@RequestMapping(value = "/queue/patchCustomerTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchCustomerResponseBody patchCustomerTest(HttpServletRequest request, @RequestBody PatchCustomerRequestBody requestBody) 
	{  
		return patchCustomer(request, requestBody);
	} // .end of patchCustomerTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/queue/patchCustomer", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchCustomerResponseBody patchCustomer(HttpServletRequest request, @RequestBody PatchCustomerRequestBody requestBody) 
	{  
		PatchCustomerResponseBody responseBody = new PatchCustomerResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre	
		LOGGER.info("BEGIN");
		long startTime = Calendar.getInstance().getTimeInMillis();	
		
		List<PatchCustomerBean> patchCustomerList = patchService.getAllCustomers();
		for (PatchCustomerBean patchCustomerObj : patchCustomerList) {
			
			CustomerBean newCustomerObj = new CustomerBean();
			newCustomerObj.setId(patchCustomerObj.getId());
			newCustomerObj.setCustomerNo(newCustomerObj.getId());
			newCustomerObj.setPlaceId("burlingtontailorbsc");
			newCustomerObj.setUserId("ryanchee");
			newCustomerObj.setFirstName(patchCustomerObj.getName());
			newCustomerObj.setDob(patchCustomerObj.getDob()==null ? null : new Date(patchCustomerObj.getDob().getTime()));
			newCustomerObj.setLastBillingId(getSafeString(patchCustomerObj.getLastorderid(), "-"));
			newCustomerObj.setLastBillingNo(getSafeString(patchCustomerObj.getLastorderid(), "-"));
			newCustomerObj.setDescription(getSafeString(patchCustomerObj.getRelationship(), null));
			newCustomerObj.setRemarks(getSafeString(patchCustomerObj.getRemarks(), null));
			newCustomerObj.setCreatedBy("ryanchee");
			newCustomerObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
			
			if (patchCustomerObj.getHousephone() != null && !"".equals(patchCustomerObj.getHousephone().trim())) {
				
				StringTokenizer tokenizer = new StringTokenizer(patchCustomerObj.getHousephone(), "/,|(");
				while (tokenizer.hasMoreTokens()) {
					String token = tokenizer.nextToken().trim();
					if (isValidEmailAddress(token)) {
						CustomerEmailBean emailObj = new CustomerEmailBean();
						emailObj.setCustomerId(newCustomerObj.getId());
						emailObj.setEmailAddress(token);
						emailObj.setCreatedBy("ryanchee");
						emailObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
						
						if (newCustomerObj.getEmail() == null || "".equals(newCustomerObj.getEmail().trim())) {
							newCustomerObj.setEmail(emailObj.getEmailAddress());
							emailObj.setDefaultEmail(true);
						} else {
							emailObj.setDefaultEmail(false);
						}
						
						newCustomerObj.emailList.add(emailObj);
					} else {
						String numericOnly = token.replaceAll("[^\\d.]", "").trim();
						if (numericOnly.length() > 0) {
							CustomerContactBean contactObj = new CustomerContactBean();
							contactObj.setCustomerId(newCustomerObj.getId());
							contactObj.setType(appConstants.CONTACT_TYPE_HOME);
							contactObj.setPhoneNumber(numericOnly);
							contactObj.setCreatedBy("ryanchee");
							contactObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
							
							if (newCustomerObj.getContact() == null || "".equals(newCustomerObj.getContact().trim())) {
								newCustomerObj.setContact(contactObj.getPhoneNumber());
								contactObj.setDefaultContact(true);
							} else {
								contactObj.setDefaultContact(false);
							}
							
							newCustomerObj.contactList.add(contactObj);
						}
					}
				}
			}
			
			if (patchCustomerObj.getMobilephone() != null && !"".equals(patchCustomerObj.getMobilephone().trim())) {
				StringTokenizer tokenizer = new StringTokenizer(patchCustomerObj.getMobilephone(), "/,|(");
				while (tokenizer.hasMoreTokens()) {
					String token = tokenizer.nextToken().trim();
					if (isValidEmailAddress(token)) {
						CustomerEmailBean emailObj = new CustomerEmailBean();
						emailObj.setCustomerId(newCustomerObj.getId());
						emailObj.setEmailAddress(token);
						emailObj.setCreatedBy("ryanchee");
						emailObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
						
						if (newCustomerObj.getEmail() == null || "".equals(newCustomerObj.getEmail().trim())) {
							newCustomerObj.setEmail(emailObj.getEmailAddress());
							emailObj.setDefaultEmail(true);
						} else {
							emailObj.setDefaultEmail(false);
						}
						
						newCustomerObj.emailList.add(emailObj);
					} else {
						String numericOnly = token.replaceAll("[^\\d.]", "").trim();
						if (numericOnly.length() > 0) {
							CustomerContactBean contactObj = new CustomerContactBean();
							contactObj.setCustomerId(newCustomerObj.getId());
							contactObj.setType(appConstants.CONTACT_TYPE_MOBILE);
							contactObj.setPhoneNumber(numericOnly);
							contactObj.setCreatedBy("ryanchee");
							contactObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
							
							if (newCustomerObj.getContact() == null || "".equals(newCustomerObj.getContact().trim())) {
								newCustomerObj.setContact(contactObj.getPhoneNumber());
								contactObj.setDefaultContact(true);
							} else {
								contactObj.setDefaultContact(false);
							}
							
							newCustomerObj.contactList.add(contactObj);
						}
					}
				}
			}
			
			if (patchCustomerObj.getEmail() != null && !"".equals(patchCustomerObj.getEmail().trim())) {
				StringTokenizer tokenizer = new StringTokenizer(patchCustomerObj.getEmail(), "/,|(");
				while (tokenizer.hasMoreTokens()) {
					String token = tokenizer.nextToken().trim();
					if (isValidEmailAddress(token)) {
						CustomerEmailBean emailObj = new CustomerEmailBean();
						emailObj.setCustomerId(newCustomerObj.getId());
						emailObj.setEmailAddress(token);
						emailObj.setCreatedBy("ryanchee");
						emailObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
						
						if (newCustomerObj.getEmail() == null || "".equals(newCustomerObj.getEmail().trim())) {
							newCustomerObj.setEmail(emailObj.getEmailAddress());
							emailObj.setDefaultEmail(true);
						} else {
							emailObj.setDefaultEmail(false);
						}
						
						newCustomerObj.emailList.add(emailObj);
					} else {
						String numericOnly = token.replaceAll("[^\\d.]", "").trim();
						if (numericOnly.length() > 0) {
							CustomerContactBean contactObj = new CustomerContactBean();
							contactObj.setCustomerId(newCustomerObj.getId());
							contactObj.setType(appConstants.CONTACT_TYPE_HOME);
							contactObj.setPhoneNumber(numericOnly);
							contactObj.setCreatedBy("ryanchee");
							contactObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
							
							if (newCustomerObj.getContact() == null || "".equals(newCustomerObj.getContact().trim())) {
								newCustomerObj.setContact(contactObj.getPhoneNumber());
								contactObj.setDefaultContact(true);
							} else {
								contactObj.setDefaultContact(false);
							}
							
							newCustomerObj.contactList.add(contactObj);
						}
					}
				}				
			}
			
			if (patchCustomerObj.getRemarks() != null && !"".equals(patchCustomerObj.getRemarks().trim())) {
				StringTokenizer tokenizer = new StringTokenizer(patchCustomerObj.getRemarks(), "/,|(");
				while (tokenizer.hasMoreTokens()) {
					String token = tokenizer.nextToken().trim();
					if (isValidEmailAddress(token)) {
						CustomerEmailBean emailObj = new CustomerEmailBean();
						emailObj.setCustomerId(newCustomerObj.getId());
						emailObj.setEmailAddress(token);
						emailObj.setCreatedBy("ryanchee");
						emailObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
						
						if (newCustomerObj.getEmail() == null || "".equals(newCustomerObj.getEmail().trim())) {
							newCustomerObj.setEmail(emailObj.getEmailAddress());
							emailObj.setDefaultEmail(true);
						} else {
							emailObj.setDefaultEmail(false);
						}
						
						newCustomerObj.emailList.add(emailObj);
					} else {
						String numericOnly = token.replaceAll("[^\\d.]", "").trim();
						if (numericOnly.length() > 0) {
							CustomerContactBean contactObj = new CustomerContactBean();
							contactObj.setCustomerId(newCustomerObj.getId());
							contactObj.setType(appConstants.CONTACT_TYPE_HOME);
							contactObj.setPhoneNumber(numericOnly);
							contactObj.setCreatedBy("ryanchee");
							contactObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
							
							if (newCustomerObj.getContact() == null || "".equals(newCustomerObj.getContact().trim())) {
								newCustomerObj.setContact(contactObj.getPhoneNumber());
								contactObj.setDefaultContact(true);
							} else {
								contactObj.setDefaultContact(false);
							}
							
							newCustomerObj.contactList.add(contactObj);
						}
					}
				}				
			}
			
			customerService.saveOrUpdateCustomer(newCustomerObj, "system_patch");
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of patchCustomer
	
	private boolean isValidEmailAddress(String email) {
		String regex = "^(.+)@(.+)$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(email);
		
		return matcher.matches();
	} // .end of isValidEmailAddress
	
	//--------------------------------------------------------------------------	
	
	@RequestMapping(value = "/queue/patchBillingTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchBillingResponseBody patchBillingTest(HttpServletRequest request, @RequestBody PatchBillingRequestBody requestBody) 
	{  
		return patchBilling(request, requestBody);
	} // .end of patchBillingTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/queue/patchBilling", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchBillingResponseBody patchBilling(HttpServletRequest request, @RequestBody PatchBillingRequestBody requestBody) 
	{  
		PatchBillingResponseBody responseBody = new PatchBillingResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		/*
		// TASKS: Pre	
		LOGGER.info("BEGIN");
		Calendar cutoffDate = Calendar.getInstance();
		cutoffDate.set(Calendar.YEAR, 2015);
		cutoffDate.set(Calendar.MONTH, 11);
		cutoffDate.set(Calendar.DATE, 31);
		cutoffDate.set(Calendar.HOUR, 23);
		cutoffDate.set(Calendar.MINUTE, 0);
		cutoffDate.set(Calendar.SECOND, 0);
		
		long startTime = Calendar.getInstance().getTimeInMillis();	
		
		InventoryItemBean gstItemObj = inventoryService.getItemByName("Tax Include", false, false);
		
		List<PatchMeasureBean> measureList = patchService.getAllMeasures();
		for (PatchMeasureBean measureObj : measureList) {
			
			BillingBean existingBillingObj = billingService.getBillingByBillingNo(measureObj.getId(), false);
			if (existingBillingObj != null)
				continue;
			
			BillingBean billingObj = new BillingBean();
			billingObj.setBillingNo(measureObj.getId());
			billingObj.setPlaceId("burlingtontailorbsc");
			billingObj.setCustomerId(getSafeString(measureObj.getCustomerId(), null));
			billingObj.setCustomerName(getSafeString(measureObj.getCustomerName(), null));
			billingObj.setBillingDate(measureObj.getMeasureFormDate());
			billingObj.setTotalAmount(measureObj.getMeasureFormAmount());
			billingObj.setTotalPayment(measureObj.getMeasureFormPayment());
			billingObj.setInvoiceNo(getSafeString(measureObj.getTaxInvoiceNo(), null));
			billingObj.setInvoiceDate(measureObj.getTaxInvoiceDate());
			if (measureObj.getMeasureFormDate().getTime() < cutoffDate.getTimeInMillis()) {
				billingObj.setState(billingConstants.WORKFLOW_EVENTKEY_CLOSED);
				billingObj.setStateDesc(billingConstants.WORKFLOW_EVENTDESC_CLOSED);
			} else {
				if (measureObj.getTaxInvoiceNo() == null || "".equals(measureObj.getTaxInvoiceNo().trim())) {
					billingObj.setState(billingConstants.WORKFLOW_EVENTKEY_OPEN);
					billingObj.setStateDesc(billingConstants.WORKFLOW_EVENTDESC_OPEN);
				} else {
					billingObj.setState(billingConstants.WORKFLOW_EVENTKEY_CLOSED);
					billingObj.setStateDesc(billingConstants.WORKFLOW_EVENTDESC_CLOSED);
				}
			}
			billingObj.setCreatedBy("ryanchee");
			billingObj.setCreatedOn(measureObj.getMeasureFormDate());
			
			// Billing Workflow
			BillingWorkflowBean workflowObj = new BillingWorkflowBean();
			workflowObj.setBillingId(billingObj.getId());
			workflowObj.setCreatedBy("ryanchee");
			workflowObj.setCreatedOn(measureObj.getMeasureFormDate());
			workflowObj.setModuleId(moduleConstants.MODULE_BILLING);
			billingObj.workflowList.add(workflowObj);
			
			BillingWorkflowEventBean workflowEventObj = new BillingWorkflowEventBean();
			workflowEventObj.setWorkflowId(workflowObj.getId());
			workflowEventObj.setSeqno(workflowObj.eventList.size() + 1);
			workflowEventObj.setEventKey(billingObj.getState());
			workflowEventObj.setEventTitle(billingObj.getStateDesc());
			workflowEventObj.setEventDescription(billingObj.getStateDesc());
			workflowEventObj.setTrackedOn(measureObj.getMeasureFormDate());
			workflowEventObj.setTrackedBy("ryanchee");
			workflowObj.eventList.add(workflowEventObj);
			
			List<PatchMeasureBillingBean> measureBillingList = 
					patchService.getMeasureBillingsByMeasureId(measureObj.getId());
			for (PatchMeasureBillingBean patchLineObj : measureBillingList) {
				
				// Item Line
				BillingLineBean billingLineObj = new BillingLineBean();
				billingLineObj.setBillingId(billingObj.getId());			
				billingLineObj.setRowId( UUID.randomUUID().toString() );
				billingLineObj.setItemId( patchLineObj.getApparelId() );
				billingLineObj.setItemName( patchLineObj.getApparelName() );
				billingLineObj.setItemGroupName( "" );
				billingLineObj.setItemType( "product" );
				billingLineObj.setItemUnitPrice( patchLineObj.getUnitPrice() );
				billingLineObj.setUnitPriceSource("default");
				billingLineObj.setDefaultUnitPrice( patchLineObj.getUnitPrice() );
				billingLineObj.setCustomUnitPrice(0);
				billingLineObj.setCompoundUnitPrice(0);
				billingLineObj.setMandatory(false);
				billingLineObj.setDefaultUnitPrice( patchLineObj.getUnitPrice() );
				billingLineObj.setQuantity( patchLineObj.getQuantity() );
				billingLineObj.setBillableAmount( patchLineObj.getAmount() );
				billingLineObj.setRemarks( 
					getSafeString(patchLineObj.getRemarks(), "-") + 
					 "[material: " + getSafeString(patchLineObj.getApparelMaterial(), "-") + ", " +
					 "length: " + getSafeString(patchLineObj.getApparelLength(), "-") + ", " +
					 "description: " + getSafeString(patchLineObj.getApparelDescription(), "-") + "]");
				billingLineObj.setCreatedBy("ryanchee");
				billingLineObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
				
				billingObj.lineList.add(billingLineObj);	
				
				// GST Line
				BillingLineBean gstLineObj = new BillingLineBean();
				gstLineObj.setBillingId(billingObj.getId());		
				gstLineObj.setParentLineId(billingLineObj.getId());
				
				gstLineObj.setItemId( gstItemObj.getId() );
				gstLineObj.setItemName( gstItemObj.getName() );
				gstLineObj.setItemGroupName( gstItemObj.getGroupName() );
				gstLineObj.setItemType( "tax" );
				gstLineObj.setItemUnitPrice( 0 );
				gstLineObj.setUnitPriceSource("default");
				gstLineObj.setMandatory(true);
				gstLineObj.setDefaultUnitPrice( gstItemObj.getUnitPrice() );
				gstLineObj.setQuantity( 1 );
				gstLineObj.setBillableAmount( 0 );
				gstLineObj.setRemarks( "" );
				gstLineObj.setCreatedBy("ryanchee");
				gstLineObj.setCreatedOn(measureObj.getMeasureFormDate());
								
				billingObj.lineList.add(gstLineObj);				
			}
			
			
			List<PatchPaymentBean> paymentList = 
					patchService.getPaymentsByMeasureId(measureObj.getId());
			for (PatchPaymentBean patchPaymentObj : paymentList) {
				BillingPaymentBean paymentObj = new BillingPaymentBean();
				paymentObj.setBillingId(billingObj.getId());
				paymentObj.setPayingAmount(patchPaymentObj.getAmount());
				paymentObj.setPaymentDate(patchPaymentObj.getDateTime());
				paymentObj.setMethod(patchPaymentObj.getTerms());
				paymentObj.setMethodDesc(patchPaymentObj.getType());
				paymentObj.setCreatedBy("ryanchee");
				paymentObj.setCreatedOn(patchPaymentObj.getDateTime());
				
				billingObj.paymentList.add(paymentObj);
			}
			
			// Transaction Object
			InventoryTransactionBean transactionObj = new InventoryTransactionBean();
			transactionObj.setPlaceId("burlingtontailorbsc");
			transactionObj.setType(inventoryConstants.TRANSACTION_TYPE_BILLING);
			transactionObj.setThirdPartyId(billingObj.getId());
			transactionObj.setCreatedBy("ryanchee");
			transactionObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
			
			billingService.saveOrUpdateBilling(billingObj, "system_patch");
			inventoryService.saveOrUpdateTransaction(transactionObj, "system_patch");
		}
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		*/
		return responseBody;
	} // .end of patchBilling
	
	
	private String getSafeString(String text, String textIfNull) {
		if (text == null)
			return textIfNull;
		else
			return text.trim();
	}
	
	public static String leftPad(String originalString, int length, char padCharacter) {
      StringBuilder sb = new StringBuilder();
      for (int i = 0; i < length; i++) {
         sb.append(padCharacter);
      }
      String padding = sb.toString();
      String paddedString = padding.substring(originalString.length())
            + originalString;
      return paddedString;
   }
	
	//--------------------------------------------------------------------------	
	
	@RequestMapping(value = "/queue/patchTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchResponseBody patchTest(HttpServletRequest request, @RequestBody PatchRequestBody requestBody) 
	{  
		return patch(request, requestBody);
	} // .end of patchTest
	
	@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL, methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"} )
	@RequestMapping(value = "/queue/patch", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)  
	public PatchResponseBody patch(HttpServletRequest request, @RequestBody PatchRequestBody requestBody) 
	{  
		PatchResponseBody responseBody = new PatchResponseBody();
		responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;
		
		// TASKS: Pre	
		LOGGER.info("BEGIN: " + requestBody.patchType);
		long startTime = Calendar.getInstance().getTimeInMillis();	

		LOGGER.info("Place ID: " + requestBody.placeId);
		
		if ("calculateBillings".equals(requestBody.patchType))
			calculateBillingsByPlace(requestBody.placeId);
		//if ("indexBillings".equals(requestBody.patchType))
		//	crawlBillingsByPlace(requestBody.placeId);
		//if ("indexCustomers".equals(requestBody.patchType))
		//	crawlCustomersByPlace(requestBody.placeId);
		//if ("indexCategories".equals(requestBody.patchType))
		//	crawlCategoriesByPlace(requestBody.placeId);
		//if ("indexItems".equals(requestBody.patchType))
		//	crawlItemsByPlace(requestBody.placeId);

		LOGGER.info("END: " + requestBody.patchType);
		
		long endTime = Calendar.getInstance().getTimeInMillis();
		responseBody.elapsedTimeInMillis = endTime - startTime;	
		
		return responseBody;
	} // .end of patch
	
	private void crawlBillingsByPlace(String placeId)
	{
		// Billing
		BillingSearchCriteria billingSearchCriteria = new BillingSearchCriteria( placeId );
		billingSearchCriteria.setFullBean( false );
		
		List<BillingBean> billingList = billingService.getBillingsByPlaceId(billingSearchCriteria);
		LOGGER.info("BILLING SIZE: " + billingList.size());
		
		for (BillingBean billingObj : billingList) {
			LOGGER.info("BILLING: " + billingObj.getBillingNo());
			billingUtil.indexBean(billingObj);
		}		
	} // .end of crawlBillingsByPlace
	
	private void crawlCustomersByPlace(String placeId)
	{
		// Customers
		CustomerSearchCriteria customerSearchCriteria = new CustomerSearchCriteria( placeId );
		customerSearchCriteria.setFullBean( false );
		
		List<CustomerBean> customerList = customerService.getCustomersByPlaceId(customerSearchCriteria);
		for (CustomerBean customerObj : customerList) {
			LOGGER.info("CUSTOMER: " + customerObj.getFirstName());
			customerUtil.indexBean(customerObj);
		}		
	} // .end of crawlCustomersByPlace
	
	private void crawlCategoriesByPlace(String placeId)
	{		
		// Inventory Category
		InventorySearchCriteria categorySearchCriteria = new InventorySearchCriteria( placeId );
		categorySearchCriteria.setFullBean( false );

		List<InventoryCategoryBean> categoryList = inventoryService.getCategoriesByPlaceId(categorySearchCriteria);
		for (InventoryCategoryBean categoryObj : categoryList) {
			LOGGER.info("CATEGORY: " + categoryObj.getName());
			inventoryUtil.indexBean(categoryObj);
		}
	} // .end of crawlCategoriesByPlace
	
	private void crawlItemsByPlace(String placeId)
	{		
		// Inventory Item
		InventorySearchCriteria itemSearchCriteria = new InventorySearchCriteria( placeId );
		itemSearchCriteria.setFullBean( false );
		
		List<InventoryItemBean> itemList = inventoryService.getItemsByPlaceId(itemSearchCriteria);
		for (InventoryItemBean itemObj : itemList) {
			LOGGER.info("ITEM: " + itemObj.getName());
			inventoryUtil.indexBean(itemObj);
		}
	} // .end of crawlItemsByPlace
	
	private void calculateBillingsByPlace(String placeId) {
		// Billing
		BillingSearchCriteria billingSearchCriteria = new BillingSearchCriteria( placeId );
		billingSearchCriteria.setFullBean( false );
		
		List<BillingBean> billingList = billingService.getBillingsByPlaceId_1(billingSearchCriteria);
		LOGGER.info("BILLING SIZE: " + billingList.size());
		
		for (BillingBean billingObj : billingList) {
						
			billingUtil.calculateBilling(billingObj);
			
			billingService.saveOrUpdateBilling(billingObj, "system-patcher");

			LOGGER.info("PROCESSED: " + billingObj.getBillingNo());
		}
		
		
	} // .end of calculateBillingsByPlace
}  