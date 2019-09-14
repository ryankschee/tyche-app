package com.tychees.core.dao;

import com.tychees.core.bean.common.CommonExceptionBean;
import com.tychees.core.constants.ExceptionConstants;

public class DAOException 
    extends CommonExceptionBean
{
	private static final long serialVersionUID = 1L;
		
	public DAOException(ExceptionConstants exceptionObj) 
    {
        super(exceptionObj, exceptionObj.message);
    }
    
	public DAOException(ExceptionConstants exceptionObj, String rootExceptionMessage) 
    {
        super(exceptionObj, rootExceptionMessage);
    }
}
