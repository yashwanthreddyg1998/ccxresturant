@isTest
public class ChefOrderHelperTest {
    static testMethod void testUpdateStatus() {
  
        
       CCXR_Items__c item = new CCXR_Items__c();
            item.CCXR_Item_Name__c='Test Food';
            item.CCXR_Price__c=100;
            item.CCXR_Item_Status__c='Available';
         insert item;
        // Create a test order line item
        CCXR_Order_Line_Item__c oli = new CCXR_Order_Line_Item__c(
         CCXR_Item_ID__c = item.id,
            CCXR_OrderLineItem_Status__c = 'New'
        );
        insert oli;
        
        // Create a test chef order
        CCXR_Chef_Orders__c cord = new CCXR_Chef_Orders__c(
            CCXR_Order_Id__c = oli.CCXR_Order_ID__c,
            orderlineId__c = oli.Id,
            Order_status__c = 'Completed'
        );
        insert cord;
        
        // Update the chef order status
        cord.Order_status__c = 'Cancelled';
        update cord;
        
        // Verify that the order line item status was updated
        oli = [SELECT CCXR_OrderLineItem_Status__c FROM CCXR_Order_Line_Item__c WHERE Id = :oli.Id];
        System.assertEquals('Cancelled', oli.CCXR_OrderLineItem_Status__c);
    }
}