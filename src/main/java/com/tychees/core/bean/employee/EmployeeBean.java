package com.tychees.core.bean.employee;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;
import javax.persistence.Transient;

import com.tychees.core.bean.common.CommonPersonBean;  

@Entity  
@Table(name="employee_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class EmployeeBean 
	extends CommonPersonBean
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 3830939997529360912L;

	@Transient
    public List<EmployeeAddressBean> addressList;
	@Transient
    public List<EmployeeContactBean> contactList;
	@Transient
    public List<EmployeeEmailBean> emailList;
    @Transient
    public List<EmployeeJobBean> jobList;
    @Transient
    public List<EmployeePropertiesBean> propertiesList;
    
    public EmployeeBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public EmployeeBean(String id) 
    {
    	super();  
        this.setId(id);
        
        this.contactList = new ArrayList<EmployeeContactBean>();
        this.addressList = new ArrayList<EmployeeAddressBean>();
        this.emailList = new ArrayList<EmployeeEmailBean>();
        this.propertiesList = new ArrayList<EmployeePropertiesBean>();
        this.jobList = new ArrayList<EmployeeJobBean>();
    }

	@Column(name="place_id")  
	String placeId = "";   
	@Column(name="employee_no")  
	String employeeNo = "";
	@Column(name="template_id")
	String templateId;
	@Column(name="template_name")
	String templateName;   
	@Column(name="department_id")
	String departmentId;
	@Column(name="hired_on")  
	Timestamp hiredOn;   
	@Column(name="terminated_on")  
	Timestamp terminatedOn;  

	public String getPlaceId() { return this.placeId; }
	public String getEmployeeNo() { return this.employeeNo; }
    public String getTemplateId() { return this.templateId; }
    public String getTemplateName() { return this.templateName; }
    public String getDepartmentId() { return this.departmentId; }
    public Timestamp getHiredOn() { return this.hiredOn; }
    public Timestamp getTerminatedOn() { return this.terminatedOn; }

    public void setPlaceId(String val) { this.placeId = val; }
    public void setEmployeeNo(String val) { this.employeeNo = val; }
    public void setTemplateId(String val) { this.templateId = val; } 
    public void setTemplateName(String val) { this.templateName = val; } 
    public void setDepartmentId(String val) { this.departmentId = val; } 
    public void setHiredOn(Timestamp val) { this.hiredOn = val; } 
    public void setTerminatedOn(Timestamp val) { this.terminatedOn = val; } 
    
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
