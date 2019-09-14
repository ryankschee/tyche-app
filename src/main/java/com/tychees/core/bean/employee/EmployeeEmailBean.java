package com.tychees.core.bean.employee;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;

import com.tychees.core.bean.common.CommonEmailBean;  
  
@Entity  
@Table(name="employee_email_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class EmployeeEmailBean 
	extends CommonEmailBean
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 8539335464954385814L;

    public EmployeeEmailBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public EmployeeEmailBean(String id) 
    {
    	super();
        this.setId(id);
    }

	@Column(name="employee_id")  
	String employeeId = "";   

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
