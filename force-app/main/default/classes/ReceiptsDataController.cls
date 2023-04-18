/* Author Name : Satya Umesh
	Date Of Creation : 31/03/2023
	Date last Modified : 03/04/2023
	Purpose of Class : To get the Data From Receipts with Order Status as paid
*/

public class ReceiptsDataController
{
    // To get the Data From Receipts with Order Status Paid And Pass it to Javascript Controller "ccrReceiptsTable.js" In lwc

    @AuraEnabled(cacheable=true)
    
    public static List<CCXR_Receipts__c> getReceiptList() 
    {
        return [SELECT  Name, CCXR_Order__r.name,Amount_Received__c,CCXR_Order__r.CCXR_Customer__c	,
                CCXR_Order__r.CCXR_Table__c,Transaction_Date__c                
                FROM CCXR_Receipts__c where CCXR_Order__r.CCXR_Order_Status__c='Paid'];
    }
    


    
    @AuraEnabled
    public static void setorderstatus(id oid) 
    {
        CCXR_Order__c ordc=[select CCXR_Customer_Table_Status__r.CCXR_Table__r.CCXR_Table_Status__c,
                            CCXR_Order_Status__c,CCXR_Table__c from CCXR_Order__c where id=:oid ];
        ordc.CCXR_Order_Status__c='Paid';
        
        update ordc;
        
        CCXR_Customer_Table_Status__c cts=[SELECT  CCXR_Table__c,CCXR_Table__r.CCXR_Table_Status__c ,CCXR_Customer__c
                                           FROM CCXR_Customer_Table_Status__c where id=:ordc.CCXR_Customer_Table_Status__c];
        system.debug(cts.CCXR_Table__r.CCXR_Table_Status__c);
        
        CCXR_Table__c tb=[select CCXR_Table_Status__c from CCXR_Table__c where id=:cts.CCXR_Table__c];
        system.debug(tb.CCXR_Table_Status__c);
        tb.CCXR_Table_Status__c='Vacant';
        
        update tb;
        CCXR_Customer__c c=[select id,CCXR_No_of_Visits__c from CCXR_Customer__c where id=:cts.CCXR_Customer__c];
        c.CCXR_No_of_Visits__c++;
        update c;
        
       
    }
}