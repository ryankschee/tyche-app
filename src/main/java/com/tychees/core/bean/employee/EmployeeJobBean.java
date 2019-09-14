package com.tychees.core.bean.employee;

import java.sql.Timestamp;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="employee_job_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class EmployeeJobBean
    extends BeanSuperClass
    implements java.io.Serializable
{
    private static final long serialVersionUID = 1467880004586236216L;
    
    @Column(name="employee_id")
    String employeeId = "";
    @Column(name="job_id")
    String jobId = "";
    @Column(name="department_id")
    String departmentId = "";
    @Column(name="start_on")
    Timestamp startOn;
    @Column(name="end_on")
    Timestamp endOn;
    @Column(name="present_job")
    boolean presentJob;
    
    public EmployeeJobBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public EmployeeJobBean(String id) 
    {
        super();
        this.setId(id);
    }

    public String getEmployeeId() { return this.employeeId; }
    public String getJobId() { return this.jobId; }
    public String getDepartment() { return this.departmentId; }
    public Timestamp getStartOn() { return this.startOn; }
    public Timestamp getEndOn() { return this.endOn; }
    public boolean isPresentJob() { return this.presentJob; }
    
    public void setEmployeeId(String val) { this.employeeId = getSafeString(val); }
    public void setJobId(String val) { this.jobId = getSafeString(val); }
    public void setDepartmentId(String val) { this.departmentId = getSafeString(val); }
    public void setStartOn(Timestamp val) { this.startOn = val; }
    public void setEndOn(Timestamp val) { this.endOn = val; }
    public void setPresentJob(boolean val) { this.presentJob = val; }
    
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