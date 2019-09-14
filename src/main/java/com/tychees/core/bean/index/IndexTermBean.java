package com.tychees.core.bean.index;

import java.util.UUID;

import javax.jdo.annotations.IdentityType; 
import javax.jdo.annotations.PersistenceCapable;
import javax.persistence.Column;  
import javax.persistence.Entity;  
import javax.persistence.Table;

import com.tychees.core.bean.BeanSuperClass;  
  
@Entity  
@Table(name="index_term_table")  
@PersistenceCapable(identityType=IdentityType.DATASTORE, detachable="false") 
public class IndexTermBean 
	extends BeanSuperClass
	implements java.io.Serializable 
{  
	private static final long serialVersionUID = 8539335464954385814L;

    public IndexTermBean() 
    {
        this(UUID.randomUUID().toString());
    }
    
    public IndexTermBean(String id) 
    {
    	super();
        this.setId(id);
    }

	@Column(name="place_id")  
	String placeId = "";   
	@Column(name="bean_id")  
	String beanId = "";   
	@Column(name="bean_class_name")  
	String beanClassName = ""; 
	@Column(name="bean_display_name")  
	String beanDisplayName = "";  
	@Column(name="term")  
	String term = "";   
	@Column(name="frequency")  
	int frequency = 0;   
	@Column(name="position")  
	String position = "";  
	@Column(name="synopsys")
	String synopsys = "";
	@Column(name="view_bean")
	String viewBean = "";

	public String getPlaceId() { return this.placeId; }
	public String getBeanId() { return this.beanId; }
	public String getBeanClassName() { return this.beanClassName; }
	public String getBeanDisplayName() { return this.beanDisplayName; }
    public String getTerm() { return this.term; }
    public int getFrequency() { return this.frequency; }
    public String getPosition() { return this.position; }
    public String getSynopsys() { return this.synopsys; }
    public String getViewBean() { return this.viewBean; }

    public void setPlaceId(String val) { this.placeId = val; }
    public void setBeanId(String val) { this.beanId = val; }
    public void setBeanClassName(String val) { this.beanClassName = val; }
    public void setBeanDisplayName(String val) { this.beanDisplayName = val; }
    public void setTerm(String val) { this.term = val; }
    public void setFrequency(int val) { this.frequency = val; } 
    public void setPosition(String val) { this.position = val; }
    public void setSynopsys(String val) { this.synopsys = val; }
    public void setViewBean(String val) { this.viewBean = val; }
    
    /**
     * Format: key1:val1;key2:val2;key3:val3;
     */ 
    public void addSynopsys(String val) 
    {
    	if (this.synopsys==null)
    		this.synopsys = val;
    	else
    		this.synopsys += val + ";";
    }
    
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
