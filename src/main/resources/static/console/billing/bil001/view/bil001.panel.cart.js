
function bil001_cartPanel_show() {
	if (global_billingObj == null) {
		$("#bil001_cartPanel_billingDiscountTableRoot").hide();
		$("#bil001_cartPanel_billingTaxTableRoot").hide();

		$("#bil001_cartPanel_billingLineTable").empty();
		$("#bil001_cartPanel_billingDiscountTable").empty();
		$("#bil001_cartPanel_billingTaxTable").empty();
	} else {
		bil001_cartPanel_updateUI();
	}
} // .end of bil001_cartPanel_show

/**
 * Reload UI of billing line(s) from global_billingObj.
 */
function bil001_cartPanel_updateUI() {
	$("#bil001_cartPanel_billingLineTable").empty();
	$("#bil001_cartPanel_billingDiscountTableRoot").hide();
	$("#bil001_cartPanel_billingDiscountTable").empty();
	$("#bil001_cartPanel_billingTaxTableRoot").hide();
	$("#bil001_cartPanel_billingTaxTable").empty();

	var billingRowNo = 1;

	// Sort
	global_billingObj.lineList.sort(function(a, b) {
		return a.seqno - b.seqno;
	});
	
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

		if (bil001_isBillingEditable()) {

			var htmlLines = '';
			htmlLines += '<tr id="row-' + lineObj.id + '" class="item tooltip-demo">';
			htmlLines += '<input id="id-' + lineObj.id + '" class="form-control" type="hidden" value="' + lineObj.itemId + '">';
			// COL #1
			htmlLines += '<td style="vertical-align:middle; width:300px;">';
			htmlLines += '<span class="client-avatar" style="padding-right:5px;">';
			htmlLines += '<img alt="image" src="' + imageUrl + '">';
			htmlLines += '</span>';
			htmlLines += '<a id="name-' + lineObj.id + '" data-toggle="tab" style="font-size:11pt;" href="#" class="client-link collapsed" onclick="bil001_cartPanel_toggleBillingLine(\'' + lineObj.id + '\');" ondblclick="' + itemModalWindowFn + '(\'' + lineObj.itemId + '\',\'' + lineObj.rowId + '\',\'' + lineObj.id + '\');">';
			htmlLines += lineObj.itemName;
			htmlLines += '</a>';
			htmlLines += '<span id="name-icon-' + lineObj.id + '" style="padding-left:10px;cursor:pointer;" onclick="bil001_cartPanel_toggleBillingLine(\'' + lineObj.id + '\');">';
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
			htmlLines += percentageOperator + Number(percentage).toFixed(2) + '%';
			htmlLines += '</span>';
			htmlLines += '</td>';
			// COL #4
			var maxAttr = 'max="' + allowable_quantity + '"';
			if (tycheesUtil_getBooleanValue(quantity_optional) == true)
				maxAttr = '';
			htmlLines += '<td id="' + lineObj.id + '" style="padding:4px 0 0 0;vertical-align:top;width:120px;">';
			htmlLines += '<input id="input-quantity-' + lineObj.id + '" type="number" class="form-control" style="width:120px;font-size:10pt;text-align:right;" onchange="page_ctrl_onQuantityValueChanged(\'' + lineObj.id + '\',\'' + lineObj.itemId + '\')" value="' + Number(quantity).toFixed(2) + '" step="any" min="1" ' + maxAttr + ' ' + quantity_disabledVal + '>';
			htmlLines += '</td>';
			// COL #5
			htmlLines += '<td class="contact-type" style="vertical-align:top;padding:13px 0 0 0;text-align:center;">';
			htmlLines += '<span data-toggle="tooltip" data-placement="top" title="Increment Quantity">';
			if (quantity_disabledVal == '')
				htmlLines += '<i class="fa fa-plus-circle" aria-hidden="true" style="color:#00af00;cursor:pointer;font-size:11pt;" onclick="page_ctrl_incrementQuantity(\'' + lineObj.id + '\',\'' + lineObj.itemId + '\')"></i>';
			else
				htmlLines += '<i class="fa fa-plus-circle" aria-hidden="true" style="cursor:pointer;font-size:11pt;"></i>';
			htmlLines += '</span>';
			htmlLines += '</td>';
			// COL #6
			htmlLines += '<td class="contact-type" style="vertical-align:top;padding:13px 0 0 0;text-align:center;">';
			htmlLines += '<span data-toggle="tooltip" data-placement="top" title="Decrement Quantity">';
			if (quantity_disabledVal == '')
				htmlLines += '<i class="fa fa-minus-circle" aria-hidden="true" style="color:#ff3737;cursor:pointer;font-size:11pt;" onclick="page_ctrl_decrementQuantity(\'' + lineObj.id + '\',\'' + lineObj.itemId + '\')"></i>';
			else
				htmlLines += '<i class="fa fa-minus-circle" aria-hidden="true" style="cursor:pointer;font-size:11pt;"></i>';
			htmlLines += '</span>';
			htmlLines += '</td>';
			// COL #7
			htmlLines += '<td class="contact-type" style="vertical-align:top;padding:13px 0 0 0;text-align:center;">';
			htmlLines += '<span data-toggle="tooltip" data-placement="top" title="Remove Row">';
			htmlLines += '<i class="fa fa-times" aria-hidden="true" style="cursor:pointer;font-size:11pt;" onclick="page_ctrl_deleteBillingLine(\'' + lineObj.id + '\')"></i>';
			htmlLines += '</span>';
			htmlLines += '</td>';

			htmlLines += '</tr>';

			// Line Drawer: contain detailed info of item
			htmlLines += '<tr id="line-drawer-' + lineObj.id + '" style="display:none;">'
			htmlLines += '<td colspan="7">'
			htmlLines += '<div class="col-md-2 col-lg-1">';
			htmlLines += '<div class="row">';
			if (bil001_isBillingEditable())
				htmlLines += '<span class="btn btn-xs btn-primary" style="width:100%;" onclick="' + itemModalWindowFn + '(\'' + lineObj.itemId + '\',\'' + lineObj.rowId + '\',\'' + lineObj.id + '\');">';
			else
				htmlLines += '<span class="btn btn-xs btn-white" style="width:100%;">';
			htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i>';
			htmlLines += ' EDIT';
			htmlLines += '</span>';
			htmlLines += '</div>';
			htmlLines += '</div>';
			htmlLines += '<div class="col-md-10 col-lg-11">';
			htmlLines += bil001_cartPanel_generateBillingLineContent(lineObj);
			htmlLines += '</div>';
			htmlLines += '</td>'
			htmlLines += '</tr>';

			if (lineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
				$("#bil001_cartPanel_billingDiscountTableRoot").show();
				$("#bil001_cartPanel_billingDiscountTable").append(htmlLines);
			}
			else
			if (lineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
				$("#bil001_cartPanel_billingTaxTableRoot").show();
				$("#bil001_cartPanel_billingTaxTable").append(htmlLines);
			}
			else {
				$("#bil001_cartPanel_billingLineTable").append(htmlLines);
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
			htmlLines += '<a id="name-' + lineObj.id + '" data-toggle="tab" style="font-size:11pt;" href="#" class="client-link collapsed" onclick="bil001_cartPanel_toggleBillingLine(\'' + lineObj.id + '\');" ondblclick="' + itemModalWindowFn + '(\'' + lineObj.itemId + '\',\'' + lineObj.rowId + '\',\'' + lineObj.id + '\');">';
			htmlLines += lineObj.itemName;
			htmlLines += '</a>';
			htmlLines += '<span id="name-icon-' + lineObj.id + '" style="padding-left:10px;cursor:pointer;" onclick="bil001_cartPanel_toggleBillingLine(\'' + lineObj.id + '\');">';
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
			htmlLines += Number(percentage).toFixed(2) + '%';
			htmlLines += '<span>';
			htmlLines += '</td>';
			// COL #4
			htmlLines += '<td id="quantity-' + lineObj.id + '" style="vertical-align:top;font-size:10pt;">';
			htmlLines += '<span class="pull-right">';
			htmlLines += Number(quantity).toFixed(2);
			htmlLines += '<span>';
			htmlLines += '</td>';
			// COL #5
			htmlLines += '<td class="contact-type" style="vertical-align:top;">';
			htmlLines += '</td>';
			// COL #6
			htmlLines += '<td class="contact-type" style="vertical-align:top;">';
			htmlLines += '</td>';
			// COL #7
			htmlLines += '<td class="contact-type" style="vertical-align:top;">';
			htmlLines += '</td>';
			htmlLines += '</tr>';

			htmlLines += '<tr id="line-drawer-' + lineObj.id + '" style="display:none;">'
			htmlLines += '<td colspan="7">'
			htmlLines += '<div class="col-md-1">';
			htmlLines += '<div class="row">';
			if (bil001_isBillingEditable())
				htmlLines += '<span class="btn btn-xs btn-primary" style="width:100%;" onclick="' + itemModalWindowFn + '(\'' + lineObj.itemId + '\',\'' + lineObj.rowId + '\',\'' + lineObj.id + '\');">';
			else
				htmlLines += '<span class="btn btn-xs btn-white" style="width:100%;">';
			htmlLines += '<i class="fa fa-pencil" aria-hidden="true"></i>';
			htmlLines += ' EDIT';
			htmlLines += '</span>';
			htmlLines += '</div>';
			htmlLines += '</div>';
			htmlLines += '<div class="col-md-11">';
			htmlLines += bil001_cartPanel_generateBillingLineContent(lineObj);
			htmlLines += '</div>';
			htmlLines += '</td>'
			htmlLines += '</tr>';

			if (lineObj.itemType == InventoryConstants.ITEM_TYPE_DISCOUNT) {
				$("#bil001_cartPanel_billingDiscountTableRoot").show();
				$("#bil001_cartPanel_billingDiscountTable").append(htmlLines);
			}
			else
			if (lineObj.itemType == InventoryConstants.ITEM_TYPE_TAX) {
				//$("#bil001_cartPanel_billingTaxTableRoot").show();
				//$("#bil001_cartPanel_billingTaxTable").append(htmlLines);
			}
			else {
				$("#bil001_cartPanel_billingLineTable").append(htmlLines);
			}

			billingRowNo++;
		}
	});

	bil001_paymentPanel_show();
} // .end of bil001_cartPanel_updateUI

function bil001_cartPanel_generateBillingLineContent(lineObj) {
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
} // .end of bil001_cartPanel_generateBillingLineContent

function bil001_cartPanel_toggleBillingLine(lineId) {
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
} // .end of bil001_cartPanel_toggleBillingLine

function bil001_cartPanel_onCartItemReorder(rowId, rowList) {
	var drawerList = [];
    var drawerIdList = [];
    
    // Get drawer rows and keep them inside list 
    $.each(rowList, function(i, row) {
    	if (row.startsWith('line-drawer-')) {
    		drawerList.push( $('#'+row) );
    		drawerIdList.push( row );
    	}
    });
    
    // 1. Re-insert drawer
    // 2. Update seqno
    var seqno = 1;
    $.each(rowList, function(i, row) {
    	if (row.startsWith('row-')) {
    		var itemId = row.substring(4);
    		
    		$.each(drawerIdList, function(j, drawerId) {
    			if (drawerId.endsWith(itemId)) {
    				$(drawerList[j]).insertAfter('#'+row);
    			}
    		});
    		
    		$.each(global_billingObj.lineList, function(i, lineObj) {
    			// Skip deleted line object.
    			if (Cached_isDeletedBean(lineObj) == true)
    				return true;
    			if (lineObj.id == itemId) {
    				lineObj.seqno = seqno++;
    			}
    		});
    	}
    });
    
 	// Auto-save Billing
	bil001_menuPanel_save();
} // .end of bil001_cartPanel_onCartItemReorder