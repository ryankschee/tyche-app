package com.tychees.pws.controller.search.response;

import java.util.List;

import com.tychees.core.bean.index.IndexTermBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class CommonSearchResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<IndexTermBean> resultList;
}
