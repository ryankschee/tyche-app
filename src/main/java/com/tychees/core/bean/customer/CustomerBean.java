
package com.tychees.core.bean.customer;

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
@Table(name="customer_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class CustomerBean 
	extends CommonPersonBean
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 3830939997529360912L;

    @Transient
    public List<CustomerAddressBean> addressList;
    @Transient
    public List<CustomerContactBean> contactList;
    @Transient
    public List<CustomerEmailBean> emailList;
    @Transient
    public List<CustomerProfileBean> profileList;
    @Transient
    public List<CustomerPropertiesBean> propertiesList;
    
    public CustomerBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public CustomerBean(String id) 
    {
    	super();  
        this.setId(id);
        
        this.addressList = new ArrayList<CustomerAddressBean>();
        this.contactList = new ArrayList<CustomerContactBean>();
        this.emailList = new ArrayList<CustomerEmailBean>();
        this.profileList = new ArrayList<CustomerProfileBean>();
        this.propertiesList = new ArrayList<CustomerPropertiesBean>();
    }

	@Column(name="user_id")  
	String userId = "";   
	@Column(name="place_id")  
	String placeId = "";   
	@Column(name="customer_no")
	String customerNo;
	@Column(name="template_id")
	String templateId;
	@Column(name="template_name")
	String templateName;
	@Column(name="last_billing_id")
	String lastBillingId;
	@Column(name="last_billing_no")
	String lastBillingNo;
	@Column(name="employee_id")
	String employeeId;
	@Column(name="employee_name")
	String employeeName;

	public String getUserId() { return this.userId; }
    public String getPlaceId() { return this.placeId; }
    public String getCustomerNo() { return this.customerNo; }
    public String getTemplateId() { return this.templateId; }
    public String getTemplateName() { return this.templateName; }
    public String getLastBillingId() { return this.lastBillingId; }
    public String getLastBillingNo() { return this.lastBillingNo; }
    public String getEmployeeId() { return this.employeeId; }
    public String getEmployeeName() { return this.employeeName; }
    
    public void setUserId(String val) { this.userId = val; }
    public void setPlaceId(String val) { this.placeId = val; } 
    public void setCustomerNo(String val) { this.customerNo = val; } 
    public void setTemplateId(String val) { this.templateId = val; } 
    public void setTemplateName(String val) { this.templateName = val; } 
    public void setLastBillingId(String val) { this.lastBillingId = val; } 
    public void setLastBillingNo(String val) { this.lastBillingNo = val; } 
    public void setEmployeeId(String val) { this.employeeId = val; }
    public void setEmployeeName(String val) { this.employeeName = val; }
    
	@Override
	public String getBeanName() 
	{
		return this.getClass().getName();
	}
	
	@Override
	public String getDisplayName() 
	{
		return this.getFirstName() + " " + this.getLastName();
	}
}
