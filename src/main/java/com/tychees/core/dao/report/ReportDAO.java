package com.tychees.core.dao.report;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import org.hibernate.Query;
import org.springframework.stereotype.Component;

import com.tychees.core.bean.customer.CustomerBean;
import com.tychees.core.bean.report.ReportByCustomerOverviewBean;
import com.tychees.core.bean.report.ReportByInventoryTopSellingItemsBean;
import com.tychees.core.bean.report.ReportByInventoryZeroSoldItemsBean;
import com.tychees.core.constants.ExceptionConstants;
import com.tychees.core.dao.AbstractDAO;
import com.tychees.core.dao.DAOException;
  
@Component
public class ReportDAO 
	extends AbstractDAO {  
  
	private final static Logger LOGGER = Logger.getLogger(ReportDAO.class.getName());
	
	@Override
	public String getBeanName() 
	{
		return CustomerBean.class.getSimpleName();
	} // .end of getBeanName
	
	private String concate(String text1, String text2)
	{
		StringBuffer buffer = new StringBuffer();
		if (text1 != null || text1.trim().length() != 0) {
			buffer.append(text1.trim());
		}
		
		if (text2 != null || text2.trim().length() != 0) {
			buffer.append(" ");
			buffer.append(text2.trim());
		}
		
		return buffer.toString();		
	} // .end of concate
	
	public List<ReportByCustomerOverviewBean> getReportByCustomerOverview(String placeId, long startTime, long endTime, List<String> typeList, List<String> stateList, List<String> areaList, List<String> cityList) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(typeList) || isNullOrEmpty(stateList) || isNullOrEmpty(areaList) || isNullOrEmpty(cityList))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			Date startDate = new Date(startTime);
			Date endDate = new Date(endTime);
			
			StringBuilder hql = new StringBuilder();
			hql.append( "select OBJ.id, OBJ.firstName, OBJ.lastName, OBJ.templateName, ADDR.area, ADDR.city, ADDR.state, OBJ.lastBillingNo ");
			hql.append( "from CustomerBean OBJ, CustomerAddressBean ADDR where " );
			hql.append( "OBJ.placeId = :placeId and " );
			hql.append( "OBJ.id = ADDR.customerId and " );
			if (typeList.size() > 0)
				hql.append( "OBJ.templateName in (:typeList) and " );
			if (stateList.size() > 0)
				hql.append( "ADDR.state in (:stateList) and " );
			if (areaList.size() > 0)
				hql.append( "ADDR.area in (:areaList) and " );
			if (cityList.size() > 0)
				hql.append( "ADDR.city in (:cityList) and " );
			hql.append( HQL_CONDITION_EXCLUDE_DELETED );
			hql.append( "group by OBJ.id" );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);	
			if (typeList.size() > 0)
				query.setParameterList("typeList", typeList);
			if (stateList.size() > 0)
				query.setParameterList("stateList", stateList);	
			if (areaList.size() > 0)
				query.setParameterList("areaList", areaList);	
			if (cityList.size() > 0)
				query.setParameterList("cityList", cityList);	
			
			List<ReportByCustomerOverviewBean> resultList = new ArrayList<ReportByCustomerOverviewBean>();
			List<Object[]> listResult = query.list();	
			
			for (Object[] aRow : listResult) {
				String customerId = (String)aRow[0];
				String customerName = concate((String)aRow[1], (String)aRow[2]);
				String customerType = (String)aRow[3];
				String area = (String)aRow[4];
				String city = (String)aRow[5];
				String state = (String)aRow[6];
				String lastBillingNo = (String)aRow[7];
				
				// Search billing info, by customer ID
				StringBuilder hql2 = new StringBuilder();
				hql2.append( "select OBJ.id, OBJ.billingNo, OBJ.totalAmount " );
				hql2.append( "from BillingBean OBJ where " );
				hql2.append( "OBJ.customerId = :customerId and " );
				hql2.append( "OBJ.billingDate BETWEEN :startDate and :endDate " );
				hql2.append( HQL_CONDITION_EXCLUDE_DELETED );
				hql2.append( "order by OBJ.billingDate DESC " );

				Query query2 = this.getSessionFactory().getCurrentSession().createQuery( hql2.toString() );
				query2.setParameter("customerId", customerId);	
				query2.setParameter("startDate", startDate);
				query2.setParameter("endDate", endDate);
				List<Object[]> listResult2 = query2.list();		
				
				double totalAmount = 0;
				long billingCount = 0;
				for (Object[] aRow2 : listResult2) {
					billingCount++;
					totalAmount += (Double) aRow2[2];
					
					if (billingCount==1) {
						lastBillingNo = (String) aRow2[1];
					}
				}

				ReportByCustomerOverviewBean resultObj = new ReportByCustomerOverviewBean();
				resultObj.setCustomerId(customerId);
				resultObj.setCustomerName(customerName);
				resultObj.setCustomerType(customerType);
				resultObj.setArea(area);
				resultObj.setCity(city);
				resultObj.setState(state);
				resultObj.setLastBillingNo(lastBillingNo);
				resultObj.setTotalAmount(totalAmount);
				resultObj.setBillingCount(billingCount);			
				resultList.add(resultObj);				
			}
			
			return resultList;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getReportByCustomerOverview

	
	public List<ReportByInventoryTopSellingItemsBean> getByInventoryTopSellingItems(String placeId, long startTime, long endTime, int itemCount, List<String> itemTypeList) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(startTime) || isNullOrEmpty(endTime) || isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			if (itemCount <= 0)
				itemCount = 10;
			
			Date startDate = new Date(startTime);
			Date endDate = new Date(endTime);
			
			LOGGER.info("placeId=" + placeId);
			LOGGER.info("startDate=" + startDate);
			LOGGER.info("endDate=" + endDate);
			LOGGER.info("itemTypeList=" + itemTypeList);
			
			StringBuilder hql = new StringBuilder();
			hql.append( "select ITEM.categoryId, CATEGORY.name, LINE.itemId, LINE.itemName, SUM(LINE.quantity), SUM(LINE.billableAmount) ");
			hql.append( "from BillingBean BILLING, BillingLineBean LINE, InventoryItemBean ITEM, InventoryCategoryBean CATEGORY where " );
			hql.append( "LINE.itemType in (:itemTypeList) and " );
			hql.append( "LINE.itemId = ITEM.id and " );
			hql.append( "ITEM.categoryId = CATEGORY.id and " );
			hql.append( "BILLING.id = LINE.billingId and " );
			hql.append( "BILLING.billingDate between :startDate and :endDate and " );
			hql.append( "BILLING.placeId = :placeId and " );
			hql.append( "BILLING.deletedOn is null and " );
			hql.append( "LINE.deletedOn is null " );
			hql.append( "group by ITEM.categoryId, CATEGORY.name, LINE.itemId, LINE.itemName " );
			hql.append( "order by SUM(LINE.quantity) desc" );
			
			Query query = this.getSessionFactory().getCurrentSession().createQuery( hql.toString() );
			query.setParameter("placeId", placeId);	
			query.setParameter("startDate", startDate);	
			query.setParameter("endDate", endDate);	
			query.setParameterList("itemTypeList", itemTypeList);
			
			LOGGER.info("query=" + query.toString());
			
			List<ReportByInventoryTopSellingItemsBean> resultList = new ArrayList<ReportByInventoryTopSellingItemsBean>();
						
			List<Object[]> listResult = query.list();	
			LOGGER.info("listResult=" + listResult.size());
			for (Object[] aRow : listResult) {
				String categoryId = (String) aRow[0];
				String categoryName = (String) aRow[1];
				String itemId = (String) aRow[2];
				String itemName = (String) aRow[3];
				Double quantity = (Double) aRow[4];
				Double totalAmount = (Double) aRow[5];
				
				ReportByInventoryTopSellingItemsBean resultObj = new ReportByInventoryTopSellingItemsBean();
				resultObj.setCategoryId(categoryId);
				resultObj.setCategoryName(categoryName);
				resultObj.setItemId(itemId);
				resultObj.setItemName(itemName);
				resultObj.setQuantity(quantity);
				resultObj.setTotalAmount(totalAmount);			
				resultList.add(resultObj);				
			}

			LOGGER.info("resultList=" + resultList.size());
			
			return resultList;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getByInventoryTopSellingItems
	
	public List<ReportByInventoryZeroSoldItemsBean> getByInventoryZeroSoldItems(String placeId, long startTime, long endTime, int itemCount, List<String> itemTypeList) 
		throws DAOException
	{  
		try 
		{
			if (isNullOrEmpty(startTime) || isNullOrEmpty(endTime) || isNullOrEmpty(placeId))
				throw new DAOException(ExceptionConstants.GENERAL_INVALID_INPUT_EXCEPTION);
				
			if (itemCount <= 0)
				itemCount = 10;
			
			Date startDate = new Date(startTime);
			Date endDate = new Date(endTime);
			
			LOGGER.info("placeId=" + placeId);
			LOGGER.info("startDate=" + startDate);
			LOGGER.info("endDate=" + endDate);
			
			StringBuilder hql_soldItemList = new StringBuilder();
			hql_soldItemList.append("select LINE.itemName ");
			hql_soldItemList.append("from BillingBean BILLING, BillingLineBean LINE ");
			hql_soldItemList.append("where BILLING.id = LINE.billingId ");
			hql_soldItemList.append("and LINE.itemType in (:itemTypeList) ");
			hql_soldItemList.append("and BILLING.billingDate between :startDate and :endDate " );
			hql_soldItemList.append("and BILLING.placeId = :placeId " );
			hql_soldItemList.append("and BILLING.deletedOn is null " );
			hql_soldItemList.append("and LINE.deletedOn is null " );
			hql_soldItemList.append("group by LINE.itemName " );

			Query query_soldItemList = this.getSessionFactory().getCurrentSession().createQuery( hql_soldItemList.toString() );
			query_soldItemList.setParameter("placeId", placeId);	
			query_soldItemList.setParameter("startDate", startDate);	
			query_soldItemList.setParameter("endDate", endDate);	
			query_soldItemList.setParameterList("itemTypeList", itemTypeList);
			LOGGER.info("query_soldItemList=" + query_soldItemList.toString());

			List<String> soldItemList = query_soldItemList.list();
			LOGGER.info("queryResult_soldItemList=" + soldItemList);
			
			// STEP #2
			StringBuilder hql_zeroSoldItemList = new StringBuilder();
			hql_zeroSoldItemList.append("select CATEGORY.id, CATEGORY.name, ITEM.id, ITEM.name, ITEM.quantity ");
			hql_zeroSoldItemList.append("from InventoryItemBean ITEM, InventoryCategoryBean CATEGORY ");
			hql_zeroSoldItemList.append("where ITEM.name NOT IN (:soldItemList) ");
			hql_zeroSoldItemList.append("and ITEM.categoryId = CATEGORY.id ");
			hql_zeroSoldItemList.append("and ITEM.itemType in (:itemTypeList) ");
			hql_zeroSoldItemList.append("and ITEM.placeId = :placeId ");
			hql_zeroSoldItemList.append("and ITEM.deletedOn is null ");
			//hql_zeroSoldItemList.append("group by ITEM.name");

			Query query_zeroSoldItemList = this.getSessionFactory().getCurrentSession().createQuery( hql_zeroSoldItemList.toString() );
			query_zeroSoldItemList.setParameter("placeId", placeId);	
			query_zeroSoldItemList.setParameterList("soldItemList", soldItemList);	
			query_zeroSoldItemList.setParameterList("itemTypeList", itemTypeList);
				
			List<ReportByInventoryZeroSoldItemsBean> resultList = new ArrayList<>();
			List<Object[]> queryResult_zeroSoldItemList = query_zeroSoldItemList.list();	
			LOGGER.info("listResult=" + queryResult_zeroSoldItemList.size());
			for (Object[] aRow : queryResult_zeroSoldItemList) {
				String categoryId = (String) aRow[0];
				String categoryName = (String) aRow[1];
				String itemId = (String) aRow[2];
				String itemName = (String) aRow[3];
				Double quantity = (Double) aRow[4];
				
				ReportByInventoryZeroSoldItemsBean resultObj = new ReportByInventoryZeroSoldItemsBean();
				resultObj.setCategoryId(categoryId);
				resultObj.setCategoryName(categoryName);
				resultObj.setItemId(itemId);
				resultObj.setItemName(itemName);
				resultObj.setQuantity(quantity);		
				resultList.add(resultObj);				
			}

			LOGGER.info("resultList=" + resultList.size());
			
			return resultList;
		} 
		catch (Exception e) 
		{
			throw new DAOException(ExceptionConstants.DAO_SQL_EXCEPTION, e.getMessage());
		}
	} // .end of getByInventoryTopSellingItems	
}  
