package com.tychees.core.bean.employee;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonContactBean;

@Entity  
@Table(name="employee_contact_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class EmployeeContactBean
    extends CommonContactBean
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
 
    @Column(name="employee_id")
    String employeeId = "";
    
    public EmployeeContactBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public EmployeeContactBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getEmployeeId() { return this.employeeId; }
    
    public void setEmployeeId(String val) { this.employeeId = getSafeString(val); }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getClass().getName();
	}
}