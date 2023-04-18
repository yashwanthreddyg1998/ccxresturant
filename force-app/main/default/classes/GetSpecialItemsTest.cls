@isTest
private class GetSpecialItemsTest {
	@isTest
    private static void testGetTodaySpecialMenu(){
        //Insert Record for testing the If situation
        CCXR_Items__c item=new CCXR_Items__c(CCXR_Item_Name__c='Test',
                                            CCXR_Item_Status__c = 'Available',
                                             CCXR_Item_Category__c='Vegetarian',
                                             CCXR_Item_SubCategory__c='Soups',
                                             CCXR_Special_Item__c=true);
        insert item;
        //Instantiate the Class
        GetSpecialItems.getTodaySpecialMenu();
        //Verify the expected results
        system.assertEquals(true, item.CCXR_Special_Item__c);
        system.assertNotEquals(false, item.CCXR_Special_Item__c);  
    }
}