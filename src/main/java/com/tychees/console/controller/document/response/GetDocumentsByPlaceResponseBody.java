package com.tychees.console.controller.document.response;

import java.util.List;

import com.tychees.core.bean.document.DocumentBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetDocumentsByPlaceResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<DocumentBean> documentList;
}
