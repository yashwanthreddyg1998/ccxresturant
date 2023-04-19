//Author:R Yaswanth Reddy
//Date Creation :16/03/2023
//Date Modified:19/03/2023
//Purpose:list of customer table records in occupied status
public with sharing class CustomerTableStatusController
{
    /*
* @AuraEnabled method to retrieve a list of customer table records with waiting status
* @return List<CCXR_Customer_Table_Status__c> - list of customer table records
*/
    @AuraEnabled(cacheable = true)
    public static List<CCXR_Customer_Table_Status__c> getCustomerTableStatus()
    {
        // Retrieve customer table records with occupied,reserved status
        List<CCXR_Customer_Table_Status__c> accList =[select Name,CCXR_Customer__r.CCXR_Name__c,CCXR_Table__r.Name,
        CCXR_Customer__r.No_Of_Persons__c,
        Customer_Table_Status__c,Token_Number__c from  
        CCXR_Customer_Table_Status__c where Customer_Table_Status__c='Occupied'];
        // Return the list of customer table records
        return accList;
    }
}