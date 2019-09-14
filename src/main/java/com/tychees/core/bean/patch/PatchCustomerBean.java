package com.tychees.core.bean.patch;

import java.sql.Timestamp;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity  
@Table(name="patch_customer_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PatchCustomerBean 
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 3830939997529360912L;

    public PatchCustomerBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public PatchCustomerBean(String id) 
    {
    	super();  
        this.setId(id);
    }

	@Id  
    @Column(name="id")
    String id = "";
	@Column(name="name")  
	String name = "";   
	@Column(name="housephone")  
	String housephone = "";   
	@Column(name="mobilephone")
	String mobilephone;
	@Column(name="email")
	String email;
	@Column(name="address")
	String address;
	@Column(name="dob")
	Timestamp dob;
	@Column(name="relationship")
	String relationship;
	@Column(name="lastorderid")
	String lastorderid;
	@Column(name="remarks")
	String remarks;
	@Column(name="profilephoto")
	String profilephoto;

	public String getId() { return this.id; }
    public String getName() { return this.name; }
    public String getHousephone() { return this.housephone; }
    public String getMobilephone() { return this.mobilephone; }
    public String getEmail() { return this.email; }
    public String getAddress() { return this.address; }
    public Timestamp getDob() { return this.dob; }
    public String getRelationship() { return this.relationship; }
    public String getLastorderid() { return this.lastorderid; }
    public String getRemarks() { return this.remarks; }
    public String getProfilephoto() { return this.profilephoto; }
    
    public void setId(String val) { this.id = val; }
    public void setName(String val) { this.name = val; } 
    public void setHousephone(String val) { this.housephone = val; } 
    public void setMobilephone(String val) { this.mobilephone = val; } 
    public void setEmail(String val) { this.email = val; } 
    public void setAddress(String val) { this.address = val; } 
    public void setDob(Timestamp val) { this.dob = val; } 
    public void setRelationship(String val) { this.relationship = val; } 
    public void setLastorderid(String val) { this.lastorderid = val; } 
    public void setRemars(String val) { this.remarks = val; } 
    public void setProfilephoto(String val) { this.profilephoto = val; } 
}
