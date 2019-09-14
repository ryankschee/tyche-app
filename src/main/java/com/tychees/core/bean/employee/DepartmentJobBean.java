package com.tychees.core.bean.employee;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="department_job_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class DepartmentJobBean
    extends BeanSuperClass
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
    
    @Column(name="department_id")
    String departmentId = "";
    @Column(name="job_id")
    String jobId = "";
    @Column(name="min_salary")
    double minSalary = 0.0;
    @Column(name="max_salary")
    double maxSalary = 0.0;
    
    public DepartmentJobBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public DepartmentJobBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getDepartmentId() { return this.departmentId; }
    public String getJobId() { return this.jobId; }
    public double getMinSalary() { return this.minSalary; }
    public double getMaxSalary() { return this.maxSalary; }
    
    public void setDepartmentId(String val) { this.departmentId = getSafeString(val); }
    public void setJobId(String val) { this.jobId = getSafeString(val); }
    public void setMinSalary(double val) { this.minSalary = val; }
    public void setMaxSalary(double val) { this.maxSalary = val; }
    
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