@istest
private class displayorderlineitemsTest 
{
    @IsTest
    static void testDisplayingOrder() 
    {
        // Create test data
        
          CCXR_Items__c items = new CCXR_Items__c();
        items.CCXR_Item_Name__c='Test Item';
        items.CCXR_Price__c=100;
        items.CCXR_Item_Status__c='Available';
        items.CCXR_Serves__c=2;
        insert items;
        
		CCXR_Restaurant_Employee__c rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Name__c='Test Employee';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        insert rsc;
		        
        CCXR_Customer__c cust = new CCXR_Customer__c();
        cust.CCXR_Name__c='Test Customer';
        cust.No_Of_Persons__c=4;
        cust.CCXR_Phone_Number__c='6303279407';
        insert cust;
        
        CCXR_Table__c tb = new CCXR_Table__c();
        tb.CCXR_Capacity__c=6;
        tb.CCXR_Table_Status__c='Vacant';
        tb.CCXR_Restaurant_Employee__c=rsc.Id;
        insert tb;
        
        CCXR_Customer_Table_Status__c cts = new CCXR_Customer_Table_Status__c();
         cts.CCXR_Customer__c=cust.id;
        cts.CCXR_Table__c=tb.Id;
        cts.Customer_Table_Status__c='Occupied';
        insert cts;
        
        CCXR_Order__c order = new CCXR_Order__c(CCXR_Customer_Table_Status__c = cts.Id,CCXR_Order_Status__c = 'Progress');
        insert order;
        
        CCXR_Order_Line_Item__c orderItem = new CCXR_Order_Line_Item__c(
            CCXR_OrderLineItem_Status__c = 'Pending',
            CCXR_Order_ID__c = order.Id,
            CCXR_Quantity__c = 1.0
        );
        insert orderItem;
        
        // Call the method with the test data
      
        List<CCXR_Order_Line_Item__c> result = displayingorderlineitems.displayingorder(cts.Id);
        
        // Verify the result
        System.assertEquals(1, result.size());
        CCXR_Order_Line_Item__c item = result[0];
    }
    @isTest
    static void testDeleteOrderLineItems() {
        // Create test data
        CCXR_Order__c order = new CCXR_Order__c();
        insert order;
        CCXR_Order_Line_Item__c orderItem = new CCXR_Order_Line_Item__c(
            CCXR_Order_Id__c = order.Id,
            CCXR_OrderLineItem_Status__c = 'Pending'
        );
        insert orderItem;
        CCXR_Chef_Orders__c chefOrder = new CCXR_Chef_Orders__c(
            orderlineId__c = orderItem.Id
        );
        insert chefOrder;
        
        // Call the method to be tested       
        List<CCXR_Order_Line_Item__c> deletedOrderItems = displayingorderlineitems.deteleorderlineitems(orderItem.Id);
        
        // Verify the method results
        System.assertEquals(1, deletedOrderItems.size(), 'One order item should have been deleted');
        System.assertEquals(orderItem.Id, deletedOrderItems[0].Id, 'The deleted order item should have the correct Id');
        
        // Verify that related chef orders were deleted
        List<CCXR_Chef_Orders__c> chefOrders = [SELECT Id FROM CCXR_Chef_Orders__c WHERE orderlineId__c = :orderItem.Id];
        System.assertEquals(0, chefOrders.size(), 'Related chef orders should have been deleted');
        
        // Verify that other order items were not deleted
        List<CCXR_Order_Line_Item__c> remainingOrderItems = [SELECT Id FROM CCXR_Order_Line_Item__c];
        System.assertEquals(0, remainingOrderItems.size(), 'Other order items should not have been deleted');
    }
}