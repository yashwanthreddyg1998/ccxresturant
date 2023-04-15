/*
* Author : Jyothi Nandaluri
 * Creation Date : 11/03/2023, 3:14 pm	
 * Last Modification : 27/03/2023, 12:01 pm
 * Purpose : To retrieve the items data from items object. 
*/
public with sharing class GetItems {
    @AuraEnabled(cacheable=true)
    //To retreive the data from items object.
    public static List<CCXR_Items__c> getMenuItems(string cat, string sub)
    {
        List<CCXR_Items__c> items=[SELECT id,CCXR_Item_Name__c,CCXR_Price__c,
        Item_Image__c,Item_Image_Link__c,CCXR_Item_Category__c,
        CCXR_Item_Prep_Time__c,CCXR_Serves__c
                            from CCXR_Items__c
                            Where CCXR_Item_Category__c=:cat
                                   AND CCXR_Item_SubCategory__c=:sub
                                  AND CCXR_Item_Status__c='Available'];                   
        return items;
    }
}