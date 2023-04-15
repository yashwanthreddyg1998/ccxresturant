/* Author Name : Satya Umesh
Date Of Creation : 31/03/2023
Date last Modified : 03/04/2023
Purpose of Test Class : To Test the Data that we are Feteching in Class ReceiptsDataController
*/

@isTest
private class ReceiptsDataTest 
{
    // To test the data of ReceiptsData method from Controller class ReceiptsDataController
    
    @istest
    private static void testReceiptsData() 
    {
        
        CCXR_Order__c order = new CCXR_Order__c();
        order.CCXR_Customer_Table_Status__c='a0A2w00000iYpRuEAK';
        order.CCXR_Order_Status__c='Paid';
        insert order;
        
        CCXR_Receipts__c rcp=new CCXR_Receipts__c();
        rcp.CCXR_Order__c=order.Id;
        
        insert rcp;
        
        // Call the method being tested
        ReceiptsDataController.getReceiptList();
        list<CCXR_Receipts__c> rcplist=[SELECT  Name, CCXR_Order__c,Amount_Received__c,CCXR_Order__r.CCXR_Customer__c,
                                        CCXR_Order__r.CCXR_Table__c,Transaction_Date__c                
                                        FROM CCXR_Receipts__c where CCXR_Order__r.CCXR_Order_Status__c='Paid'];
        
        // Verify the expected result
        System.assertEquals(1,rcplist.size());
        System.assertEquals('Paid',order.CCXR_Order_Status__c);
    }
    
    
    // To test the data of setorderstatus method from Controller class ReceiptsDataController
    
    @istest
    private static void testOrderstatus() 
    {
         CCXR_Customer__c cust = new CCXR_Customer__c();
        cust.CCXR_Name__c='Test Customer';
        cust.No_Of_Persons__c=4;
        cust.CCXR_Phone_Number__c='6303279407';
        insert cust;
       
        CCXR_Table__c tbls = new CCXR_Table__c();
        tbls.CCXR_Capacity__c=6;
        tbls.CCXR_Table_Status__c='Vacant';
        insert tbls;
       
        CCXR_Customer_Table_Status__c cst=new CCXR_Customer_Table_Status__c();
        cst.CCXR_Customer__c=cust.id;
        cst.CCXR_Table__c=tbls.Id;
        cst.Customer_Table_Status__c='Occupied';
        insert cst;
        
        CCXR_Order__c order = new CCXR_Order__c();
        order.CCXR_Customer_Table_Status__c=cst.id;
        order.CCXR_Order_Status__c='Progress';
        insert order;
        
        CCXR_Order__c ordc=[select CCXR_Customer_Table_Status__r.CCXR_Table__r.CCXR_Table_Status__c,
                            CCXR_Order_Status__c,CCXR_Table__c from CCXR_Order__c where id=:order.id ];
        ordc.CCXR_Order_Status__c='Paid';
        update ordc;
        
        CCXR_Customer_Table_Status__c cts=[SELECT  CCXR_Table__c,CCXR_Table__r.CCXR_Table_Status__c 
                                           FROM CCXR_Customer_Table_Status__c where id=:ordc.CCXR_Customer_Table_Status__c];
        system.debug(cts.CCXR_Table__r.CCXR_Table_Status__c);
        
        CCXR_Table__c tb=[select CCXR_Table_Status__c from CCXR_Table__c where id=:cts.CCXR_Table__c];
        system.debug(tb.CCXR_Table_Status__c);
        tb.CCXR_Table_Status__c='Vacant';
        
        update tb;
        
        // Call the method being tested
        ReceiptsDataController.setorderstatus(order.Id);
        list<CCXR_Table__c> tbs=[select CCXR_Table_Status__c from CCXR_Table__c where id=:tb.id];
        
        // Verify the expected result
        System.assertEquals(1,tbs.size());
    }
}