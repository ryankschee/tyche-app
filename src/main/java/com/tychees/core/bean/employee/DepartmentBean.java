package com.tychees.core.bean.employee;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;
import javax.persistence.Transient;

import com.tychees.core.bean.BeanSuperClass; 

@Entity  
@Table(name="department_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class DepartmentBean 
	extends BeanSuperClass
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 3830939997529360912L;

    @Transient
    public List<DepartmentJobBean> jobList;
    
    public DepartmentBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public DepartmentBean(String id) 
    {
    	super();  
        this.setId(id);
        
        this.jobList = new ArrayList<DepartmentJobBean>();
    }

	@Column(name="name")  
	String name = "";   
	@Column(name="manager_id")  
	String managerId = "";   

	public String getName() { return this.name; }
    public String getManagerId() { return this.managerId; }
    
    public void setName(String val) { this.name = val; }
    public void setManagerId(String val) { this.managerId = val; } 
    
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
