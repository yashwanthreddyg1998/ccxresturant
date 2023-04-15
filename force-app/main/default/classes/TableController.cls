/* 
 * Author : Lohitha Ponugoti
 * Creation Date : 12/03/2023
 * Last Modification : 15/03/2023
 * Purpose : To read the table data and update the data in the tables From CCXR_Table Object. 
*/
public class TableController 
{
     @AuraEnabled(cacheable=true)
    // To read the data From the table From CCXR_Table Object
    public static List<CCXR_Table__c> getTableData()
    {
       list<CCXR_Table__c> table=[select Name,CCXR_Capacity__c,Table_Image_Link__c,CCXR_Restaurant_Employee__r.CCXR_Name__c,
                        CCXR_Table_Status__c From CCXR_Table__c ORDER BY Name ASC];
       
        return table;
       
    }
    @AuraEnabled
    //To Update the data in the table From CCXR_Table Object
         public static void updateTable(Id upRecordId)
        {
          CCXR_Table__c upTab = [Select Name,id from CCXR_Table__c 
                                                where id=:upRecordId];
          update upTab;       
         }
}