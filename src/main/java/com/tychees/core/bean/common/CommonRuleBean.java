package com.tychees.core.bean.common;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import com.tychees.core.bean.BeanSuperClass;

@MappedSuperclass
public abstract class CommonRuleBean
	extends BeanSuperClass
{
	@Column(name="name")
    String name = "";
	@Column(name="active")
	boolean active = false;

    public String getName() { return this.name; }
    public boolean isActive() { return this.active; }
    
    public void setName(String val) { this.name = val; }
    public void setActive(boolean val) { this.active = val; }
}
