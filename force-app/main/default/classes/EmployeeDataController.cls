/* 
Author Name : Pranay Naukarkar
Date Of Creation : 15/03/2023
Date last Modified : 03/04/2023
Purpose Of Class : To get the Data & delete records from CCXR_Restaurant_Employee__c,CCXR_Items__c,
					CCXR_Table__c,CCXR_Feedback__c which is used in LWC Component 
*/

public class EmployeeDataController 
{
    // To get the Data From Restaurant employee And Pass it to Javascript Controller "cheforderscreen.js" in lwc
	@AuraEnabled(cacheable=true)
    public static List<CCXR_Restaurant_Employee__c> getEmployeeList() 
    {
        return [SELECT Id, CCXR_Name__c, CCXR_Phone__c, CCXR_Email__c,CCXR_Aadhar_Number__c,
                CCXR_Type_of_Employee__c,(Select Name,CCXR_Chef_Current_Status__c from CCXR_Chef_Statuses__r)
                FROM CCXR_Restaurant_Employee__c];
    }
    
    //To get the Data of Items And Pass it to Javascript Controller "ccrItemsContent.js" in lwc
	@AuraEnabled(cacheable=true)
    public static List<CCXR_Items__c> getItemList() 
    {
        return [SELECT  id,CCXR_Item_Name__c, CCXR_Price__c,CCXR_Item_Category__c,CCXR_Item_SubCategory__c, CCXR_Item_Status__c,Item_Image_Link__c,
                CCXR_Item_Prep_Time__c,CCXR_Serves__c
                FROM CCXR_Items__c];
    }
    
    //To get the Data Of Tables And Pass it to Javascript Controller "ccrTableContent.js" in lwc
	@AuraEnabled(cacheable=true)
    public static List<CCXR_Table__c> getTableData1()
    {
        list<CCXR_Table__c> table=[select Name,CCXR_Capacity__c,Table_Image_Link__c,
                                   Assigned_Waiter__c,CCXR_Table_Status__c From CCXR_Table__c ORDER BY Name ASC];
        
        return table;
        
    }
    
    // To delete the Record Of a Restaurant employee used it in Javascript Controller "cheforderscreen.js" in lwc 
	@AuraEnabled
    public static void deleteEmp(Id selRecordId)
    {
        CCXR_Restaurant_Employee__c delEmp = [Select Name,id from CCXR_Restaurant_Employee__c 
                                              where id=:selRecordId];
        delete delEmp;
        
    }
    
    //To delete the Record Of a Items  used it in Javascript Controller "ccrItemsContent.js" in lwc
    @AuraEnabled
    public static void deleteItems(Id delRecordId)
    {
        CCXR_Items__c delitm = [Select Name,id from CCXR_Items__c 
                                where id=:delRecordId];
        delete delitm;
    }
    
    //To delete the Record Of a Table  used it in Javascript Controller "ccrTableContent.js" in lwc
    @AuraEnabled
    public static void deleteTable(Id tabRecordId)
    {
        list<CCXR_Table__c> delTab=[select Name,id From CCXR_Table__c
                                    where id=:tabRecordId];
        delete delTab;
        
    }
    
    // To get the Data From Feedback And Pass it to Javascript Controller "ccrFeedbackTable.js" in lwc
	@AuraEnabled(cacheable = true)
    public static List<CCXR_Feedback__c> getAllFeedback()
    {
        List<CCXR_Feedback__c> feedList =[select Name,CCXR_Customer__c,CCXR_Table__c,CCXR_Order__r.Name,
                                          CCXR_Food_Quality__c, CCXR_Service_Quality__c,CCXR_Suggestions__c
                                          from  CCXR_Feedback__c where CCXR_Customer__c!= NULL ];
        return feedList;
    }
    
}