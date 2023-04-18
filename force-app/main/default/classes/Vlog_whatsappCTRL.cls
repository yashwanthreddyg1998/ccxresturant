public class Vlog_whatsappCTRL {
	@AuraEnabled 
    public static CCXR_Customer_Table_Status__c fetchCustomer(String custId){
        return [select Name,Token_Number__c, CCXR_Table__r.Name, CCXR_Customer__r.CCXR_Name__c,
                CCXR_Customer__r.CCXR_Phone_Number__c
                from CCXR_Customer_Table_Status__c where Id=:custId ];
    }
}