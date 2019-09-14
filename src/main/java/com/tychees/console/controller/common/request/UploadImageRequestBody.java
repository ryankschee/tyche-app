package com.tychees.console.controller.common.request;

import com.tychees.core.controller.AbstractWebRequestBody;

public class UploadImageRequestBody 
	extends AbstractWebRequestBody {

	public String beanId;
	public String imageName;
	public int imageWidth;
	public int imageHeght;
}
