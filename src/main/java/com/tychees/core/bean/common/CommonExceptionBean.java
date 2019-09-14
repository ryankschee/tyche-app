package com.tychees.core.bean.common;

import java.util.logging.Logger;

import com.tychees.core.constants.ExceptionConstants;

public class CommonExceptionBean
	extends Exception
{
	private static final Logger logger = Logger.getLogger(CommonExceptionBean.class.getName());
	private static final long serialVersionUID = 1L;
	
	private int code;
    private String title;
    private String shortMessage;
    private String longMessage;
    private String rootMessage;
    
	public CommonExceptionBean(ExceptionConstants exceptionObj, String rootExceptionMessage) 
	{
	    super();
	    
	    setCode(exceptionObj.code);
	    setShortMessage(exceptionObj.getName());
	    setLongMessage(exceptionObj.message);
	    setRootMessage(rootExceptionMessage);
	    
	    logger.info(getFullMessage());
	}
 
    public int getCode() { return this.code; }
    public String getTitle() { return this.title; }
    public String getShortMessage() { return this.shortMessage; }
    public String getLongMessage() { return this.longMessage; }
    public String getRootMessage() { return this.rootMessage==null ? "null" : this.rootMessage; }
    
    public void setCode(int val) { this.code = val; }
    public void setTitle(String val) { this.title = val; }
    public void setShortMessage(String val) { this.shortMessage = val; }
    public void setLongMessage(String val) { this.longMessage = val; }
    public void setRootMessage(String val) { this.rootMessage = val; }
    
    /**
     * Return full message in JSON format.
     * e.g. code:"1234", title:"short message", message:"long message", root:"root message"
     */
    public String getFullMessage()
    {
    	return "code:\""+ getCode() + "\", title:\"" + getShortMessage() + "\", message:\"" + getLongMessage() + "\", root:\"" + getRootMessage() + "\"";
    }
 }
