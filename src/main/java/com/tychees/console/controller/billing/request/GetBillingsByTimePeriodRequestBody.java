package com.tychees.console.controller.billing.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetBillingsByTimePeriodRequestBody 
	extends AbstractWebRequestBody 
{
	public long beginTime = 0L;
	public long endTime = 0L;
	
	public boolean byBillingDate = true;
	public boolean byInvoiceDate = false;
	public boolean byReceiptDate = false;
	public boolean byQuotationDate = false;
}
