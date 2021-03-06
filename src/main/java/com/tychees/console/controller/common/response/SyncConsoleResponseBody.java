package com.tychees.console.controller.common.response;

import java.util.List;

import com.tychees.core.bean.billing.BillingBean;
import com.tychees.core.bean.billing.BillingDeliveryBean;
import com.tychees.core.bean.billing.BillingLineBean;
import com.tychees.core.bean.billing.BillingPaymentBean;
import com.tychees.core.bean.billing.BillingPaymentPropertiesBean;
import com.tychees.core.bean.billing.BillingPropertiesBean;
import com.tychees.core.bean.billing.BillingWorkflowBean;
import com.tychees.core.bean.billing.BillingWorkflowEventBean;
import com.tychees.core.bean.common.CommonCalendarBean;
import com.tychees.core.bean.common.CommonCalendarEventBean;
import com.tychees.core.bean.common.CommonTemplateBean;
import com.tychees.core.bean.common.CommonTemplatePropertiesBean;
import com.tychees.core.bean.customer.CustomerAddressBean;
import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.customer.CustomerContactBean;
import com.tychees.core.bean.customer.CustomerEmailBean;
import com.tychees.core.bean.customer.CustomerProfileBean;
import com.tychees.core.bean.customer.CustomerProfilePropertiesBean;
import com.tychees.core.bean.customer.CustomerPropertiesBean;
import com.tychees.core.bean.document.DocumentBean;
import com.tychees.core.bean.document.DocumentPropertiesBean;
import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.inventory.InventoryCategoryPropertiesBean;
import com.tychees.core.bean.inventory.InventoryItemBean;
import com.tychees.core.bean.inventory.InventoryItemComponentBean;
import com.tychees.core.bean.inventory.InventoryItemImageBean;
import com.tychees.core.bean.inventory.InventoryItemPropertiesBean;
import com.tychees.core.bean.inventory.InventoryTransactionBean;
import com.tychees.core.bean.inventory.InventoryTransactionLineBean;
import com.tychees.core.bean.place.PlaceAccessBean;
import com.tychees.core.bean.place.PlaceAccessPropertiesBean;
import com.tychees.core.bean.place.PlaceAddressBean;
import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.place.PlaceContactBean;
import com.tychees.core.bean.place.PlaceDocumentBean;
import com.tychees.core.bean.place.PlaceDocumentPropertiesBean;
import com.tychees.core.bean.place.PlaceImageBean;
import com.tychees.core.bean.place.PlaceLabelBean;
import com.tychees.core.bean.place.PlaceOperatingHourBean;
import com.tychees.core.bean.place.PlacePropertiesBean;
import com.tychees.core.bean.place.PlaceRoleBean;
import com.tychees.core.bean.place.PlaceSettingsBean;
import com.tychees.core.bean.place.PlaceWorkflowBean;
import com.tychees.core.bean.place.PlaceWorkflowEventBean;
import com.tychees.core.bean.user.UserAccessRightBean;
import com.tychees.core.bean.user.UserActionBean;
import com.tychees.core.bean.user.UserBean;
import com.tychees.core.bean.user.UserPropertiesBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.constants.BillingConstants;
import com.tychees.core.constants.CustomerConstants;
import com.tychees.core.constants.DocumentConstants;
import com.tychees.core.constants.InventoryConstants;
import com.tychees.core.constants.PlaceConstants;
import com.tychees.core.constants.UserConstants;
import com.tychees.core.controller.AbstractWebResponseBody;
import com.tychees.core.bean.user.UserRoleBean;

public class SyncConsoleResponseBody 
	extends AbstractWebResponseBody 
{
	// Persistence Objects
	public List<BillingBean> billingList;
	public List<DocumentBean> documentList;
	public List<CustomerBean> customerList;
	public List<InventoryCategoryBean> categoryList;
	public List<InventoryItemBean> itemList;
	public List<InventoryTransactionBean> transactionList;
	public List<PlaceBean> placeList;
	public List<UserBean> userList;
	
	// Constants Objects
	public AppConstants appConstants;
	public BillingConstants billingConstants;
	public CustomerConstants customerConstants;
	public DocumentConstants documentConstants;
	public InventoryConstants inventoryConstants;
	public PlaceConstants placeConstants;
	public UserConstants userConstants;
	
	// New Plain Object
	public BillingBean newBilling;
	public BillingDeliveryBean newBillingDelivery;
	public BillingLineBean newBillingLine;
	public BillingPaymentBean newBillingPayment;
	public BillingPaymentPropertiesBean newBillingPaymentProperties;
	public BillingPropertiesBean newBillingProperties;
	public BillingWorkflowBean newBillingWorkflow;
	public BillingWorkflowEventBean newBillingWorkflowEvent;
	public CommonCalendarBean newCommonCalendar;
	public CommonCalendarEventBean newCommonCalendarEvent;
	public CommonTemplateBean newCommonTemplate;
	public CommonTemplatePropertiesBean newCommonTemplateProperties;
	public CustomerBean newCustomer;
	public CustomerAddressBean newCustomerAddress;
	public CustomerContactBean newCustomerContact;
	public CustomerEmailBean newCustomerEmail;
	public CustomerProfileBean newCustomerProfile;
	public CustomerProfilePropertiesBean newCustomerProfileProperties;
	public CustomerPropertiesBean newCustomerProperties;
	public DocumentBean newDocument;
	public DocumentPropertiesBean newDocumentProperties;
	public InventoryCategoryBean newCategory;
	public InventoryCategoryPropertiesBean newCategoryProperties;
	public InventoryItemBean newItem;
	public InventoryItemComponentBean newItemComponent;
	public InventoryItemImageBean newItemImage;
	public InventoryItemPropertiesBean newItemProperties;
	public InventoryTransactionBean newTransaction;
	public InventoryTransactionLineBean newTransactionLine;
	public PlaceBean newPlace;
	public PlaceAccessBean newPlaceAccess;
	public PlaceAccessPropertiesBean newPlaceAccessProperties;
	public PlaceAddressBean newPlaceAddress;
	public PlaceContactBean newPlaceContact;
	public PlaceDocumentBean newPlaceDocument;
	public PlaceDocumentPropertiesBean newPlaceDocumentProperties;
	public PlaceImageBean newPlaceImage;
	public PlaceLabelBean newPlaceLabel;
	public PlaceOperatingHourBean newPlaceOperatingHour;
	public PlacePropertiesBean newPlaceProperties;
	public PlaceRoleBean newPlaceRole;
	public PlaceSettingsBean newPlaceSettings;
	public PlaceWorkflowBean newPlaceWorkflow;
	public PlaceWorkflowEventBean newPlaceWorkflowEvent;
	public UserBean newUser;
	public UserActionBean newUserAction;
	public UserSessionBean newUserSession;
	public UserPropertiesBean newUserProperties;
	public UserAccessRightBean newUserAccessRight;
	public UserRoleBean newUserRole;
}
