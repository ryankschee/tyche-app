package com.tychees.core.bean.place;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;
import javax.persistence.Transient;

import com.tychees.core.bean.common.CommonCalendarBean;
import com.tychees.core.bean.common.CommonGeolocationBean;
import com.tychees.core.bean.common.CommonTemplateBean;

@Entity  
@Table(name="place_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class PlaceBean 
    extends CommonGeolocationBean
    implements java.io.Serializable, Comparable<PlaceBean>
{
    private static final long serialVersionUID = 1467880004586236216L;

    @Transient
    public List<PlaceAccessBean> accessList;
    @Transient
    public List<PlaceAddressBean> addressList;
    @Transient
    public List<PlaceDocumentBean> documentList;
    @Transient
    public List<PlaceDocumentTemplateBean> documentTemplateList;
    @Transient
    public List<PlaceContactBean> contactList;
    @Transient
    public List<PlaceImageBean> imageList;
    @Transient
    public List<PlaceLabelBean> labelList;
    @Transient
    public List<PlaceModuleBean> moduleList;
    @Transient
    public List<PlaceOperatingHourBean> operatingHourList;
    @Transient
    public List<PlacePropertiesBean> propertiesList;
    @Transient
    public List<PlaceRoleBean> roleList;
    @Transient
    public List<PlaceSettingsBean> settingsList;
    @Transient
    public List<PlaceWorkflowBean> workflowList;
    @Transient
    public List<CommonTemplateBean> templateList;
    @Transient
    public List<CommonCalendarBean> calendarList;
    @Transient
    public List<PlaceLayoutBean> layoutList;
    
    public PlaceBean() 
    {
    	this(UUID.randomUUID().toString());
    }
    
    public PlaceBean(String id)
    {
        super();
    	this.setId(id);
    	
    	this.accessList = new ArrayList<PlaceAccessBean>();
    	this.addressList = new ArrayList<PlaceAddressBean>();
    	this.contactList = new ArrayList<PlaceContactBean>();
    	this.documentList = new ArrayList<PlaceDocumentBean>();
    	this.documentTemplateList = new ArrayList<PlaceDocumentTemplateBean>();
    	this.imageList = new ArrayList<PlaceImageBean>();
    	this.labelList = new ArrayList<PlaceLabelBean>();
    	this.moduleList = new ArrayList<PlaceModuleBean>();
    	this.operatingHourList = new ArrayList<PlaceOperatingHourBean>();
    	this.propertiesList = new ArrayList<PlacePropertiesBean>();
    	this.roleList = new ArrayList<PlaceRoleBean>();
    	this.settingsList = new ArrayList<PlaceSettingsBean>();
    	this.workflowList = new ArrayList<PlaceWorkflowBean>();
    	this.templateList = new ArrayList<CommonTemplateBean>();
    	this.calendarList = new ArrayList<CommonCalendarBean>();
    	this.layoutList = new ArrayList<PlaceLayoutBean>();
    }

    @Column(name="name")
    String name = "";
    @Column(name="company_name")
    String companyName = "";
    @Column(name="company_registration_no")
    String companyRegistrationNo = "";
    @Column(name="category")
    String category = "";
    @Column(name="subcategory")
    String subcategory = "";
    @Column(name="labels")
    String labels = "";
    @Column(name="description")
    String description = "";
    @Column(name="address")
    String address = "";
    @Column(name="phone")
    String phone = "";
    @Column(name="mobile")
    String mobile = "";
    @Column(name="website")
    String website = "";
    @Column(name="email")
    String email = "";
    @Column(name="logo_image_url")
    String logoImageUrl = "";
    @Column(name="logo_image_width")
    int logoImageWidth = 0;
    @Column(name="logo_image_height")
    int logoImageHeight = 0;
    @Column(name="price_range")
    String priceRange = "";
    @Column(name="rating")
    double rating = 0;
    
    public String getName() { return this.name; }
    public String getCompanyName() { return this.companyName; }
    public String getCompanyRegistrationNo() { return this.companyRegistrationNo; }
    public String getCategory() { return this.category; }
    public String getSubcategory() { return this.subcategory; }
    public String getLabels() { return this.labels; }
    public String getDescription() { return this.description; }
    public String getAddress() { return this.address; }
    public String getPhone() { return this.phone; }
    public String getMobile() { return this.mobile; }
    public String getWebsite() { return this.website; }
    public String getEmail() { return this.email; }
    public String getLogoImageUrl() { return this.logoImageUrl; }
    public int getLogoImageWidth() { return this.logoImageWidth; }
    public int getLogoImageHeight() { return this.logoImageHeight; }
    public String getPriceRange() { return this.priceRange; }
    public double getRating() { return this.rating; }
            
    public void setName(String val) { this.name = getSafeString(val); }   
    public void setCompanyName(String val) { this.companyName = getSafeString(val); }    
    public void setCompanyRegistrationNo(String val) { this.companyRegistrationNo = getSafeString(val); }         
    public void setCategory(String val) { this.category = getSafeString(val); }
    public void setSubcategory(String val) { this.subcategory = getSafeString(val); }
    public void setLabels(String val) { this.labels = getSafeString(val); }
    public void setDescription(String val) { this.description = getSafeString(val); }
    public void setAddress(String val) { this.address = getSafeString(val); }
    public void setPhone(String val) { this.phone = getSafeString(val); }
    public void setMobile(String val) { this.mobile = getSafeString(val); }
    public void setWebsite(String val) { this.website = getSafeString(val); }
    public void setEmail(String val) { this.email = getSafeString(val); }
    public void setLogoImageUrl(String val) { this.logoImageUrl = getSafeString(val); }
    public void setLogoImageWidth(int val) { this.logoImageWidth = val; }
    public void setLogoImageHeight(int val) { this.logoImageHeight = val; }
    public void setPriceRange(String val) { this.priceRange = getSafeString(val); }
    public void setRating(double val) { this.rating = val; }
    
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

	public int compareTo(PlaceBean o) {
		return this.getName().compareTo(o.getName());
	}
}
