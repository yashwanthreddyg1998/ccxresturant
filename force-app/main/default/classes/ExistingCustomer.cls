public with sharing class ExistingCustomer 
{
    @AuraEnabled (cacheable=true)
    public static List<CCXR_Customer__c> getPhoneNum(string ph)
    {
        List<CCXR_Customer__c> cts= [SELECT Id,CCXR_Phone_Number__c FROM CCXR_Customer__c where CCXR_Phone_Number__c=:ph];  
        
        system.debug(cts);
        
        
        for(CCXR_Customer__c c:cts)
        {
            CCXR_Customer_Table_Status__c csst=new CCXR_Customer_Table_Status__c();
            
            csst.CCXR_Customer__c=c.id;
            csst.Customer_Table_Status__c='Waiting';
            
            insert csst;
        }
       	
        
        return cts;
    }
    
}