package com.tychees.core.constants;

import org.springframework.stereotype.Component;

@Component
public class BillingConstants 
	implements java.io.Serializable
{
	private final static long serialVersionUID = 1467880004586236216L;
	
	public BillingConstants() {}
	
	// BUCKET STATS
	public final String BUCKET_STATUS_AVAILABLE							= "AVAILABLE";
	public final String BUCKET_STATUS_RESERVED							= "RESERVED";
	public final String BUCKET_STATUS_SERVING							= "SERVING";
	public final String BUCKET_STATUS_UNDER_PAID						= "UNDER PAID";
	public final String BUCKET_STATUS_FULLY_PAID						= "FULLY PAID";
	public final String BUCKET_STATUS_CLOSE   						    = "CLOSE";
	public final String BUCKET_STATUS_DELETED  						    = "DELETED";
	
	// BILLING STATE
	public final String WORKFLOW_EVENTKEY_QUOTATION_NEW					= "eventKey_QUOTATION_NEW";
	public final String WORKFLOW_EVENTKEY_QUOTATION_OPEN				= "eventKey_QUOTATION_OPEN";
	public final String WORKFLOW_EVENTKEY_NEW							= "eventKey_NEW";
	public final String WORKFLOW_EVENTKEY_OPEN							= "eventKey_OPEN";
	public final String WORKFLOW_EVENTKEY_PAYMENT						= "eventKey_PAYMENT";
	public final String WORKFLOW_EVENTKEY_PAID							= "eventKey_PAID";
	public final String WORKFLOW_EVENTKEY_OVERPAID						= "eventKey_OVERPAID";
	public final String WORKFLOW_EVENTKEY_CLOSED						= "eventKey_CLOSED";
	public final String WORKFLOW_EVENTKEY_DELETED						= "eventKey_DELETED";
	public final String WORKFLOW_EVENTKEY_RECORD_CREATED				= "eventKey_RECORD_CREATED";
	public final String WORKFLOW_EVENTKEY_RECORD_UPDATED				= "eventKey_RECORD_UPDATED";
	public final String WORKFLOW_EVENTKEY_RECORD_DELETED				= "eventKey_RECORD_DELETED";

	public final String WORKFLOW_EVENTDESC_QUOTATION_NEW				= "New Quotation";
	public final String WORKFLOW_EVENTDESC_QUOTATION_OPEN				= "Open Quotation";
	public final String WORKFLOW_EVENTDESC_NEW							= "New Billing";
	public final String WORKFLOW_EVENTDESC_OPEN							= "Open Billing";
	public final String WORKFLOW_EVENTDESC_PAYMENT						= "Payment Made";
	public final String WORKFLOW_EVENTDESC_PAID							= "Paid Billing";
	public final String WORKFLOW_EVENTDESC_OVERPAID						= "Overpaid Billing";
	public final String WORKFLOW_EVENTDESC_CLOSED						= "Closed Billing";
	public final String WORKFLOW_EVENTDESC_DELETED						= "Deleted Billing";
	public final String WORKFLOW_EVENTDESC_RECORD_CREATED				= "Record Created";
	public final String WORKFLOW_EVENTDESC_RECORD_UPDATED				= "Record Updated";
	public final String WORKFLOW_EVENTDESC_RECORD_DELETED				= "Record Deleted";
	
	// PAYMENT STATUS
	public final String PAYMENT_STATUS_VOID								= "void";
	
	// PAYMENT METHOD
	public final String PAYMENT_METHOD_CASH								= "Cash";
	public final String PAYMENT_METHOD_CREDIT_CARD						= "Credit Card";
	public final String PAYMENT_METHOD_CHEQUE							= "Cheque";
	public final String PAYMENT_METHOD_VOUCHER							= "Voucher";
	
	// CREDIT CARD TYPE
	public final String CREDIT_CARD_TYPE_VISA							= "creditCardTypeVisa";
	public final String CREDIT_CARD_TYPE_MASTER							= "creditCardTypeMaster";
	public final String CREDIT_CARD_TYPE_AMEX							= "creditCardTypeAmex";
	public final String CREDIT_CARD_TYPE_DINERS_CLUB					= "creditCardTypeDinersClub";
	public final String CREDIT_CARD_TYPE_DISCOVER						= "creditCardTypeDiscover";
	public final String CREDIT_CARD_TYPE_JCB							= "creditCardTypeJcb";
	public final String CREDIT_CARD_TYPE_MYDEBIT						= "creditCardTypeMyDebit";
	
	// PAYMENT FIELD
	public final String PAYMENT_FIELD_CREDIT_CARD_TYPE					= "paymentFieldCreditCardType";
	public final String PAYMENT_FIELD_CREDIT_CARD_NUMBER				= "paymentFieldCreditCardNumber";
	public final String PAYMENT_FIELD_CREDIT_CARD_EXPIRY_DATE_MONTH		= "paymentFieldCreditCardExpiryDateMonth";
	public final String PAYMENT_FIELD_CREDIT_CARD_EXPIRY_DATE_YEAR		= "paymentFieldCreditCardExpiryDateYear";
	public final String PAYMENT_FIELD_CREDIT_CARD_SECURITY_CODE			= "paymentFieldCreditCardSecurityCode";
	public final String PAYMENT_FIELD_CREDIT_CARD_NAME					= "paymentFieldCreditCardName";
	public final String PAYMENT_FIELD_CREDIT_CARD_BANK  			    = "paymentFieldCreditCardBank";

	public final String PAYMENT_FIELD_CHEQUE_NUMBER						= "paymentFieldChequeNumber";
	public final String PAYMENT_FIELD_CHEQUE_ISSUE_DATE					= "paymentFieldChequeIssueDate";
	public final String PAYMENT_FIELD_CHEQUE_NAME						= "paymentFieldChequeName";
	public final String PAYMENT_FIELD_CHEQUE_BANK						= "paymentFieldChequeBank";
}
