@isTest
private class getorderstatusesTest {
    
    @isTest
   private static void testOrderstatuses() {
        
        // Create test data
        CCXR_Order__c order = new CCXR_Order__c(CCXR_Order_Status__c = 'Completed');
        insert order;
        
        CCXR_Order_Line_Item__c oli1 = new CCXR_Order_Line_Item__c(
            CCXR_Order_ID__c = order.Id,
            CCXR_OrderLineItem_Status__c = 'Served');
        insert oli1;
        
        CCXR_Order_Line_Item__c oli2 = new CCXR_Order_Line_Item__c(
            CCXR_Order_ID__c = order.Id,
            CCXR_OrderLineItem_Status__c = 'Served');
        insert oli2;
        
        CCXR_Order_Line_Item__c oli3 = new CCXR_Order_Line_Item__c(
            CCXR_Order_ID__c = order.Id,
            CCXR_OrderLineItem_Status__c = 'Served');
       
        
        // Call the method being tested
        List<CCXR_Order_Line_Item__c> result = getorderstatusescontroller.orderstatuses(order.Id);
        
        // Verify the result
        System.assertEquals(2, result.size());

    }
}