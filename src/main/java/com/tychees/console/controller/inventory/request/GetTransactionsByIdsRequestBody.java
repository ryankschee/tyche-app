package com.tychees.console.controller.inventory.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class GetTransactionsByIdsRequestBody 
	extends AbstractWebRequestBody 
{
	public String transactionIdList;
}
