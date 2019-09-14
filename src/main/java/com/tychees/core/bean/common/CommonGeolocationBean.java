package com.tychees.core.bean.common;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import com.tychees.core.bean.BeanSuperClass;

@MappedSuperclass
public abstract class CommonGeolocationBean
    extends BeanSuperClass
{
	@Column(name="latitude")  
	double latitude = 0.0;   
	@Column(name="longitude")  
	double longitude = 0.0;   
	@Column(name="altitude")  
	double altitude = 0.0;   
	@Column(name="accuracy")  
	double accuracy = 0.0;   
    
    public double getLatitude() { return this.latitude; }
    public double getLongitude() { return this.longitude; }
    public double getAltitude() { return this.altitude; }
    public double getAccuracy() { return this.accuracy; }
    
    public void setLatitude(double val) { this.latitude = val; }
    public void setLongitude(double val) { this.longitude = val; }
    public void setAltitude(double val) { this.altitude = val; }
    public void setAccuracy(double val) { this.accuracy = val; }
}