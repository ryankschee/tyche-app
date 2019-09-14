package com.tychees.core.bean.common;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import com.tychees.core.bean.BeanSuperClass;

@MappedSuperclass
public abstract class CommonPropertiesBean
	extends BeanSuperClass
{
	@Column(name="group_name")
	String groupName = "";		    // Logical grouping	
	@Column(name="prop_seqno")
	int propSeqno;                  // Logical ordering
	@Column(name="prop_key")
	String propKey = "";	
	@Column(name="prop_name")
	String propName = "";	
	@Column(name="prop_type")
	String propType = "";	
	@Column(name="prop_content")
	String propContent = "";	
	@Column(name="prop_value")
    String propValue = "";
    
    public String getGroupName() { return this.groupName; }
    public int getPropSeqno() { return this.propSeqno; }
    public String getPropKey() { return this.propKey; }
    public String getPropName() { return this.propName; }
    public String getPropType() { return this.propType; }
    public String getPropContent() { return this.propContent; }
    public String getPropValue() { return this.propValue; }
    
    public void setGroupName(String val) { this.groupName = getSafeString(val); }
    public void setPropSeqno(int val) { this.propSeqno = val; }
    public void setPropKey(String val) { this.propKey = getSafeString(val); }
    public void setPropName(String val) { this.propName = getSafeString(val); }
    public void setPropType(String val) { this.propType = getSafeString(val); }
    public void setPropContent(String val) { this.propContent = getSafeString(val); }
    public void setPropValue(String val) { this.propValue = getSafeString(val); }
}