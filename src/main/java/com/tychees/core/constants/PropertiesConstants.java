package com.tychees.core.constants;

import org.springframework.stereotype.Component;

@Component
public class PropertiesConstants 
	implements java.io.Serializable
{
    private final static long serialVersionUID = 1467880004586236216L;
    
	public PropertiesConstants() {}
	
	// CONSTANTS - FIELD TYPES
	public final String PROP_TYPE_BOOLEAN								= "Boolean";
	public final String PROP_TYPE_TEXT									= "Text";
	public final String PROP_TYPE_NUMBER								= "Number";
	public final String PROP_TYPE_DATE									= "Date";
	public final String PROP_TYPE_TIME									= "Time";
	public final String PROP_TYPE_LIST									= "List";
	public final String PROP_TYPE_TAG									= "Tag";
}
