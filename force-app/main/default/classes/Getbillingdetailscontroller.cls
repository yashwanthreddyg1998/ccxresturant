public class Getbillingdetailscontroller 
{
    @AuraEnabled(cacheable=true)
    public static CCXR_Order__c getOrder(decimal tokenNumber) 
    {
        
        CCXR_Order__c cts = [select id,Name from CCXR_Order__c  WHERE CCXR_Customer_Token_Number__c = :tokenNumber ];
        
        return cts;
    }
}