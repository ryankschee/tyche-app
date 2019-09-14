package com.tychees.core.bean.report;

public class ReportByInventoryZeroSoldItemsBean 
    implements java.io.Serializable
{
	private static final long serialVersionUID = -2492795358937757063L;

    String categoryId = "";
    String categoryName = "";
    String itemId = "";
    String itemName = "";
    double quantity= 0;
    
	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
}
