package com.tychees.core.constants;

import org.springframework.stereotype.Component;

@Component
public class ModuleConstants 
	implements java.io.Serializable
{
	private final static long serialVersionUID = 1467880004586236216L;
	
	public ModuleConstants() {}
	
	// MODULES
	public final String MODULE_GENERAL									= "ModuleGeneral";
	public final String MODULE_DASHBOARD								= "ModuleDashboard";
	public final String MODULE_BILLING									= "ModuleBilling";
	public final String MODULE_CALENDAR									= "ModuleCalendar";
	public final String MODULE_INVENTORY								= "ModuleInventory";
	public final String MODULE_RELATION									= "ModuleRelation";
	public final String MODULE_REPORTS									= "ModuleReports";
	public final String MODULE_SETTINGS									= "ModuleSettings";
	
    public final String MODULE_DASHBOARD_PROP_KEY                       = "propKeyModuleDashboard";
    public final String MODULE_BILLING_PROP_KEY                         = "propKeyModuleBilling";
    public final String MODULE_CALENDAR_PROP_KEY                        = "propKeyModuleCalendar";
    public final String MODULE_INVENTORY_PROP_KEY                       = "propKeyModuleInventory";
    public final String MODULE_RELATION_PROP_KEY                        = "propKeyModuleRelation";
    public final String MODULE_REPORTS_PROP_KEY                         = "propKeyModuleReports";
    public final String MODULE_SETTINGS_PROP_KEY                        = "propKeyModuleSettings";
    
    // SUB-MODULE: Billing
    public final String MODULE_BILLING_SUB_GENERAL                      = "ModuleBillingSubGeneral";
    public final String MODULE_BILLING_SUB_TAXATION                     = "ModuleBillingSubTaxation";
    public final String MODULE_BILLING_SUB_ORDER                        = "ModuleBillingSubOrder";
    public final String MODULE_BILLING_SUB_SALES_INVOICE                = "ModuleBillingSubSalesInvoice";
    public final String MODULE_BILLING_SUB_TAX_INVOICE                  = "ModuleBillingSubTaxInvoice";
    public final String MODULE_BILLING_SUB_PAYMENT_RECEIPT              = "ModuleBillingSubPaymentReceipt";
    public final String MODULE_BILLING_SUB_PAYMENT_VOUCHER              = "ModuleBillingSubPaymentVoucher";
    public final String MODULE_BILLING_SUB_QUOTATION                    = "ModuleBillingSubQuotation";
    public final String MODULE_BILLING_SUB_DELIVERY_ORDER               = "ModuleBillingSubDeliveryOrder";
    public final String MODULE_BILLING_SUB_BACKOFFICE                   = "ModuleBillingSubBackoffice";
    public final String MODULE_BILLING_SUB_PAYMENT                      = "ModuleBillingSubPayment";
    public final String MODULE_BILLING_SUB_CUSTOMER_SEARCH              = "ModuleBillingSubCustomerSearch";
    public final String MODULE_BILLING_SUB_ORDER_SEARCH                 = "ModuleBillingSubOrderSearch";
	public final String MODULE_BILLING_SUB_WORKFLOW				        = "ModuleBillingSubWorkflow";
	public final String MODULE_BILLING_SUB_SCHEDULE				        = "ModuleBillingSubSchedule";
	
	// SUB-MODULE: Relation
	public final String MODULE_RELATION_SUB_CUSTOMER					= "ModuleRelationSubCustomer";
	public final String MODULE_RELATION_SUB_EMPLOYEE					= "ModuleRelationSubEmployee";
	
	// SUB-MODULE: Inventory
	public final String MODULE_INVENTORY_SUB_GENERAL					= "ModuleInventorySubGeneral";
	public final String MODULE_INVENTORY_SUB_CATEGORY					= "ModuleInventorySubCategory";
	public final String MODULE_INVENTORY_SUB_ITEM						= "ModuleInventorySubItem";
}
