package com.tychees.console.controller.employee.response;

import java.util.List;

import com.tychees.core.bean.employee.view.EmployeeViewBean;
import com.tychees.core.controller.AbstractWebResponseBody;

public class GetEmployeesByKeywordsResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<EmployeeViewBean> employeeList;
}
