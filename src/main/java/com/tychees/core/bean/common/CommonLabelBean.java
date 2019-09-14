package com.tychees.core.bean.common;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class CommonLabelBean
	extends CommonSearchableBean
{
	@Column(name="keyword")
    String keyword = "";
	@Column(name="position")
    int position = 0;
	@Column(name="relevance")
    double relevance = 0.0;

    public String getKeyword() { return this.keyword; }
    public int getPosition() { return this.position; }
    public double getRelevance() { return this.relevance; }
    
    public void setKeyword(String val) { this.keyword = val; }
    public void setPosition(int val) { this.position = val; }
    public void setRelevance(double val) { this.relevance = val; }
}
