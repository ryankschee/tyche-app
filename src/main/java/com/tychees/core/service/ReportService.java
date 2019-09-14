package com.tychees.core.service;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;  
import org.springframework.stereotype.Service;  
import org.springframework.transaction.annotation.Transactional;

import com.tychees.core.bean.report.ReportByCustomerOverviewBean;
import com.tychees.core.bean.report.ReportByInventoryTopSellingItemsBean;
import com.tychees.core.bean.report.ReportByInventoryZeroSoldItemsBean;
import com.tychees.core.dao.report.ReportDAO;
  
@Service("reportService")  
public class ReportService 
{ 
	@Autowired  
	ReportDAO reportDao;
	
	private final static Logger LOGGER = Logger.getLogger(ReportService.class.getName());
	
	//--------------------------------------------------------------------------
	
	@Transactional  
	public List<ReportByCustomerOverviewBean> getByCustomerOverview(String placeId, long startTime, long endTime, List<String> typeList, List<String> stateList, List<String> areaList, List<String> cityList) 
	{  
		try 
		{
			List<ReportByCustomerOverviewBean> resultList 
				= reportDao.getReportByCustomerOverview(placeId, startTime, endTime, typeList, stateList, areaList, cityList);			
			return resultList;
		}
		catch (Exception e)
		{
			LOGGER.severe(e.getMessage());
			return new ArrayList<ReportByCustomerOverviewBean>();
		}
	} // .end of getReportByCustomerOverview	
	
	//--------------------------------------------------------------------------
	
	@Transactional  
	public List<ReportByInventoryTopSellingItemsBean> getByInventoryTopSellingItems(String placeId, long startTime, long endTime, int itemCount, List<String> itemTypeList) 
	{  
		try 
		{
			List<ReportByInventoryTopSellingItemsBean> resultList 
				= reportDao.getByInventoryTopSellingItems(placeId, startTime, endTime, itemCount, itemTypeList);			
			return resultList;
		}
		catch (Exception e)
		{
			LOGGER.severe(e.getMessage());
			return new ArrayList<ReportByInventoryTopSellingItemsBean>();
		}
	} // .end of getByInventoryTopSellingItems
	
	//--------------------------------------------------------------------------
	
	@Transactional  
	public List<ReportByInventoryZeroSoldItemsBean> getByInventoryZeroSoldItems(String placeId, long startTime, long endTime, int itemCount, List<String> itemTypeList) 
	{  
		try 
		{
			List<ReportByInventoryZeroSoldItemsBean> resultList 
				= reportDao.getByInventoryZeroSoldItems(placeId, startTime, endTime, itemCount, itemTypeList);			
			return resultList;
		}
		catch (Exception e)
		{
			LOGGER.severe(e.getMessage());
			return new ArrayList<ReportByInventoryZeroSoldItemsBean>();
		}
	} // .end of getByInventoryZeroSoldItems
}
