package com.tychees.core.service.criteria;

public class DocumentSearchCriteria
	extends AbstractSearchCriteria
{
    private String documentId;
    
    public DocumentSearchCriteria(String placeId) 
    {
        super(placeId);
    }
    
    public String getDocumentId() { return this.documentId; }
    
    public void setDocumentId(String val) { this.documentId = val; }    
}