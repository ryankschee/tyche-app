package com.tychees.console.controller.common.request;

import java.util.List;

import com.tychees.core.controller.AbstractWebRequestBody;

public class InitConsoleRequestBody 
	extends AbstractWebRequestBody 
{
	public boolean loadBillingList = false;
	public boolean loadCustomerList = false;
	public boolean loadDocumentList = false;
	public boolean loadCategoryList = false;
	public boolean loadItemList = false;
	public boolean loadTransactionList = false;
	public boolean loadPlaceList = false;
	public boolean loadUserList = false;
}
