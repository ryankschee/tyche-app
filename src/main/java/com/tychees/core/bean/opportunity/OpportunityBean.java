
package com.tychees.core.bean.opportunity;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;

@Entity  
@Table(name="opportunity_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class OpportunityBean 
	extends BeanSuperClass
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 3830939997529360912L;

    public OpportunityBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public OpportunityBean(String id) 
    {
    	super();  
        this.setId(id);
    }

	@Column(name="place_id")  
	String placeId = "";  
	@Column(name="customer_id")  
	String customerId = ""; 
	@Column(name="employee_id")  
	String employeeId = "";   
	@Column(name="opportunity_no")  
	String opportunityNo = "";   
	@Column(name="name")  
	String name = "";   
	@Column(name="estimation_value")
	double estimationValue;
	@Column(name="state_code")  
	String stateCode = "";   
	@Column(name="state_desc")  
	String stateDesc = "";   

	public String getPlaceId() { return this.placeId; }
	public String getCustomerId() { return this.customerId; }
	public String getEmployeeId() { return this.employeeId; }
    public String getOpportunityNo() { return this.opportunityNo; }
    public String getName() { return this.name; }
    public double getEstimationValue() { return this.estimationValue; }
    public String getStateCode() { return this.stateCode; }
    public String getStateDesc() { return this.stateDesc; }

    public void setPlaceId(String val) { this.placeId = val; }
    public void setCustomerId(String val) { this.customerId = val; }
    public void setEmployeeId(String val) { this.employeeId = val; }
    public void setOpportunityNo(String val) { this.opportunityNo = val; } 
    public void setName(String val) { this.name = val; } 
    public void setEstimationValue(double val) { this.estimationValue = val; } 
    public void setStateCode(String val) { this.stateCode = val; } 
    public void setStateDesc(String val) { this.stateDesc = val; } 
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getName();
	}
}
