package com.tychees.core.controller;

import javax.servlet.http.HttpServletRequest;

import com.tychees.core.bean.BeanSuperClass;

public class AbstractController 
{
	protected String getClientAddress(HttpServletRequest request)
	{
		String ipAddress = request.getHeader("X-FORWARDED-FOR");
		if (ipAddress == null) 
		    ipAddress = request.getRemoteAddr();
		
		return ipAddress;
	}	
	
	protected boolean isDeletedBean(BeanSuperClass beanObj)
	{
		if ("".equals(beanObj.getDeletedBy()) && beanObj.getDeletedOn() == null)
			return true;
		return false;
	}
}
