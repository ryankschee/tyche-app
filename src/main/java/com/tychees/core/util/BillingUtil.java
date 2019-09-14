package com.tychees.core.util;

import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tychees.core.util.BeanUtil;
import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.billing.BillingBucketBean;
import com.tychees.core.bean.billing.BillingBucketLineBean;
import com.tychees.core.bean.billing.BillingLineBean;
import com.tychees.core.bean.billing.BillingPaymentBean;
import com.tychees.core.bean.billing.BillingWorkflowBean;
import com.tychees.core.bean.common.CommonCalendarBean;
import com.tychees.core.constants.BillingConstants;
import com.tychees.core.constants.InventoryConstants;
import com.tychees.core.constants.ModuleConstants;
import com.tychees.core.dao.DAOException;
import com.tychees.core.dao.billing.BillingBucketDAO;
import com.tychees.core.dao.billing.BillingBucketLineDAO;
import com.tychees.core.dao.billing.BillingDAO;
import com.tychees.core.dao.billing.BillingDeliveryDAO;
import com.tychees.core.dao.billing.BillingLineDAO;
import com.tychees.core.dao.billing.BillingPaymentDAO;
import com.tychees.core.dao.billing.BillingPaymentPropertiesDAO;
import com.tychees.core.dao.billing.BillingPropertiesDAO;
import com.tychees.core.dao.billing.BillingWorkflowDAO;
import com.tychees.core.dao.billing.BillingWorkflowEventDAO;
import com.tychees.core.dao.common.CommonCalendarDAO;
import com.tychees.core.dao.common.CommonCalendarEventDAO;
import com.tychees.core.service.IndexService;

@Component
public class BillingUtil {

	@Autowired
	BeanUtil beanUtil;
	@Autowired
	MathUtil mathUtil;
	@Autowired
	BillingConstants billingConstants;
	@Autowired
	ModuleConstants moduleConstants;
    @Autowired  
	BillingDAO billingDao;  
	@Autowired  
	BillingDeliveryDAO billingDeliveryDao;
	@Autowired  
	BillingLineDAO billingLineDao;
	@Autowired  
	BillingPaymentDAO billingPaymentDao;
	@Autowired  
	BillingPaymentPropertiesDAO billingPaymentPropertiesDao;
	@Autowired  
	BillingPropertiesDAO billingPropertiesDao;
	@Autowired  
	BillingWorkflowDAO billingWorkflowDao;
	@Autowired  
	BillingWorkflowEventDAO billingWorkflowEventDao;
	@Autowired  
	BillingBucketDAO billingBucketDao;
	@Autowired  
	BillingBucketLineDAO billingBucketLineDao;
	@Autowired  
	CommonCalendarDAO calendarDao;
	@Autowired  
	CommonCalendarEventDAO calendarEventDao;
    @Autowired  
	IndexService indexService; 
	@Autowired
	InventoryConstants inventoryConstants;

	private final static Logger LOGGER = Logger.getLogger(BillingUtil.class.getName());
    
	public List<BillingBean> fillBeans(List<BillingBean> billingList) 
	{
		for (BillingBean billingObj : billingList)
		{
			fillBean( billingObj );
		}
		
		return billingList;
	} // .end of fillBeans
	
	/**
	 * Full Structure of BillingBean
	 * -----------------------------
	 * BillingBean
	 *  |- deliveryList
	 *  |- lineList
	 *  |   |- lineList
	 *  |   |- mandatoryList
	 *  |- paymentList
	 *  |   |- propertiesList
	 *  |- propertiesList
	 *  |- workflowList
	 *      |- eventList
	 *  |- calendarList
	 *      |- eventList
	 */ 
	public BillingBean fillBillingLines(BillingBean billingObj) 
	{  
		try 
		{
			if (billingObj != null)
			{							
				// Get root-only billing lines
				billingObj.lineList = 
					billingLineDao.getBeansByBillingId(billingObj.getId(), "");
				for (BillingLineBean lineObj : billingObj.lineList) 
				{
					List<BillingLineBean> childLineList =
						billingLineDao.getBeansByParentLineId( lineObj.getId() );
					for (BillingLineBean childLineObj : childLineList)
					{
						if (childLineObj.isMandatory())
							lineObj.lineList.add(childLineObj);
						else
							lineObj.lineList.add(childLineObj);
					}
				}

				billingObj.paymentList = 
					billingPaymentDao.getBeansByBillingId(billingObj.getId());
				for (BillingPaymentBean paymentObj : billingObj.paymentList) 
				{
					paymentObj.propertiesList = 
						billingPaymentPropertiesDao.getBeansByPaymentId(paymentObj.getId());
				}
			}
			
			return billingObj;
		}
		catch (DAOException e) 
		{
			e.printStackTrace();
			return billingObj;
		}
	} // .end of fillBean
	
	/**
	 * Full Structure of BillingBean
	 * -----------------------------
	 * BillingBean
	 *  |- deliveryList
	 *  |- lineList
	 *  |   |- lineList
	 *  |   |- mandatoryList
	 *  |- paymentList
	 *  |   |- propertiesList
	 *  |- propertiesList
	 *  |- workflowList
	 *      |- eventList
	 *  |- calendarList
	 *      |- eventList
	 */ 
	public BillingBean fillBean(BillingBean billingObj) 
	{  
		try 
		{
			if (billingObj != null)
			{
				// Set fullBeanLoaded state
				billingObj.setFullBeanLoaded( true );
				billingObj.setHasChanged( false );
				
				billingObj.deliveryList = 
					billingDeliveryDao.getBeansByBillingId(billingObj.getId());
							
				// Get root-only billing lines
				billingObj.lineList = 
					billingLineDao.getBeansByBillingId(billingObj.getId(), "");
				for (BillingLineBean lineObj : billingObj.lineList) 
				{
					List<BillingLineBean> childLineList =
						billingLineDao.getBeansByParentLineId( lineObj.getId() );
					for (BillingLineBean childLineObj : childLineList)
					{
						if (childLineObj.isMandatory())
							lineObj.lineList.add(childLineObj);
						else
							lineObj.lineList.add(childLineObj);
					}
				}
				
				billingObj.paymentList = 
					billingPaymentDao.getBeansByBillingId(billingObj.getId());
				for (BillingPaymentBean paymentObj : billingObj.paymentList) 
				{
					paymentObj.propertiesList = 
						billingPaymentPropertiesDao.getBeansByPaymentId(paymentObj.getId());
				}
				
				billingObj.propertiesList = 
					billingPropertiesDao.getBeansByBillingId(billingObj.getId());
					
				billingObj.workflowList = 
					billingWorkflowDao.getBeansByBillingId(billingObj.getId());
				for (BillingWorkflowBean workflowObj : billingObj.workflowList) 
				{
					workflowObj.eventList = 
						billingWorkflowEventDao.getBeansByWorkflowId(workflowObj.getId());
				}
				
				billingObj.calendarList = 
					calendarDao.getBeansByForeignId(billingObj.getId());
				for (CommonCalendarBean calendarObj : billingObj.calendarList) 
				{
					calendarObj.eventList = 
						calendarEventDao.getBeansByCalendarId(calendarObj.getId());
				}
			}
			
			return billingObj;
		}
		catch (DAOException e) 
		{
			e.printStackTrace();
			return billingObj;
		}
	} // .end of fillBean
	
	/**
	 * Full Structure of BillingBucketBean
	 * -----------------------------
	 * BillingBucketBean
	 *  |- lineList
	 */ 
	public BillingBucketBean fillBean(BillingBucketBean bucketObj) 
	{  
		try 
		{
			if (bucketObj != null)
			{	
				// Get root-only billing lines
				bucketObj.lineList = 
					billingBucketLineDao.getBeansByBucketId(bucketObj.getId(), "");
				for (BillingBucketLineBean lineObj : bucketObj.lineList) 
				{
					List<BillingBucketLineBean> childLineList =
						billingBucketLineDao.getBeansByParentLineId( lineObj.getId() );
					for (BillingBucketLineBean childLineObj : childLineList)
					{
						if (childLineObj.isMandatory())
							lineObj.lineList.add(childLineObj);
						else
							lineObj.lineList.add(childLineObj);
					}
				}	
			}
			
			return bucketObj;
		}
		catch (DAOException e) 
		{
			e.printStackTrace();
			return bucketObj;
		}
	} // .end of fillBean
	
	/**
	 * Perform indexing on BillingBean.
	 */ 
	public void indexBean(BillingBean billingObj) 
	{
		LOGGER.info("PRE-INDEX: " + billingObj.getBillingNo());
		if (indexService.validateBean(billingObj.getPlaceId(), billingObj))
		{
			LOGGER.info("INDEXING: " + billingObj.getBillingNo());
			
			// Indexing Starts
			indexService.saveTermsAsIndex(billingObj, "billingNo", billingObj.getBillingNo());
			//indexService.saveTermsAsIndex(billingObj, "customerName", billingObj.getCustomerName());
			//indexService.saveTermsAsIndex(billingObj, "state", billingObj.getStateDesc());
			indexService.saveTermsAsIndex(billingObj, "purchaseNo", billingObj.getPurchaseOrderNo());
			indexService.saveTermsAsIndex(billingObj, "invoiceNo", billingObj.getInvoiceNo());
			indexService.saveTermsAsIndex(billingObj, "receiptNo", billingObj.getReceiptNo());
			indexService.saveTermsAsIndex(billingObj, "quotationNo", billingObj.getQuotationNo());

			LOGGER.info("INDEXED: " + billingObj.getBillingNo());
		}
	} // .end of indexBean
	
	/**
	 * Remove indexing on BillingBean.
	 */ 
	public void removeIndexBean(BillingBean billingObj) 
	{
		indexService.removeTermsByBean(billingObj);
	} // .end of removeIndexBean
	
	public void calculateBilling(BillingBean billingObj)
	{
		if (billingObj == null)
			return;
		
		//var l1_taxAmount = 0.0;
		double l1_discountAmount = 0.0;

		double uniqueTaxPercentage = 0.0;
		boolean hasMultipleTaxPercentage = false;

		double taxAmount = 0.0;
		double taxPercentage = 0.0;
		double discountAmount = 0.0;
		double discountPercentage = 0.0;

		double subTotalAmount = 0.0;
		double totalAmount = 0.0;
		double totalPayment = 0.0;
		boolean hasPaymentRecord = false;

		//-----
		// #1. Calculate amounts from summation of each billing line object.
		for (BillingLineBean lineObj : billingObj.lineList) {
			
			if (beanUtil.isDeletedBean(lineObj))
				continue;

			if (inventoryConstants.ITEM_TYPE_RAW.equals(lineObj.getItemType()) ||
				inventoryConstants.ITEM_TYPE_PRODUCT.equals(lineObj.getItemType()) ||
				inventoryConstants.ITEM_TYPE_SERVICE.equals(lineObj.getItemType()) ||
				inventoryConstants.ITEM_TYPE_EVENT.equals(lineObj.getItemType())) {
				
				// Re-calculate amounts inside billing line
				calculateBillingLine(billingObj, lineObj);

				// Add amounts from billing line to billing object.
				discountAmount += lineObj.getDiscountAmount();
				discountPercentage += lineObj.getDiscountPercentage();
				taxAmount += lineObj.getTaxAmount();
				taxPercentage += lineObj.getTaxPercentage();
				// Price (Exclude Tax only)
				subTotalAmount += (lineObj.getBillableAmount()) * lineObj.getQuantity();

				// Set first tax percentage
				if (uniqueTaxPercentage == 0)
					uniqueTaxPercentage = lineObj.getTaxPercentage();
				if (uniqueTaxPercentage != lineObj.getTaxPercentage())
					hasMultipleTaxPercentage = true;
			}
		}

		billingObj.setSubTotalAmount(mathUtil.round(subTotalAmount, 2));

		//-----
		// #2. Handle Level 1 DISCOUNT-typed billing item.
		for (BillingLineBean lineObj : billingObj.lineList) {

			if (beanUtil.isDeletedBean(lineObj))
				continue;

			if (inventoryConstants.ITEM_TYPE_DISCOUNT.equals(lineObj.getItemType())) {
				double amount = calculateBillingLine_discountType(billingObj, lineObj);
				l1_discountAmount += amount;
			}
		}

		// #2.1. Deduct from discount (if any)
		if (l1_discountAmount == 0) {
			totalAmount = subTotalAmount + taxAmount;
		} else {
			subTotalAmount = subTotalAmount - l1_discountAmount;

			taxAmount = subTotalAmount * (uniqueTaxPercentage / 100);
			totalAmount = subTotalAmount + taxAmount;
		}

		//-----
		// #4. Calculate payment(s), if any.
		for (BillingPaymentBean paymentObj : billingObj.paymentList) {

			if (beanUtil.isDeletedBean(paymentObj))
				continue;

			hasPaymentRecord = true;

			// if changeAmount is ZERO or NEGATIVE
			if (paymentObj.getChangeAmount() <= 0)
				totalPayment += paymentObj.getPayingAmount();
			// if changeAmount is POSITIVE
			else
				totalPayment += (paymentObj.getPayingAmount() - paymentObj.getChangeAmount());
		}
		
		//----
		// #5. Create associated workflow event, if any.
		if (hasPaymentRecord) {
			
			if (totalPayment > totalAmount) {
				billingObj.setState(billingConstants.WORKFLOW_EVENTKEY_OVERPAID);
				billingObj.setStateDesc(billingConstants.WORKFLOW_EVENTDESC_OVERPAID);				
			}
			
			if (totalPayment == totalAmount) {
				billingObj.setState(billingConstants.WORKFLOW_EVENTKEY_PAID);
				billingObj.setStateDesc(billingConstants.WORKFLOW_EVENTDESC_PAID);		
			}
		}
		else {
			if (billingConstants.WORKFLOW_EVENTKEY_NEW.equals(billingObj.getState())) {
				// Set billing state
				billingObj.setState(billingConstants.WORKFLOW_EVENTKEY_OPEN);
				billingObj.setStateDesc(billingConstants.WORKFLOW_EVENTDESC_OPEN);
			}

			if (billingConstants.WORKFLOW_EVENTKEY_PAID.equals(billingObj.getState())) {
				// Set billing state
				billingObj.setState(billingConstants.WORKFLOW_EVENTKEY_OPEN);
				billingObj.setStateDesc(billingConstants.WORKFLOW_EVENTDESC_OPEN);
			}
		}

		//-----
		// #6. Update calculated amounts into billing object.
		billingObj.setTaxAmount(mathUtil.round(taxAmount,2));
		billingObj.setTaxPercentage(mathUtil.round(taxPercentage,2));
		billingObj.setDiscountAmount(mathUtil.round(discountAmount,2));
		billingObj.setDiscountPercentage(mathUtil.round(discountPercentage,2));
		billingObj.setSubTotalAmount(mathUtil.round(subTotalAmount,2));
		billingObj.setTotalAmount(mathUtil.round(totalAmount,2));
		billingObj.setTotalPayment(mathUtil.round(totalPayment,2));
	} // .end of calculateBilling
	
	private void calculateBillingLine(BillingBean billingObj, BillingLineBean lineObj)
	{
		if (lineObj == null)
			return;
		
		if (inventoryConstants.ITEM_TYPE_RAW.equals(lineObj.getItemType()) ||
			inventoryConstants.ITEM_TYPE_PRODUCT.equals(lineObj.getItemType()) ||
			inventoryConstants.ITEM_TYPE_SERVICE.equals(lineObj.getItemType()) ||
			inventoryConstants.ITEM_TYPE_EVENT.equals(lineObj.getItemType())) {
		
			// Calculation begins.
			calculateBillingLine_stepOne(lineObj);
			return;
		}

		if (inventoryConstants.ITEM_TYPE_DISCOUNT.equals(lineObj.getItemType())) {
			calculateBillingLine_discountType(billingObj, lineObj);
			return;
		}

	} // .end of calculateBillingLine

	private double calculateBillingLine_discountType(BillingBean billingObj, BillingLineBean lineObj) {
		if (lineObj == null)
			return 0;
		if (inventoryConstants.ITEM_TYPE_DISCOUNT.equals(lineObj.getItemType())) 
			return 0;
		// Only for Discount item at Level 1
		if ("".equals(lineObj.getParentLineId()))
			return 0;
	
		double discountPercentage = lineObj.getDiscountPercentage();
		double discountAmount = lineObj.getDiscountAmount();
	
		if (lineObj.isTaxDiscountInPercentage()) {
			if ("default".equals(lineObj.getUnitPriceSource()))
				discountPercentage = lineObj.getDefaultUnitPrice();
			if ("compound".equals(lineObj.getUnitPriceSource()))
				discountPercentage = lineObj.getCompoundUnitPrice();
			if ("custom".equals(lineObj.getUnitPriceSource()))
				discountPercentage = lineObj.getCustomUnitPrice();
	
			discountAmount = (billingObj.getSubTotalAmount() * (discountPercentage / 100));
		}
		if (lineObj.isTaxDiscountInAmount()) {
			if ("default".equals(lineObj.getUnitPriceSource()))
				discountAmount = lineObj.getDefaultUnitPrice();
			if ("compound".equals(lineObj.getUnitPriceSource()))
				discountAmount = lineObj.getCompoundUnitPrice();
			if ("custom".equals(lineObj.getUnitPriceSource()))
				discountAmount = lineObj.getCustomUnitPrice();
		}
	
		lineObj.setDiscountPercentage(discountPercentage);
		lineObj.setDiscountAmount(discountAmount);
	
		return lineObj.getDiscountAmount();
	} // .end of calculateBillingLine_discountType
	
	private double calculateBillingLine_taxType(BillingBean billingObj, BillingLineBean lineObj) 
	{
		if (lineObj == null)
			return 0;
		if (!inventoryConstants.ITEM_TYPE_TAX.equals(lineObj.getItemType()))
			return 0;
		// Only for Tax item at Level 1
		if (!"".equals(lineObj.getParentLineId()))
			return 0;
	
		double taxPercentage = lineObj.getTaxPercentage();
		double taxAmount = lineObj.getTaxAmount();
	
		if (lineObj.isTaxDiscountInAmount()) {
			// tax amount stay the same
			if ("default".equals(lineObj.getUnitPriceSource()))
				taxAmount = lineObj.getDefaultUnitPrice();
			if ("compound".equals(lineObj.getUnitPriceSource()))
				taxAmount = lineObj.getCompoundUnitPrice();
			if ("custom".equals(lineObj.getUnitPriceSource()))
				taxAmount = lineObj.getCustomUnitPrice();			
		}
		if (lineObj.isTaxDiscountInPercentage()) {
			if ("default".equals(lineObj.getUnitPriceSource()))
				taxPercentage = lineObj.getDefaultUnitPrice();
			if ("compound".equals(lineObj.getUnitPriceSource()))
				taxPercentage = lineObj.getCompoundUnitPrice();
			if ("custom".equals(lineObj.getUnitPriceSource()))
				taxPercentage = lineObj.getCustomUnitPrice();
			
			if (lineObj.isTaxInclusive()) {
				double taxInDecimal = lineObj.getTaxPercentage() / 100;
				double calculatedTaxAmount = billingObj.getSubTotalAmount() - (billingObj.getSubTotalAmount() / (taxInDecimal + 1));
				taxAmount = Math.round(calculatedTaxAmount * 100) / 100;
			}
			else {
				double calculatedTaxAmount = billingObj.getSubTotalAmount() * (lineObj.getTaxPercentage() / 100);
				taxAmount = Math.round(calculatedTaxAmount * 100) / 100;
			}
		}
	
		lineObj.setTaxPercentage( taxPercentage );
		lineObj.setTaxAmount( taxAmount );
	
		return lineObj.getTaxAmount();
	} // .end of calculateBillingLine_taxType
	
	private void calculateBillingLine_stepOne(BillingLineBean lineObj) 
	{
		if (lineObj == null)
			return;
		
		double billingLine_unitPrice = lineObj.getDefaultUnitPrice();
		if ("compound".equals(lineObj.getUnitPriceSource()))
			billingLine_unitPrice = lineObj.getCompoundUnitPrice();
		if ("custom".equals(lineObj.getUnitPriceSource()))
			billingLine_unitPrice = lineObj.getCustomUnitPrice();
	
		double totalExclusiveTaxAmount = 0;
		double totalDiscountAmount = 0;
		double totalDiscountPercentage = 0;
		double totalCompoundUnitCost = 0;
		double totalCompoundUnitPrice = 0;
	
		// Check if this item is tax-inclusive
		// IF yes, then recalculate the billable amount of this item line
		for (BillingLineBean childLineObj : lineObj.lineList) {
			if (inventoryConstants.ITEM_TYPE_TAX.equals(childLineObj.getItemType())) {
				if (childLineObj.isTaxInclusive()) {
					double taxInDecimal = childLineObj.getTaxPercentage() / 100;
					double taxAmount = billingLine_unitPrice - (billingLine_unitPrice / (taxInDecimal + 1));
					double roundedTaxAmount = Math.round(taxAmount * 100) / 100;
	
					billingLine_unitPrice = billingLine_unitPrice - roundedTaxAmount;
				}
			}
		}
	
		// Mandatory Components
		for (BillingLineBean childLineObj : lineObj.lineList) {	
			if (beanUtil.isDeletedBean(childLineObj))
				continue;
			if (childLineObj.isMandatory())
				continue;
	
			if (inventoryConstants.ITEM_TYPE_TAX.equals(childLineObj.getItemType())) {
				// Process Tax item(s) in step 2 later.
			}
			else
			if (inventoryConstants.ITEM_TYPE_DISCOUNT.equals(childLineObj.getItemType())) {
				if (childLineObj.isTaxDiscountInAmount()) {
					totalDiscountAmount += childLineObj.getDiscountAmount();
				}
	
				if (childLineObj.isTaxDiscountInPercentage()) {
					totalDiscountPercentage += childLineObj.getDiscountPercentage();
	
					double calculatedDiscountAmount = billingLine_unitPrice * lineObj.getQuantity() * (childLineObj.getDiscountPercentage() / 100);
					double roundedDiscountAmount = Math.round(calculatedDiscountAmount * 100) / 100;
					totalDiscountAmount += roundedDiscountAmount;
				}
			}
			else {
				// ITEM TYPE: Product, Service, Event, Raw
				//double roundedUnitCost = Math.round(childLineObj.getUnitCost() * childLineObj.getQuantity() * 100) / 100;
				//totalCompoundUnitCost += roundedUnitCost;
	
				//double roundedUnitPrice = Math.round(childLineObj.getUnitPrice() * childLineObj.getQuantity() * 100) / 100;
				//totalCompoundUnitPrice += roundedUnitPrice;
			}
		}
	
		// Non-Mandatory Components
		for (BillingLineBean childLineObj : lineObj.lineList) {	
			if (beanUtil.isDeletedBean(childLineObj))
				continue;
			if (!childLineObj.isMandatory())
				continue;
	
			if (inventoryConstants.ITEM_TYPE_TAX.equals(childLineObj.getItemType())) {
				// Process Tax item(s) in step 2 later.
			}
			else
			if (inventoryConstants.ITEM_TYPE_DISCOUNT.equals(childLineObj.getItemType())) {
				if (childLineObj.isTaxDiscountInAmount()) {
					totalDiscountAmount += childLineObj.getDiscountAmount();
				}
	
				if (childLineObj.isTaxDiscountInPercentage()) {
					totalDiscountPercentage += childLineObj.getDiscountPercentage();
	
					double calculatedDiscountAmount = billingLine_unitPrice * lineObj.getQuantity() * (childLineObj.getDiscountPercentage() / 100);
					double roundedDiscountAmount = Math.round(calculatedDiscountAmount * 100) / 100;
					totalDiscountAmount += roundedDiscountAmount;
				}
			}
			else {
				// ITEM TYPE: Product, Service, Event, Raw
				//double roundedUnitCost = Math.round(childLineObj.getUnitCost() * childLineObj.getQuantity() * 100) / 100;
				//totalCompoundUnitCost += roundedUnitCost;
	
				//double roundedUnitPrice = Math.round(childLineObj.getUnitPrice() * childLineObj.getQuantity() * 100) / 100;
				//totalCompoundUnitPrice += roundedUnitPrice;
			}
		}
		
		// Summary of value
		lineObj.setDiscountAmount( totalDiscountAmount );
		lineObj.setDiscountPercentage( totalDiscountPercentage );
		// Add up unit price with total taxable amount.
		lineObj.setBillableAmount( billingLine_unitPrice - totalDiscountAmount );
		// Total compound cost/price from containing items
		lineObj.setCompoundUnitCost( totalCompoundUnitCost );
		lineObj.setCompoundUnitPrice( totalCompoundUnitPrice );
	
		// Continue Tax Calculation in Step 2
		calculateBillingLine_stepTwo(lineObj);
	} // .end of billingCommon_calculateBillingLine_stepOne
	
	private void calculateBillingLine_stepTwo(BillingLineBean lineObj) 
	{
		if (lineObj == null)
			return;
		
		double billingLine_unitPrice = lineObj.getBillableAmount();
		double totalInclusiveTaxAmount = 0;
		double totalExclusiveTaxAmount = 0;
		double totalTaxPercentage = 0;
	
		// Mandatory Components
		for (BillingLineBean childLineObj : lineObj.lineList) {
	
			if (beanUtil.isDeletedBean(childLineObj) == true)
				continue;
			if (childLineObj.isMandatory())
				continue;
			if (inventoryConstants.ITEM_TYPE_TAX.equals(childLineObj.getItemType())) {
	
				totalTaxPercentage += childLineObj.getTaxPercentage();
				// Calculate tax by using exclusive method
				double taxAmount = billingLine_unitPrice * lineObj.getQuantity() * (childLineObj.getTaxPercentage() / 100);
				double roundedTaxAmount = Math.round(taxAmount * 100) / 100;
				totalExclusiveTaxAmount += roundedTaxAmount;
			}
		} // .end of Non-Mandatory Components
	
		// Non-Mandatory Components
		for (BillingLineBean childLineObj : lineObj.lineList) {
			
			if (beanUtil.isDeletedBean(childLineObj) == true)
				continue;
			if (!childLineObj.isMandatory())
				continue;
			if (inventoryConstants.ITEM_TYPE_TAX.equals(childLineObj.getItemType())) {
	
				totalTaxPercentage += childLineObj.getTaxPercentage();
				// Calculate tax by using exclusive method
				double taxAmount = billingLine_unitPrice * lineObj.getQuantity() * (childLineObj.getTaxPercentage() / 100);
				double roundedTaxAmount = Math.round(taxAmount * 100) / 100;
				totalExclusiveTaxAmount += roundedTaxAmount;
			}
		}
		
		// Summary of value
		lineObj.setTaxAmount( totalExclusiveTaxAmount + totalInclusiveTaxAmount );
		lineObj.setTaxPercentage( totalTaxPercentage );
	} // .end of calculateBillingLine_stepTwo
}