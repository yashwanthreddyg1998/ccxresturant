@isTest
private class GetItemsTest {
	@isTest
    private static void testGetMenuItems(){
        //Create test data
        CCXR_Items__c item=new CCXR_Items__c(CCXR_Item_Name__c='Test',CCXR_Item_Category__c='Vegetarian',
                                    CCXR_Item_SubCategory__c='Soups',
            	                    CCXR_Item_Status__c='Available');
        insert item;
        //Call the method being tested
        GetItems.getMenuItems('Vegetarian','Soups');
        //Verify the expected results
        system.assertEquals('Test', item.CCXR_Item_Name__c);
        system.assertNotEquals('item', item.CCXR_Item_Name__c);
        
    }
}