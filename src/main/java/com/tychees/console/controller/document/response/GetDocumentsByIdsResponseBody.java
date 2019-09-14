package com.tychees.console.controller.document.response;

import java.util.List;

import com.tychees.core.bean.document.DocumentBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetDocumentsByIdsResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<DocumentBean> documentList;
}
