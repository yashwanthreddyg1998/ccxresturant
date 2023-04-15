/*
* Author : Jyothi Nandaluri
 * Creation Date : 14/03/2023, 10:29 pm	
 * Last Modification : 03/04/2023, 12:01 pm
 * Purpose : To retrieve the special items data in the items object. 
*/
public with sharing class GetSpecialItems {
    @AuraEnabled(cacheable=true)
    //To retreive the special items from items object.
    public static List<CCXR_Items__c> getTodaySpecialMenu()
    {
        List<CCXR_Items__c> menuItems = [SELECT CCXR_Item_Name__c, CCXR_Item_Status__c, 
                                        CCXR_Special_Item__c,Item_Image__c,Item_Image_Link__c,
                                        CCXR_Serves__c,CCXR_Price__c,CCXR_Item_Prep_Time__c
                                        FROM CCXR_Items__c 
                                        WHERE CCXR_Item_Status__c = 'Available' AND CCXR_Special_Item__c=true];
        return menuItems;
    }
}