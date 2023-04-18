/* Author Name : Satya Umesh
	Date Of Creation : 11/04/2023
	Date last Modified : 13/04/2023
	Purpose of Class : For the Existing Customers we need to get the data via phone number .
*/

public with sharing class ExistingCustomerController
{
    // To get the Data From Customers with selected phone no And Pass it to "Alreadyvisitedcustomer.js"  In lwc

    @AuraEnabled (cacheable=true)
    public static List<CCXR_Customer__c> getPhoneNum(string ph)
    {
        List<CCXR_Customer__c> cts= [SELECT Id,CCXR_Phone_Number__c,No_Of_Persons__c FROM CCXR_Customer__c where CCXR_Phone_Number__c=:ph];  
        
        system.debug(cts);
        
        return cts;
    }
    
    //passing cid to here from js
    
    @AuraEnabled 
    public static void createCST(id cid) 
    {
        
        CCXR_Customer__c css=[SELECT Id,Name,CCXR_Phone_Number__c,No_Of_Persons__c FROM CCXR_Customer__c where id=:cid];
        
        CCXR_Customer_Table_Status__c csst=new CCXR_Customer_Table_Status__c();
        csst.CCXR_Customer__c=cid;
        csst.Customer_Table_Status__c='Waiting';
        csst.Timeofvisit__c=datetime.now();
        insert csst;
        
        CCXR_Customer_Table_Status__c acc = [SELECT CreatedDate FROM CCXR_Customer_Table_Status__c where id=:csst.id];
        String createDateStr = acc.CreatedDate.format('yyyy-MM-dd HH:mm:ss');
        System.debug('Create date as string: ' + createDateStr);
        
        Customer_Visit_History__c cvh=new Customer_Visit_History__c();
        cvh.CCXR_Customer_Id__c=css.Name;
        cvh.CCXR_Number_Of_Persons__c=css.No_Of_Persons__c;
        cvh.CCXR_Customer_Visited_Date_and_Time__c=createDateStr;
        
        insert cvh;
    }
    
}