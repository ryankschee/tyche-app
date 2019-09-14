package com.tychees.core.util;

import org.springframework.stereotype.Component;

import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.place.PlacePropertiesBean;

@Component
public class PlaceUtil {

	public PlacePropertiesBean getPlacePropertiesByKey(PlaceBean placeObj, String propKey) {
		if (placeObj == null || placeObj.propertiesList == null)
			return null;
		
		if (propKey == null || propKey.trim().length() == 0)
			return null;
		
		PlacePropertiesBean foundObj = null;
		for (PlacePropertiesBean propObj : placeObj.propertiesList) {
			if (propObj.getPropKey().equals(propKey.trim())) {
				foundObj = propObj;
			}
		}
		
		return foundObj;
	} // .end of getPlacePropertiesByKey
}
