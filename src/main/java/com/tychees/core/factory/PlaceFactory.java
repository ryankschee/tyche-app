package com.tychees.core.factory;

import java.sql.Timestamp;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.place.PlacePropertiesBean;
import com.tychees.core.bean.user.UserBean;
import com.tychees.core.constants.PropertiesConstants;

@Component
public class PlaceFactory {

	@Autowired
	PropertiesConstants PROPERTIES_CONSTANTS;
	
	public PlacePropertiesBean createPlaceProperties(PlaceBean placeObj, UserBean userObj, String groupName, String propKey, String propName, String propVal, int seqno) {
		if (placeObj == null)
			return null;
		
		PlacePropertiesBean newObj = new PlacePropertiesBean();
		newObj.setCreatedBy(userObj.getId());
		newObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
		newObj.setGroupName(groupName);
		newObj.setPlaceId(placeObj.getId());
		newObj.setPropContent("");
		newObj.setPropKey(propKey);
		newObj.setPropName(propName);
		newObj.setPropSeqno(seqno);
		newObj.setPropType(PROPERTIES_CONSTANTS.PROP_TYPE_TEXT);
		newObj.setPropValue(propVal);
				
		return newObj;
	} // .end of createPlaceProperties
}
