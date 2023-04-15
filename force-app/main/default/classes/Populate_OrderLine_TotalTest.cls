@isTest
public class Populate_OrderLine_TotalTest 
{
    @isTest static void testPopulateOrderLineTotal() 
    {
        // Create test data
        
        CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Items__c item = new CCXR_Items__c();
        item.CCXR_Item_Name__c='Test Food Item';
        item.CCXR_Price__c=100;
        item.CCXR_Item_Status__c='Available';
        item.CCXR_Serves__c=2;
        insert item;
        
        CCXR_Customer__c cust = new CCXR_Customer__c();
        cust.CCXR_Name__c='Test Customer';
        cust.No_Of_Persons__c=4;
        cust.CCXR_Phone_Number__c='6303279407';
        insert cust;
        
        CCXR_Table__c tb = new CCXR_Table__c();
        tb.CCXR_Capacity__c=6;
        tb.CCXR_Table_Status__c='Vacant';
        tb.CCXR_Restaurant_Employee__c=rsc.id;
        insert tb;
        
        CCXR_Customer_Table_Status__c cst=new CCXR_Customer_Table_Status__c();
        cst.CCXR_Customer__c=cust.id;
        cst.CCXR_Table__c=tb.Id;
        cst.Customer_Table_Status__c='Occupied';
        insert cst;
        
        
        CCXR_Order__c order = new CCXR_Order__c(CCXR_Customer_Table_Status__c=cst.id);
        insert order;
        
        CCXR_Order_Line_Item__c orderLine = new CCXR_Order_Line_Item__c(CCXR_Order_ID__c=order.id);
        
        // Call the trigger handler by inserting the test data
        insert orderLine;
        
        // Verify the results
        orderLine = [SELECT CCXR_New_Total__c FROM CCXR_Order_Line_Item__c WHERE Id = :orderLine.Id];
    }
}