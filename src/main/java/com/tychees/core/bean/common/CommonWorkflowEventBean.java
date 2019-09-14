package com.tychees.core.bean.common;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import com.tychees.core.bean.BeanSuperClass;

@MappedSuperclass
public abstract class CommonWorkflowEventBean
	extends BeanSuperClass
{
	@Column(name="seqno")
    int seqno;
    @Column(name="event_key")
    String eventKey = "";
	@Column(name="event_title")
	String eventTitle = "";
	@Column(name="event_description")
	String eventDescription = "";
    @Column(name="tracked_on")
    Timestamp trackedOn;
	@Column(name="tracked_by")  
	String trackedBy = ""; 
	
    public int getSeqno() { return this.seqno; }
    public String getEventKey() { return this.eventKey; }
    public String getEventTitle() { return this.eventTitle; }
    public String getEventDescription() { return this.eventDescription; }
    public Timestamp getTrackedOn() { return this.trackedOn; }
    public String getTrackedBy() { return this.trackedBy; }
    
    public void setSeqno(int val) { this.seqno = val; }
    public void setEventKey(String val) { this.eventKey = getSafeString(val); }
    public void setEventTitle(String val) { this.eventTitle = getSafeString(val); }
    public void setEventDescription(String val) { this.eventDescription = getSafeString(val); }
    public void setTrackedOn(Timestamp val) { this.trackedOn = val; }
    public void setTrackedBy(String val) { this.trackedBy = getSafeString(val); }
}
