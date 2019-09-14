package com.tychees.console.controller.queue.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class QueueBatchDownloadItemsRequestBody 
	extends AbstractWebRequestBody 
{
	public String categoryId;
	public String groupName;

	public boolean filterByGroupName = false;
	public boolean loadComponentItems = false;
}
