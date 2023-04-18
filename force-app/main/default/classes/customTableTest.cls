@isTest
public class customTableTest {

    @isTest
    static void testGetAllAccounts() 
    {
        // Create test data
        CCXR_Chef_Orders__c order = new CCXR_Chef_Orders__c(
            CCXR_Order_Id__c = '123',
            CCXR_Quantity__c = 2,
            CCXR_Items_ID__c = '456',
           
            Order_status__c = 'Pending'
        );
        insert order;

        // Call the method being tested
        List<CCXR_Chef_Orders__c> result = customTable.getAllAccounts();

        // Verify that the expected results are returned
        System.assertEquals(1, result.size());
        System.assertEquals(order.Id, result[0].Id);
        System.assertEquals(order.CCXR_Order_Id__c, result[0].CCXR_Order_Id__c);
        System.assertEquals(order.CCXR_Quantity__c, result[0].CCXR_Quantity__c);
        System.assertEquals(order.Assignedtochef__r.Name, result[0].Assignedtochef__r.Name);
        System.assertEquals(order.CCXR_Items_ID__c, result[0].CCXR_Items_ID__c);
        System.assertEquals(order.CCXR_Items_ID__r.CCXR_Item_Name__c, result[0].CCXR_Items_ID__r.CCXR_Item_Name__c);
       
        System.assertEquals(order.Order_status__c, result[0].Order_status__c);
        System.assertEquals(order.button__c, result[0].button__c);
        System.assertEquals(order.button1__c, result[0].button1__c);
        System.assertEquals(order.Assignedtochef__c, result[0].Assignedtochef__c);
        System.assertEquals(order.CCXR_Accepted_By_Chef__c, result[0].CCXR_Accepted_By_Chef__c);
        System.assertEquals(order.CCXR_Order_Id__r.Name, result[0].CCXR_Order_Id__r.Name);
    }
}