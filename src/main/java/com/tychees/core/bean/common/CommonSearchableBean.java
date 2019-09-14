package com.tychees.core.bean.common;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class CommonSearchableBean
	extends CommonGeolocationBean
{
    @Column(name="labels")
	String labels = ""; 
    @Column(name="searchable")     
	boolean searchable = false;     
	
    public String getLabels() { return this.labels; }
    public boolean isSearchable() { return this.searchable; }
    
    public void setLabels(String val) { this.labels = getSafeString(val); }
    public void setSearchable(boolean val) { this.searchable = val; }
}
