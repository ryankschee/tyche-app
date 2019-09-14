function bil002_paymentPanel_show() {
	$('#bil002_tablePanel').hide();
	$('#bil002_cartPanel').hide();
	$('#bil002_paymentPanel').show();
	
	// Update UI
	bil002_paymentPanel_updateUI_menubar();
	bil002_paymentPanel_updateUI_bucketList();
	bil002_paymentPanel_updateUI_billingList(true);
	bil002_paymentPanel_updateUI_billingLineList();
} // .end of bil002_paymentPanel_show

function bil002_paymentPanel_updateUI_menubar() {
	// Mark UI is updating in process
	var ui_updating = true;
	
	if (global_billingObj == null) {
		$('#bil002_billingNo').val('-');
		$('#bil002_customerName').val('-');
		$('#bil002_billingDate').val('');
						
		$('#bil002_billingNo').attr('disabled', true);
		$('#bil002_customerName').attr('disabled', true);
		$('#bil002_billingDate').attr('disabled', true);
		
		$('#bil002_showCustomerPropertiesButton').addClass('btn-grey');
		$('#bil002_showCustomerPropertiesButton').removeClass('btn-primary');
		$('#bil002_searchCustomerButton').addClass('btn-grey');
		$('#bil002_searchCustomerButton').removeClass('btn-primary');
		$('#bil002_showScheduleButton').addClass('btn-grey');
		$('#bil002_showScheduleButton').removeClass('btn-primary');
		$('#bil002_printBillingButton').addClass('btn-grey');
		$('#bil002_printBillingButton').removeClass('btn-primary');
		$('#bil002_deleteBillingButton').addClass('btn-grey');
		$('#bil002_deleteBillingButton').removeClass('btn-danger');		
	}
	else {
		$('#bil002_billingNo').val(global_billingObj.billingNo);
		$('#bil002_customerName').val(global_billingObj.customerName);
		if (global_billingObj.billingDate != null) {
			$('#bil002_billingDate').val(tycheesDateTime_getFormattedDate_ddMMyyyy(global_billingObj.billingDate));
			//$('#bil002_billingDate').datepicker('setDate', tycheesDateTime_getFormattedDate_ddMMyyyy(global_billingObj.billingDate));
		} else {
			$('#bil002_billingDate').val('');
			//$('#bil002_billingDate').datepicker('setDate', new Date());
		}		

		$('#bil002_billingNo').attr('disabled', false);
		$('#bil002_customerName').attr('disabled', false);
		$('#bil002_billingDate').attr('disabled', false);
		
		
		$('#bil002_showCustomerPropertiesButton').addClass('btn-primary');
		$('#bil002_showCustomerPropertiesButton').removeClass('btn-grey');
		$('#bil002_searchCustomerButton').addClass('btn-primary');
		$('#bil002_searchCustomerButton').removeClass('btn-grey');
		$('#bil002_showScheduleButton').addClass('btn-primary');
		$('#bil002_showScheduleButton').removeClass('btn-grey');
		$('#bil002_printBillingButton').addClass('btn-primary');
		$('#bil002_printBillingButton').removeClass('btn-grey');
		$('#bil002_deleteBillingButton').addClass('btn-danger');
		$('#bil002_deleteBillingButton').removeClass('btn-grey');	
	}
	
	// Mark UI has finished updating.
	ui_updating = false;
	
	// On date change > Event API: http://bootstrap-datepicker.readthedocs.io/en/latest/events.html
	$('#bil002_billingDate').datepicker().on('changeDate', function(e) {
		if (ui_updating)
			return false;
		
		if (global_billingObj == null) {
			sweetAlert("Oops...", "Please select a billing before select date. Thanks!", "error");
			return false;
		}
		
		// e.date is UTC
		global_billingObj.billingDate = tycheesDateTime_convertUTCDateToLocalDate(e.date).getTime();
		// Save billing
		bil002_saveBilling();
    });
} // .end of bil002_paymentPanel_updateUI_menubar

function bil002_paymentPanel_updateUI_billingList(dataFromServer) {

	//$('#bil002_paymentPanel_billingList_header').html(global_billingBucketObj.bucketName + ': Billings');
	$('#bil002_paymentPanel_billingList_header').html('Billings');
	
	// Show/hide
	$('#bil002_paymentPanel_billingList').hide();
	$('#bil002_paymentPanel_billingList_spinner').show();
	
	if (dataFromServer) {
		// Prepare request body
		var requestBody = {
			'appName': APP_NAME_POS,
			'bucketId': global_billingBucketObj.id,
			'fullBean': false
		};
		
		var params = new Object();
		
		// Call API
		tycheesdb_api_getBillingsByBucket(requestBody, bil002_paymentPanel_updateUI_billingList_postHandler, params);
	} else {
		var result = new Object();
		result.billingList = global_billingList;
		
		bil002_paymentPanel_updateUI_billingList_postHandler(true, result, new Object());
	}
} // .end of bil002_paymentPanel_updateUI_billingList

function bil002_paymentPanel_updateUI_billingList_postHandler(success, responseObj, params) {
	
	if (!success)
		return false;
	
	global_billingList = responseObj.billingList;
	
	// Sorting
	global_billingList.sort(function(a, b) {
		if (a.billingNo < b.billingNo) return -1;
		if (a.billingNo > b.billingNo) return 1;
		return 0;
	});

	$('#bil002_paymentPanel_billingList').empty();
	$.each(global_billingList, function(i, billingObj) {
		
		if (Cached_isDeletedBean(billingObj))
			return true;
		
		var edgeStyle = 'danger-element';	// success-element, warning-element, info-element, danger-element
		var status = 'UNPAID';
		var statusIcon = 'btn-danger';
		
		if (billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_PAID) {
			edgeStyle = 'success-element';
			status = 'PAID';
			statusIcon = 'btn-primary';
		}
		if (billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_OVERPAID) {
			edgeStyle = 'warning-element';
			status = 'OVERPAID';
			statusIcon = 'btn-warning';
		}
		
		var selectedBgcolor = 'background-color:#FFFFFF;';
		var selectedFontWeight = '';
		if (global_billingObj != null && global_billingObj.id == billingObj.id) {
			selectedBgcolor = 'background-color:#DDD;';
			selectedFontWeight = 'font-weight:bold;';
		}
		
		var htmlLines = '';
		htmlLines += '<li id="billingList-' + billingObj.id + '" class="' + edgeStyle + '" style="cursor:pointer;' + selectedBgcolor + '" onclick="bil002_paymentPanel_onclick_showBilling(this, \'' + billingObj.id + '\');">';
		htmlLines += '<span style="font-size:12pt;' + selectedFontWeight + '">';
		htmlLines += billingObj.billingNo;
		htmlLines += '</span>';
		htmlLines += '<div class="agile-detail">';
		htmlLines += '<span class="pull-right btn btn-xs ladda-button ' + statusIcon + '" data-style="zoom-in">' + status + '</span>';
		htmlLines += $.trim(global_currencySign) + ' ' + Number(billingObj.totalAmount).toFixed(2);
		htmlLines += '</div>';
		htmlLines += '</li>';
		
		$('#bil002_paymentPanel_billingList').append(htmlLines);
	});
	
	// Show/hide
	$('#bil002_paymentPanel_billingList').show();
	$('#bil002_paymentPanel_billingList_spinner').hide();
} // .end of bil002_paymentPanel_updateUI_billingList_postHandler

function bil002_paymentPanel_onclick_showBilling(selectorElement, billingId) {
	var found = false;
	$.each(global_billingList, function(i, billingObj) {
		if (billingId == billingObj.id) {
			global_billingObj = billingObj;
			found = true; 
		}
	});
	
	if (found) {
		var params = new Object(); 
		params.laddaElement = $($(selectorElement).find('.ladda-button')[0]).ladda();	
		// Show progress icon
		params.laddaElement.ladda('start');
		
		// Prepare request body
		var requestBody = {
			'appName': APP_NAME_POS,
			'billingId': global_billingObj.id,
			'fullBean': true
		};
		
		// Call API
		tycheesdb_api_getBillingById(requestBody, bil002_paymentPanel_onclick_showBilling_postHandler, params);
	}
} // .end of bil002_paymentPanel_onclick_showBilling

function bil002_paymentPanel_onclick_showBilling_postHandler(success, responseObj, params) {

	// Hide progress icon
	params.laddaElement.ladda('stop');
	
	if (!success)
		return false;
	
	// Set as global billing object
	global_billingObj = responseObj.billingObj;
	
	// Update UI
	bil002_paymentPanel_updateUI_menubar();
	bil002_paymentPanel_updateUI_billingList(false);
	bil002_paymentPanel_updateUI_billingLineList();
} // .end of bil002_paymentPanel_onclick_showBilling_postHandler

function bil002_paymentPanel_updateUI_bucketList() {
	// Update name of bucket
	$('#bil002_paymentPanel_bucketList_header_name').html(global_billingBucketObj.bucketName);	
	// Show/hide
	$('#bil002_paymentPanel_bucketList_spinner').show();
	$('#bil002_paymentPanel_bucketList_content').hide();

	$("#bil002_paymentPanel_bucketList_dataTable").DataTable().clear().draw();
	if (global_billingBucketObj != null) {
		var totalAmount = 0;
		$.each(global_billingBucketObj.lineList, function(i, lineObj) {

			if (Cached_isDeletedBean(lineObj))
				return true;

			// Calculate amount
			totalAmount = totalAmount + (lineObj.billableAmount * lineObj.quantity);
			
			// COL #1
			var htmlLines_col1 = '';
			if (lineObj.addToBilling) {
				htmlLines_col1 += '<span style="text-decoration: line-through;">';
				htmlLines_col1 += lineObj.itemName;
				htmlLines_col1 += '</span>';
			}
			else {
				htmlLines_col1 += lineObj.itemName;
			}

			// COL #2
			var htmlLines_col2 = '';
			htmlLines_col2 += lineObj.billableAmount;

			// COL #3
			var htmlLines_col3 = '';
			htmlLines_col3 += lineObj.quantity;

			// COL #4
			var htmlLines_col4 = '';
			if (lineObj.addToBilling) {
				htmlLines_col4 += '<span class="pull-right" style="font-style:italic;">' + lineObj.billingNo + '</span>';
			}
			else {
				htmlLines_col4 += '<span class="pull-right">';
				htmlLines_col4 += '<button class="btn btn-xs btn-info ladda-button" data-style="zoom-in" style="margin-right:3px;" onclick="bil002_incrementBucketLine(this,\'' + lineObj.id + '\');"><i class="fa fa-plus fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '<button class="btn btn-xs btn-info ladda-button" data-style="zoom-in" style="margin-right:3px;" onclick="bil002_decrementBucketLine(this,\'' + lineObj.id + '\');"><i class="fa fa-minus fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '<button class="btn btn-xs btn-danger ladda-button" data-style="zoom-in" style="margin-right:3px;" onclick="bil002_removeBucketLine(this,\'' + lineObj.id + '\');"><i class="fa fa-times fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '<button class="btn btn-xs btn-primary ladda-button" data-style="zoom-in" onclick="bil002_paymentPanel_addBucketLineToBilling(this,\'' + lineObj.id + '\');"><i class="fa fa-chevron-right fa-2x" aria-hidden="true"></i></button>';
				htmlLines_col4 += '</span>';
			}

			var rowSet = [];
			rowSet.push(htmlLines_col1);
			rowSet.push(htmlLines_col2);
			rowSet.push(htmlLines_col3);
			rowSet.push(htmlLines_col4);
			//rowSet.push(htmlLines_col5);

			$('#bil002_paymentPanel_bucketList_dataTable').dataTable().fnAddData(rowSet, false);
		});

		$('#bil002_paymentPanel_bucketList_dataTable').DataTable().draw();
		
		// Update Total Amount
		$('#bil002_paymentPanel_bucketList_header_totalAmount').html(global_currencySign + ' ' + Number(totalAmount).toFixed(2));
	}

	$('#bil002_paymentPanel_bucketList_spinner').hide();
	$('#bil002_paymentPanel_bucketList_content').show();
} // .end of bil002_paymentPanel_updateUI_bucketList

function bil002_paymentPanel_updateUI_billingLineList() {
	if (global_billingObj == null) {
		$('#bil002_billableAmount').html(Number('0').toFixed(2));
		$('#bil002_billingSubtotal').html(Number('0').toFixed(2));
		$('#bil002_paymentBalance').html(Number('0').toFixed(2));

		// Reset Tables
		$("#bil002_billingLine_commonPanel").show();
		$("#bil002_billingLine_discountPanel").hide();
		$("#bil002_billingLine_taxPanel").hide();
		$("#bil002_billingLine_commonTable").empty();
		$("#bil002_billingLine_discountTable").empty();
		$("#bil002_billingLine_taxTable").empty();
	}
	else {
		// Recalculate Billing
		billingCommon_calculateBilling(global_billingObj);

		// Calculate total amount paid
		var totalAmountPaid = 0.0;		
		$.each(global_billingObj.paymentList, function(i, paymentObj) {
			if (Cached_isDeletedBean(paymentObj) == true)
				return true;
			if (paymentObj.status == 'void')
				return true;
			
			var paidAmount = paymentObj.changeAmount < 0 ? paymentObj.payingAmount : paymentObj.payingAmount - paymentObj.changeAmount;
			totalAmountPaid += paidAmount;
		});
		
		// Calculate total amount due
		var totalAmountDue = global_billingObj.totalAmount - totalAmountPaid;
		
		// Set billing amounts
		$('#bil002_billableAmount').html(Number(global_billingObj.totalAmount).toFixed(2));
		$('#bil002_billingSubtotal').html(Number(global_billingObj.subTotalAmount).toFixed(2));
		if (global_billingObj.totalAmount > 0 && totalAmountDue == 0) {
			$('#bil002_paymentBalance_currency').hide();
			$('#bil002_paymentBalance').css('color', '#E2FF00');
			$('#bil002_paymentBalance').html('PAID');
		} else {
			$('#bil002_paymentBalance_currency').show();
			$('#bil002_paymentBalance').css('color', '#FFFFFF');
			$('#bil002_paymentBalance').html(Number(global_billingObj.totalAmount - totalAmountPaid).toFixed(2));
		}

		// Reset Tables
		$("#bil002_billingLine_commonPanel").show();
		$("#bil002_billingLine_discountPanel").hide();
		$("#bil002_billingLine_taxPanel").hide();
		$("#bil002_billingLine_commonTable").empty();
		$("#bil002_billingLine_discountTable").empty();
		$("#bil002_billingLine_taxTable").empty();

		var billingRowNo = 1;
		$.each(global_billingObj.lineList, function(index, lineObj) {

			// Skip deleted line object.
			if (Cached_isDeletedBean(lineObj) == true)
				return true;
			// If lineObj has parentLineId, skip it.
			if (lineObj.parentLineId != '')
				return true;

			var quantity_optional = lineObj.quantityOptional;
			var allowable_quantity = lineObj.quantity;
			var quantity_disabledVal = '';
			var totalUnitPrice = 0;
			var percentage = 0;
			var quantity = 0;
			var priceOperator = '';
			var percentageOperator = '';
			var itemModalWindowFn = 'mw008_open'; // default for PRODUCT, SERVICE, EVENT, RAW

			if (lineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
				quantity_disabledVal = 'disabled';
				totalUnitPrice = lineObj.discountAmount;
				percentage = lineObj.discountPercentage;
				quantity = lineObj.quantity;
				priceOperator = '-';
				percentageOperator = '-';
				itemModalWindowFn = 'mw009_open';
			}
			else
			if (lineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
				quantity_disabledVal = 'disabled';
				totalUnitPrice = lineObj.taxAmount;
				percentage = lineObj.taxPercentage;
				quantity = lineObj.quantity;
				priceOperator = '+';
				percentageOperator = '+';
				itemModalWindowFn = 'mw009_open';
			}
			else {
				quantity_disabledVal = '';
				totalUnitPrice = lineObj.billableAmount;
				//percentage = lineObj.percentage;
				percentage = 0;
				quantity = lineObj.quantity;
			}

			var imageUrl = $.trim(lineObj.itemImageUrl);
			if (imageUrl.length == 0) {
				imageUrl = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQ4AAAEOCAMAAABPbwmXAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAFFQTFRFzMzM6enp5+fn8fHx////7u7u3t3e2tra1tXV2djY5OPj9PT0+fn55ubm29vb9/f37Ovr4eDg+Pj409PT4ODg9fX16+vr1tbW5OTk3d3d09LSwU8z7gAACWVJREFUeNrt3dmCqiAABmCVcF/bx/d/0KOCZmYlm6Hn52KmcYr0k10F54AwCg4IwAEOcIADHOAABzjAAQ5wgAMc4AAHOMABDnAggAMc4AAHOMABDnCAAxzgAAc4wAEOcIADHOAwHJLSFQ3JbjlIVEuE0N0nB60lQ7xHjqKWDnSHHLk8R5jujiOrFYK/Nw5SKwV3ZxyhGkdd7IqjUtSooz1xlLVyyPbDkYbqHDXZDUeuQaMO98Lh1lqCvw+OpNYUyl1wRLo4wsJuDhr7k5C9FnhxrS3kNnOUs/VFRLQ2R1dqnKpzxIv6n1rq2EdIbOVwl7UQfK0axhqnqhzpsn0ua82hspMjW9SALGrtgVjJ4S/qX+T6OcwMBalyLGo/ZrWB4FvIkdSWhNzPyuK3HLSq7QphnPyMww1rC0NEf8JhJ0YHkqzOkUS1xaFamcM1URS6Lk26QF23UmvEynd5ZThizak7LmfSd0FjhSRI1+PQ2v3IP1WPaVmt7OH8Mm1E2femZRmt6eH8TsNfuMeJXBJJ1uCg2jAEdjeVOQfhChy6RnEiwQ5pIlFg+eY59BSjMjfykHCN4kOMQ0+PzZfrm2crZBcxDi2NUenLJMIJxDXLoSNxRArd8DQ3nTyEODR06BUvkcSGSw8hDnUN5Zv/xMagK5Mc9G3j0nVdX00jcWOfl0yhX7kk1dPwMclRfW5PfR8CeaNRuPmcMdHgQQxyhF+y57eSLhbslITzXRoRj8wgx/fCKhfV+Nb8rhI1D98cR7KgDRGKFWsLWlZVqjL8FJrjIAsulVKRGrYMZRtTlamyVIDDXVKvR4vH61JfoeWWW8mxPPkTpRb3S7u+CC3kyBcXc7Fac0r+82ty+Eu7NZHymFouOdRgJQdRH2HM5QaibMwslY7x1lyqtv1xUTp7pKniOM48amQdR7moIZ9pGn2WiWdVjmhJezGUrCO/FkGRbRzTE1YsSBz6noWj1nEs6cKlOgqO2aosso5j3KMoou8tKMV7CKlo5bI2x3C/zbu+eqLzQk0oOlq5OkebhjO3epdwo2+9YpVrBZWVHMtrR+ULNaGgrm0cheYLNa5YbrGMI9J9oUYwQss4nuqVVMc1TSLU9LCMgygMcugAtoxDV4P0XWEabYoj0p5XJgmu2hRHpaUr+6HqdjfF4WrrrrzpuCSb4iAaG+izh1hsiiPRez/ETMtuUxwGStKJcbhVDm1PRrkCORAc9nKE6l3APXH44AAHOCTKjhI1C2oW8xzlZjlSE410kZb/f9BnSTfLQQ30aMPt9miNj3eQTXEI7boM8bZGw8KD/sKjEMmAlo2kp5qvOk2Fw21xUO1jx7HQ/RE2X4U7aM8r5cY4npO2hifWt32NVvsVfLrpK/iT+zt8vYmDbo7jObckehOHvzmOyc2glc7EseBShXUczzc/Kk7x8HzfXbZBjsl9pUpjYpPb0sMtckwezfF1ZZVFsvZxTB9YkM8uk2fiom1yTJJHoqdWWbY/FnJMZyWiWlSXpTIbOaYPiVEdGssGk2zkeHkMiKprLLzX30qOl5l4qarG0rsQreR4faZScB6fUnZn7OSYeU5a4CbT8GWehsW1k6UcM4syZdJJS6DtYivHzNQRyyaBDWfmM1qesmzlmJ0T6vuUFbMT0AkMqlnLMT9N0+f5N+dn4xO5fGUvx5u5f8jbIZB8ftovoUraYo6382TNzOMbVuWbubKMzpS1KseHecNS4sZ+O3NY6PuVS9/PxCd4oddqDvVliEQvTdjNUedqCyEIjx1ZzlGHCgurFOLPnZrj0DXNsfSqkDLDrOY4tN3qJrcKQio1yGqOQ9sDGFLzdMplVYOT7B00LrohOvkzjdbJmOoTdMrmGGoeQ3w6W8dwUfYxhaSGMV6uaWjlSGvdofpa6xaxShYVbvUJzXVsYj2z+IMIyRQnuCiNctDaSMiz1z5K04dRvyvX8MTgB4NrGEV+7PKQ+ZqSYWaYg9ZbCsYXFTBRepgLrnGOYkMaMoMJosvVuNvhKFbg0L3OrrkgtbiT+FJXGyk+5IYRJBZC24SH5NoWMsvk5XtNG5KLKMa7LDekOZbOf/+rGlZ+eFpyAda0shZDZlkxVQ65ldpsx1BavDnNrFuVNi8Ph19xtG32srKlmgn9jKqvBe8cEMABDnCAAxzgAAc4wAEOcIADHOAABzjAAQ5wIIADHOAAh3mOq3dtf3nesf1F7kFwf9wlS9p/Hj2ve0/zy2Obaf+i3RoEAfusx8P4Jtv+Izz65vdlvLn5dsJ/DGGInEd3HH9+/ls0cgSO0+6h47Txn50unIejcYLGpNly697i8KhPjnPl+84+0P3JXzoPqsOx+fPIPtFtvbA/h83Nt3v8xxCGyPv4yLB7h/lv0cwR9N/nNRKEnB/fNXA4/MhZmmle/B344QVXcj11/2g+PD1vXr/f9w604Q6eNs9wPCJn8Z2c04TjbDh1tGej+z6+k16fCgaOoPlv85pvPzs3fnYDdnjN2abjXR6d6Vt3NK0bS4PXp80zHI/IWXyUUz84iMmyI2Anvf0W2jN0RzfmuDc7HDQ/Hf7vI0/87CAbj/kdpc7pyN9ycu79oY03v3KMIydDglqRo8kc9+5bPHauR/vXc9Dmd/vTYRtvTeI/sYTdWpAmHB+5+hH3XxPxjZVEXvuBM3s92vzC8Yi8j+92mS07jHF4Tea4fOZoT6ZzYkffFYvs7LINHi/ZXna0e9OVbehes4Mab37heEQ+xHdfmaPZh4BxnB779MTRFmDOHzv6Nu+0gufuwJpUcQ0CzjFJxs2bPO/Oy4smOVxZ/OPNU45R5Dw+wku11TKLx+oOcrjwr7r0RcKD469NAIzjPDo/p3EF8bKjJ/7GP47wx9493jzlGEfO45vEvQJHd7SkPYO35mwfb6xWHHO0GYKQcX3aFbfsZ/uOGY52axPOQwHMaoynzVOOceRD6riuzXFkHE2ycNqU3yeOB0ebflhRwTN9I/jXZQHnFLSnmz5ydTCc6b794LEPsP88beYcfXvrKXLnKaX0L6ffYoKjPc0t+qXbs+AybZW2e3FjL25d0TZUmh5rxo6LvuDwXF3zJtiVFyJPmyccT5H3eeqyJsc0ENH5BS6EHGwO6NGCAxzgAAc4wAEOcIADHOAABzjAAQ5wgAMc4EAABzjAAQ5wgAMc4AAHOMABDnCAAxzgAAc4wAEOBHCAAxzgAAc4wAEOcIADHOAAx6bCP2dKrOlAweFbAAAAAElFTkSuQmCC';
			}

			if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_QUOTATION_NEW ||
				global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_QUOTATION_OPEN ||
				global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_NEW ||
				global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_OPEN) {

				var htmlLines = '';
				htmlLines += '<tr id="row-' + lineObj.id + '" class="item tooltip-demo">';
				htmlLines += '<input id="id-' + lineObj.id + '" class="form-control" type="hidden" value="' + lineObj.itemId + '">';
				// COL #1
				htmlLines += '<td style="vertical-align:middle; width:300px;">';
				htmlLines += '<span class="client-avatar" style="padding-right:5px;">';
				htmlLines += '<img alt="image" src="' + imageUrl + '">';
				htmlLines += '</span>';
				htmlLines += '<a id="name-' + lineObj.id + '" data-toggle="tab" style="font-size:11pt;" href="#" class="client-link collapsed" onclick="bil002_billingList_toggle(\'' + lineObj.id + '\');" ondblclick="' + itemModalWindowFn + '(\'' + lineObj.itemId + '\',\'' + lineObj.rowId + '\',\'' + lineObj.id + '\');">';
				htmlLines += lineObj.itemName;
				htmlLines += '</a>';
				htmlLines += '<span id="name-icon-' + lineObj.id + '" style="padding-left:10px;cursor:pointer;" onclick="bil002_billingList_toggle(\'' + lineObj.id + '\');">';
				htmlLines += '<i class="fa fa-caret-down" aria-hidden="true"></i>';
				htmlLines += '</span>';
				htmlLines += '</td>';
				// COL #2
				htmlLines += '<td id="unitprice-' + lineObj.id + '" style="padding:12px 4px 0px 0px;vertical-align:top;width:80px;font-size:10pt;">';
				htmlLines += '<span class="pull-right">';
				htmlLines += priceOperator + Number(totalUnitPrice).toFixed(2);
				htmlLines += '</span>';
				htmlLines += '</td>';
				// COL #3
				htmlLines += '<td id="percentage-' + lineObj.id + '" style="padding:12px 4px 0px 0px;vertical-align:top;width:60px;font-size:10pt;">';
				htmlLines += '<span class="pull-right">';
				htmlLines += percentageOperator + Number(percentage).toFixed(2);
				htmlLines += '</span>';
				htmlLines += '</td>';
				// COL #4
				htmlLines += '<td id="quantity-' + lineObj.id + '" style="padding:12px 4px 0px 0px;vertical-align:top;width:60px;font-size:10pt;">';
				htmlLines += '<span class="pull-right">';
				htmlLines += Number(quantity).toFixed(2);
				htmlLines += '<span>';
				//htmlLines += '<input id="input-quantity-' + lineObj.id + '" type="number" class="form-control" style="width:120px;font-size:10pt;text-align:right;" value="' + quantity + '" disabled>';
				htmlLines += '</td>';
				// COL #5
				//htmlLines += '<td class="contact-type" style="vertical-align:top;padding:13px 0 0 0;text-align:center;">';
				//htmlLines += '<span data-toggle="tooltip" data-placement="top" title="Increment Quantity">';
				//if (quantity_disabledVal == '')
				//	htmlLines += '<i class="fa fa-plus-circle" aria-hidden="true" style="color:#00af00;cursor:pointer;font-size:11pt;" onclick="page_ctrl_incrementQuantity(\'' + lineObj.id + '\',\'' + lineObj.itemId + '\')"></i>';
				//else
				//	htmlLines += '<i class="fa fa-plus-circle" aria-hidden="true" style="cursor:pointer;font-size:11pt;"></i>';
				//htmlLines += '</span>';
				//htmlLines += '</td>';
				// COL #6
				//htmlLines += '<td class="contact-type" style="vertical-align:top;padding:13px 0 0 0;text-align:center;">';
				//htmlLines += '<span data-toggle="tooltip" data-placement="top" title="Decrement Quantity">';
				//if (quantity_disabledVal == '')
				//	htmlLines += '<i class="fa fa-minus-circle" aria-hidden="true" style="color:#ff3737;cursor:pointer;font-size:11pt;" onclick="page_ctrl_decrementQuantity(\'' + lineObj.id + '\',\'' + lineObj.itemId + '\')"></i>';
				//else
				//	htmlLines += '<i class="fa fa-minus-circle" aria-hidden="true" style="cursor:pointer;font-size:11pt;"></i>';
				//htmlLines += '</span>';
				//htmlLines += '</td>';
				// COL #7
				htmlLines += '<td class="contact-type" style="vertical-align:top;padding:13px 0 0 0;text-align:center;">';
				htmlLines += '<span class="pull-right" data-toggle="tooltip" data-placement="top" title="Remove Row">';
				htmlLines += '<i id="removeBillingLine-' + lineObj.id + '" class="fa fa-times" aria-hidden="true" style="cursor:pointer; font-size:14pt; color: #ED5565; padding-left:5px; padding-right:5px;" onclick="bil002_paymentPanel_removeBillingLine(this, \'' + lineObj.id + '\')"></i>';
				htmlLines += '</span>';
				htmlLines += '</td>';

				htmlLines += '</tr>';

				htmlLines += '<tr id="line-drawer-' + lineObj.id + '" style="display:none;">'
				htmlLines += '<td colspan="5">'
				htmlLines += '<div class="col-md-2 col-lg-1">';
				htmlLines += '<div class="row">';
				htmlLines += '<span class="btn btn-xs btn-primary" style="width:100%;" onclick="' + itemModalWindowFn + '(\'' + lineObj.itemId + '\',\'' + lineObj.rowId + '\',\'' + lineObj.id + '\');">';
				htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i>';
				htmlLines += ' EDIT';
				htmlLines += '</span>';
				htmlLines += '</div>';
				htmlLines += '</div>';
				htmlLines += '<div class="col-md-10 col-lg-11">';
				htmlLines += bil002_paymentPanel_updateUI_billingLineList_generateBillingLineContent(lineObj);
				htmlLines += '</div>';
				htmlLines += '</td>'
				htmlLines += '</tr>';

				if (lineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
					$("#bil002_billingLine_discountPanel").show();
					$("#bil002_billingLine_discountTable").append(htmlLines);
				}
				else
				if (lineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
					$("#bil002_billingLine_taxPanel").show();
					$("#bil002_billingLine_taxTable").append(htmlLines);
				}
				else {
					$("#bil002_billingLine_commonTable").append(htmlLines);
				}

				billingRowNo++;
			}
			else {
				var htmlLines = '';
				htmlLines += '<tr id="row-' + lineObj.id + '" class="item tooltip-demo">';
				htmlLines += '<input id="id-' + lineObj.id + '" class="form-control" type="hidden" value="' + lineObj.itemId + '">';
				// COL #1
				htmlLines += '<td style="vertical-align:middle; width:300px;">';
				htmlLines += '<span class="client-avatar" style="padding-right:5px;">';
				htmlLines += '<img alt="image" src="' + imageUrl + '">';
				htmlLines += '</span>';
				htmlLines += '<a id="name-' + lineObj.id + '" data-toggle="tab" style="font-size:11pt;" href="#" class="client-link collapsed" onclick="bil002_billingList_toggle(\'' + lineObj.id + '\');" ondblclick="' + itemModalWindowFn + '(\'' + lineObj.itemId + '\',\'' + lineObj.rowId + '\',\'' + lineObj.id + '\');">';
				htmlLines += lineObj.itemName;
				htmlLines += '</a>';
				htmlLines += '<span id="name-icon-' + lineObj.id + '" style="padding-left:10px;cursor:pointer;" onclick="bil002_billingList_toggle(\'' + lineObj.id + '\');">';
				htmlLines += '<i class="fa fa-caret-down" aria-hidden="true"></i>';
				htmlLines += '</span>';
				htmlLines += '</td>';
				// COL #2
				htmlLines += '<td id="unitprice-' + lineObj.id + '" style="vertical-align:top;font-size:10pt;">';
				htmlLines += '<span class="pull-right">';
				htmlLines += Number(totalUnitPrice).toFixed(2);
				htmlLines += '</span>';
				htmlLines += '</td>';
				// COL #3
				htmlLines += '<td id="percentage-' + lineObj.id + '" style="vertical-align:top;font-size:10pt;">';
				htmlLines += '<span class="pull-right">';
				htmlLines += Number(percentage).toFixed(2);
				htmlLines += '<span>';
				htmlLines += '</td>';
				// COL #4
				htmlLines += '<td id="quantity-' + lineObj.id + '" style="vertical-align:top;font-size:10pt;">';
				htmlLines += '<span class="pull-right">';
				htmlLines += Number(quantity).toFixed(2);
				htmlLines += '<span>';
				htmlLines += '</td>';
				// COL #5
				//htmlLines += '<td class="contact-type" style="vertical-align:top;">';
				//htmlLines += '</td>';
				// COL #6
				//htmlLines += '<td class="contact-type" style="vertical-align:top;">';
				//htmlLines += '</td>';
				// COL #7
				htmlLines += '<td class="contact-type" style="vertical-align:top;">';
				htmlLines += '</td>';
				htmlLines += '</tr>';

				htmlLines += '<tr id="line-drawer-' + lineObj.id + '" style="display:none;">'
				htmlLines += '<td colspan="5">'
				htmlLines += '<div class="col-md-1">';
				htmlLines += '<div class="row">';
				htmlLines += '<span class="btn btn-xs btn-primary" style="width:100%;" onclick="' + itemModalWindowFn + '(\'' + lineObj.itemId + '\',\'' + lineObj.rowId + '\',\'' + lineObj.id + '\');">';
				htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i>';
				htmlLines += ' EDIT';
				htmlLines += '</span>';
				htmlLines += '</div>';
				htmlLines += '</div>';
				htmlLines += '<div class="col-md-11">';
				htmlLines += bil002_paymentPanel_updateUI_billingLineList_generateBillingLineContent(lineObj);
				htmlLines += '</div>';
				htmlLines += '</td>'
				htmlLines += '</tr>';

				if (lineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
					$("#bil002_billingLine_discountPanel").show();
					$("#bil002_billingLine_discountTable").append(htmlLines);
				}
				else
				if (lineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
					//$("#billingLineTableRoot_tax").show();
					//$("#bil002_billingLine_taxTable").append(htmlLines);
				}
				else {
					$("#bil002_billingLine_commonTable").append(htmlLines);
				}

				billingRowNo++;
			}
		});
	}
} // .end of bil002_paymentPanel_updateUI_billingLineList

function bil002_paymentPanel_updateUI_billingLineList_generateBillingLineContent(lineObj) {
	// Item Object
	var htmlLines = '';

	// MANDATORY ---------------------------------------------------------------
	$.each(lineObj.lineList, function(j, childLineObj) {
		if (Cached_isDeletedBean(childLineObj) == true)
			return true;

		if (childLineObj.mandatory == true) {
			htmlLines += '<span style="padding-left:10px;font-weight:bold;">';
			htmlLines += 'Mandatory';
			htmlLines += '</span>';
			htmlLines += '<br>';

			htmlLines += '<ul class="todo-list m-t small-list ui-sortable">';

			return false;
		}
	});

	var mandatoryCount = 0;
	var mandatoryRowNo = 1;
	$.each(lineObj.lineList, function(j, childLineObj) {
		if (Cached_isDeletedBean(childLineObj) == true)
			return true;

		if (childLineObj.mandatory == true) {
			mandatoryCount++;

			var textDecoVal = '';
			var fontIcon = '<i class="fa fa-check-circle-o" aria-hidden="true"></i>';
			if (childLineObj.ignored == true) {
				textDecoVal = 'text-decoration: line-through; color: #FF0000;';
				fontIcon = '<i class="fa fa-circle-o" aria-hidden="true"></i>';
			}

			htmlLines += '<li>';
			htmlLines += fontIcon;
			htmlLines += '<span class="m-l-xs" style="' + textDecoVal + '">' + childLineObj.itemName + '</span>';
			htmlLines += '<small class="label label-primary pull-right">';
			htmlLines += 'Qty: ' + childLineObj.quantity;
			htmlLines += '</small>';
		}
	});

	htmlLines += '</ul>';

	// OPTIONAL ----------------------------------------------------------------
	$.each(lineObj.lineList, function(j, childLineObj) {
		if (Cached_isDeletedBean(childLineObj) == true)
			return true;

		if (childLineObj.mandatory == false) {
			htmlLines += '<span style="padding-left:10px;font-weight:bold;">';
			htmlLines += 'Optional';
			htmlLines += '</span>';
			htmlLines += '<br>';

			htmlLines += '<ul class="todo-list m-t small-list ui-sortable">';

			return false;
		}
	});

	var optionalCount = 0;
	var optionalRowNo = 1;
	$.each(lineObj.lineList, function(j, childLineObj) {
		if (Cached_isDeletedBean(childLineObj) == true)
			return true;

		if (childLineObj.mandatory == false) {
			optionalCount++;

			htmlLines += '<li>';
			htmlLines += '<i class="fa fa-check-circle-o" aria-hidden="true"></i>';
			htmlLines += '<span class="m-l-xs">' + childLineObj.itemName + '</span>';
			htmlLines += '<small class="label label-primary pull-right">';
			htmlLines += 'Qty: ' + childLineObj.quantity;
			htmlLines += '</small>';
		}
	});

	htmlLines += '</ul>';

	// REMARKS -----------------------------------------------------------------
	htmlLines += '<span style="padding-left:10px;font-weight:bold;">Remarks</span>';
	htmlLines += '<div class="well">';
	htmlLines += $.trim(lineObj.remarks) == '' ? '-' : $.trim(lineObj.remarks);
	htmlLines += '</div>';

	return htmlLines;
} // .end of bil002_paymentPanel_updateUI_billingLineList_generateBillingLineContent

/**
 * Event Listener: When user click Right Arrow (>) button, to add bucket line to billing line.
 */
function bil002_paymentPanel_addBucketLineToBilling(buttonElement, bucketLineId) {
	if (global_billingBucketObj == null)
		return false;

	// If no billing object selected
	if (global_billingObj == null) {
		sweetAlert("Oops...", "Please select a billing before add item. Thanks!", "error");
		return false;
	}
	
	// If billing object is PAID / CLOSED / DELETED
	if (global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_PAID || 
		global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_CLOSED ||
		global_billingObj.state == BillingConstants.WORKFLOW_EVENTKEY_DELETED) {
		sweetAlert("Oops...", "This billing is not editable anymore!", "error");
		return false;
	}
	
	// Start Loading
	$(buttonElement).ladda().ladda('start');
	
	$.each(global_billingBucketObj.lineList, function(i, lineObj) {
		if (lineObj.id == bucketLineId) {
			if (lineObj.addToBilling == true)
				return false;

			// Add new billing line
			var billingLineObj = billingBucketCommon_createBillingLine(global_billingObj, lineObj);
			global_billingObj.lineList.push(billingLineObj);

			// Set billing id/no to bucketLine
			lineObj.billingId = global_billingObj.id;
			lineObj.billingNo = global_billingObj.billingNo;
			lineObj.billingLineId = billingLineObj.id;
			lineObj.addToBilling = true;
			
			// Save Billing
			bil002_saveBilling(false);
			// Save Billing
			bil002_saveBucket(true);
			
			// Update UI - bucket line panels
			bil002_sw001_updateUI_tab3();
			bil002_cartPanel_updateUI_bucketList();
			bil002_paymentPanel_updateUI_bucketList();
			// Update UI - billing line panel
			bil002_paymentPanel_updateUI_billingList(false);
			bil002_paymentPanel_updateUI_billingLineList();
		}
	});
	
	// Finish Loading
	$(buttonElement).ladda().ladda('stop');
} // .end of bil002_paymentPanel_addBucketLineToBilling

/**
 * Event Listener: When user click Remove (X) button, to remove billing line back into bucket line.
 */
function bil002_paymentPanel_removeBillingLine(buttonElement, billingLineId) {
	if (global_billingBucketObj == null) {
		tycheesLogger_showToast('error', 'System Error', 'Invalid bucket object.');
		return false;
	}

	// If no billing object selected
	if (global_billingObj == null) {
		tycheesLogger_showToast('error', 'System Error', 'Invalid billing object.');
		return false;
	}

	// Start Loading
	$(buttonElement).ladda().ladda('start');
	
	// Find/Remove billing line object
	var billingLineObj;
	$.each(global_billingObj.lineList, function(i, lineObj) {
		if (lineObj.id == billingLineId) {
			billingLineObj = lineObj;
		}
	});
	if (billingLineObj != null) {
		Cached_deleteBean(billingLineObj);
	}
	
	// Reset bucket line object
	var bucketLineObj;
	$.each(global_billingBucketObj.lineList, function(i, lineObj) {
		if (lineObj.billingLineId == billingLineId) {
			bucketLineObj = lineObj;
		}
	});
	if (bucketLineObj != null) {
		bucketLineObj.billingId = '';
		bucketLineObj.billingNo = '';
		bucketLineObj.billingLineId = '';
		bucketLineObj.addToBilling = false;
	}	
	
	// Save Beans
	bil002_saveBilling(false)
	bil002_saveBucket(true);
	
	// Update UI
	bil002_sw001_updateUI_tab3();
	bil002_cartPanel_updateUI_bucketList();
	bil002_paymentPanel_updateUI_bucketList();
	bil002_paymentPanel_updateUI_billingList(false);
	bil002_paymentPanel_updateUI_billingLineList();	
} // .end of bil002_paymentPanel_removeBillingLine

/**
 * Create new billing, add under current bucket
 */
function bil002_paymentPanel_addNewBilling() {
	
	if (global_billingObj == null) {
		bil002_paymentPanel_addNewBilling_postHandler();
	} else {
		swal({
			title: "New Billing?",
			text: "Current billing will be saved and you are going to create new billing?",
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",
			confirmButtonText: "Yes, create it!",
			cancelButtonText: "No, cancel plx!",
			closeOnConfirm: true,
			closeOnCancel: true
		},
		function(isConfirm){
			if (isConfirm) {
				bil002_paymentPanel_addNewBilling_postHandler();
			} 
		});
	}
} // .end of bil002_paymentPanel_addNewBilling

function bil002_paymentPanel_addNewBilling_postHandler() {
	// Save existing, if any
	bil002_saveBilling();
	
	// Create new billing
	bil002_ctrl_createNewBilling(global_billingBucketObj.id);	
	// Add to cache
	global_billingList.push(global_billingObj);
	// Save existing, if any
	bil002_saveBilling();
	// Update next billing no
	consoleCommon_updateNextBillingNo();
	// Update UI
	bil002_paymentPanel_updateUI_menubar();
	bil002_paymentPanel_updateUI_billingList(false);
	bil002_paymentPanel_updateUI_billingLineList();
} // .end of bil002_paymentPanel_addNewBilling_postHandler

function bil002_paymentPanel_editBillingNo() {
	if (global_billingObj == null)
		return false;
	
	mw_editBillingNo_show(global_billingObj, bil002_paymentPanel_editBillingNo_saveCallbackFn);	
} // .end of bil002_menuPanel_editBillingNo

function bil002_paymentPanel_editBillingNo_saveCallbackFn(billingObj)
{
	if (billingObj == null)
		return false;
	
    // Auto-save Billing
	bil002_saveBilling();	
} // .end of bil002_paymentPanel_editBillingNo_saveCallbackFn

/**
 * Open Search Customer Modal Window
 */
function bil002_paymentPanel_searchCustomer() {
	if (global_billingObj == null)
		return false;
	
	mw_customerSearch_show(
		bil002_paymentPanel_searchCustomer_callbackFn, 
		null, 
		global_billingBucketObj.customerNo);	
} // .end of bil002_paymentPanel_searchCustomer

function bil002_paymentPanel_searchCustomer_callbackFn(customerObj) {
	if (customerObj != null && global_billingObj != null) {
		global_billingObj.customerId = customerObj.id;
		global_billingObj.customerName = tycheesBean_person_getFullName(customerObj);
		// Update UI
		bil002_paymentPanel_updateUI_menubar();
		// Save billing
		bil002_saveBilling();
	}
} // .end of bil002_searchCustomer_callbackFn

function bil002_paymentPanel_showCustomerProfile() {
	if (global_billingObj == null)
		return false;
	
	if ($.trim(global_billingObj.customerId)=='')
		return false;
	
	mw_customerProfile_show(
		bil002_paymentPanel_showCustomerProfile_callbackFn,
		null,
		global_billingObj.customerId);
} // .end of bil002_paymentPanel_showCustomerProfile

function bil002_paymentPanel_showCustomerProfile_callbackFn() {
	
} // .end of bil002_paymentPanel_showCustomerProfile_callbackFn

function bil002_paymentPanel_showCustomerProperties() {
	if (global_billingObj == null)
		return false;
	
	mw006_show();
} // .end of bil002_showCustomerProperties

function bil002_paymentPanel_showSchedule() {
	if (global_billingObj == null)
		return false;
	
	mw007_show();
} // .end of bil002_paymentPanel_showSchedule

function bil002_paymentPanel_showPaymentTerminal() {
	if (global_billingObj == null)
		return false;
	
	mw_paymentTerminal_show(
		bil002_paymentPanel_showPaymentTerminal_payCallbackFn,
		bil002_paymentPanel_showPaymentTerminal_deletePaymentCallbackFn,
		bil002_paymentPanel_showPaymentTerminal_closeCallbackFn,
		null,
		global_billingObj);
} // .end of bil002_paymentPanel_showPaymentTerminal

function bil002_paymentPanel_showPaymentTerminal_payCallbackFn(payingAmount, changedAmount, balancedAmount) {	
	// Update Cache
	Cached_updateBilling(global_billingObj, global_billingList);	
	// Save to DB
	bil002_saveBilling();
	// Update UI
	bil002_paymentPanel_updateUI_billingList(false);
	bil002_paymentPanel_updateUI_billingLineList();
} // .end of bil002_paymentPanel_showPaymentTerminal_payCallbackFn

function bil002_paymentPanel_showPaymentTerminal_deletePaymentCallbackFn() {
	// Save to DB
	bil002_saveBilling();
	// Update UI
	bil002_paymentPanel_updateUI_billingList(false);
	bil002_paymentPanel_updateUI_billingLineList();
} // .end of bil002_paymentPanel_showPaymentTerminal_deletePaymentCallbackFn

function bil002_paymentPanel_showPaymentTerminal_closeCallbackFn() {
	// Save to DB
	bil002_saveBilling();
	// Update UI
	bil002_paymentPanel_updateUI_billingList(false);
	bil002_paymentPanel_updateUI_billingLineList();
} // .end of bil002_paymentPanel_showPaymentTerminal_payCallbackFn

function bil002_paymentPanel_deleteBilling(callerElement) {
	if (global_billingObj == null)
		return false;
	// Check any payment made	
	if (global_billingObj.paymentList.length > 0) {
		swal("Delete Not Allowed!", "You cannot delete billing with minimum one payment.", "error");
		return false;
	}
	
	// Show Progress
	$(callerElement).ladda().ladda('start');
	
	swal({
	  title: "Are you sure?",
	  text: "Do you want to delete this billing?",
	  type: "warning",
	  showCancelButton: true,
	  confirmButtonColor: "#DD6B55",
	  confirmButtonText: "Yes, delete it!",
	  cancelButtonText: "No",
	  closeOnConfirm: true,
	  closeOnCancel: true
	},
	function(isConfirm){
		if (isConfirm) {
			// Remove all billing lines back to bucket
			$.each(global_billingObj.lineList, function(i, lineObj) {
				$('#removeBillingLine-'+lineObj.id).click();
			});
			
			// Update Place
			Cached_deleteBean(global_billingObj);	
			// Save Place
			bil002_saveBilling(true);

			// Remove billing object from list
			Cached_deleteBillingById(global_billingObj.id, global_billingList);
			// Set billing to null
			global_billingObj = null;
			// Update UI
			bil002_paymentPanel_updateUI_menubar();
			bil002_paymentPanel_updateUI_bucketList();
			bil002_paymentPanel_updateUI_billingList(false);
			bil002_paymentPanel_updateUI_billingLineList();
			// Show Message
	    	swal("Delete Success!", "Your table reservation has been cancelled.", "success");
		} 		

		// Hide Progress
		$(callerElement).ladda().ladda('stop');
	});
} // .end of bil002_paymentPanel_deleteBilling

function bil002_paymentPanel_printBilling(callerElement) {
	if (global_billingObj == null)
		return false;
	
	mw_printBilling_show(global_billingObj);
} // .end of bil002_paymentPanel_printBilling

/**
 * Show/Hide billing line details.
 */
function bil002_billingList_toggle(lineId) {
	var itemRowCollapsed = $('#name-' + lineId).hasClass('collapsed');

	if (itemRowCollapsed) {
		$('#name-' + lineId).removeClass('collapsed');
		$('#name-icon-' + lineId).html('<i class="fa fa-caret-up" aria-hidden="true"></i>');

		// Show Content
		$('#line-drawer-' + lineId).show();
	}
	else {
		$('#name-' + lineId).addClass('collapsed');
		$('#name-icon-' + lineId).html('<i class="fa fa-caret-down" aria-hidden="true"></i>');

		// Hide Content
		$('#line-drawer-' + lineId).hide();
	}
} // .end of bil002_billingList_toggle
