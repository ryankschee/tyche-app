
/*******************************************************************************
 * Save transaction object into local DB.
 * 
 * @param transactionObj	Transaction object to save.
 * @param itemList			List of item to save.
 * 
 * Change Logs
 * -----------
 * 20160808	Ryan Chee	Initial
 */
function localdb_transaction_save(transactionObj, itemList)
{
	// Save transaction to LocalDB
	tycheesIO_saveBean(transactionObj);	
	
	// Save item list to LocalDB
	if (itemList != null && itemList.length > 0)
		tycheesIO_saveBeanList(itemList);	
} // .end of localdb_transaction_save


/*******************************************************************************
 * Delete transaction object.
 * 
 * @param transactionObj	Transaction object to delete.
 * @param itemList			List of item to update.
 * 
 * Change Logs
 * -----------
 * 20160808	Ryan Chee	Initial
 */
function localdb_transaction_delete(transactionObj, itemList)
{
	Cached_deleteBean(transactionObj);
	tycheesIO_saveBean(transactionObj);
	
	// Save item list to LocalDB
	if (itemList != null && itemList.length > 0)
		tycheesIO_saveBeanList(itemList);	
} // .end of localdb_transaction_delete

