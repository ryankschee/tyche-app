package com.tychees.core.bean.common;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import com.tychees.core.bean.BeanSuperClass;

@MappedSuperclass
public abstract class CommonImageBean
	extends BeanSuperClass
{
    @Column(name="name")
	String name = "";
    @Column(name="url")
    String url = "";
    @Column(name="type")
    String type = "";
    @Column(name="alt_text")
    String altText = "";
    @Column(name="long_desc")
    String longDesc = "";
    @Column(name="width")
    int width = 0;
    @Column(name="height")
    int height = 0;
    @Column(name="base64", columnDefinition="mediumtext")
    String base64 = "";
    @Column(name="file_name")
    String fileName = "";
    @Column(name="file_type")
    String fileType = "";
    @Column(name="file_extension")
    String fileExtension = "";
    @Column(name="file_size")
    int fileSize = 0;
    @Column(name="seqno")
    int seqno = 0;

	public String getName() { return (this.name==null||this.name.length()==0) ? "noname" : this.name; }
    public String getUrl() { return this.url; }
    public String getType() { return this.type; }
    public String getAltText() { return this.altText; }
    public String getLongDesc() { return this.longDesc; }
    public int getWidth() { return this.width; }
    public int getHeight() { return this.height; }
    public String getBase64() { return this.base64; }
    public String getFileName() { return this.fileName; }
    public String getFileType() { return this.fileType; }
    public String getFileExtension() { return this.fileExtension; }
    public int getFileSize() { return this.fileSize; }
    public int getSeqno() { return this.seqno; }
    
    public void setName(String val) { this.name = getSafeString(val); }    
    public void setUrl(String val) { this.url = getSafeString(val); }
    public void setType(String val) { this.type = getSafeString(val); }
    public void setAltText(String val) { this.altText = getSafeString(val); }
    public void setLongDesc(String val) { this.longDesc = getSafeString(val); }    
    public void setWidth(int val) { this.width = val; }
    public void setHeight(int val) { this.height = val; }
    public void setBase64(String val) { this.base64 = getSafeString(val); }
    public void setFileName(String val) { this.fileName = getSafeString(val); }
    public void setFileType(String val) { this.fileType = getSafeString(val); }
    public void setFileExtension(String val) { this.fileExtension = getSafeString(val); }
    public void setFileSize(int val) { this.fileSize = val; }
    public void setSeqno(int val) { this.seqno = val; }
}