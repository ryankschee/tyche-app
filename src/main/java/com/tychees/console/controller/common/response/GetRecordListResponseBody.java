package com.tychees.console.controller.common.response;

import java.util.ArrayList;
import java.util.List;

import com.tychees.core.controller.AbstractWebResponseBody;

public class GetRecordListResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<String> billingList;
	public List<String> customerList;
	public List<String> documentList;
	public List<String> categoryList;
	public List<String> itemList;
	public List<String> transactionList;
	public List<String> placeList;
	public List<String> userList;
	
	public GetRecordListResponseBody()
	{
		this.billingList = new ArrayList<String>();
		this.customerList = new ArrayList<String>();
		this.documentList = new ArrayList<String>();
		this.categoryList = new ArrayList<String>();
		this.itemList = new ArrayList<String>();
		this.transactionList = new ArrayList<String>();
		this.placeList = new ArrayList<String>();
		this.userList = new ArrayList<String>();
	}
}
