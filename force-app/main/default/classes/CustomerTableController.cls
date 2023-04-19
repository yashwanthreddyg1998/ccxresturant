//Author:R Yaswanth Reddy
//Date Creation :12/03/2023
//Date Modified: 15/03/2023
//Purpose :list of customer table records in waiting status,
//This Class contains 5 methods
public with sharing class CustomerTableController
{
    /*
* @AuraEnabled method to retrieve a list of customer table records with waiting status
* @return List<CCXR_Customer_Table_Status__c> - list of customer table records
*/
    @AuraEnabled(cacheable = true)
    public static List<CCXR_Customer_Table_Status__c> getAllTable(){
        // Retrieve customer table records with waiting status
        List<CCXR_Customer_Table_Status__c> accList =[select Name,waittime__c,waittimeinmins__c,Button_1__c,Customer_Table_Status__c,Token_Number__c,
                                   CCXR_Customer__r.CCXR_Name__c,CCXR_Table__r.Name,CCXR_Customer__r.No_Of_Persons__c,
                                     Timeofvisit__c from  
                                     CCXR_Customer_Table_Status__c where Customer_Table_Status__c='Waiting' or Customer_Table_Status__c='Reserved' ORDER BY waittime__c desc ];
        // Return the list of customer table records
        return accList;
    }
    //Purpose of the Class:when a customer is assigned to a table
    @AuraEnabled
    public static List<CCXR_Customer_Table_Status__c> setstatus(Id recid,Id tid,integer ran)
    {
        /*
* @AuraEnabled method to update the status of a customer table record when assigned to a table
* @recid - Id of the customer table record
* @tid - Id of the table assigned to the customer
* @ran - integer value of the token number assigned to the customer
* @return List<CCXR_Customer_Table_Status__c> - list of updated customer table records
*/
        List<CCXR_Customer_Table_Status__c> up= new List<CCXR_Customer_Table_Status__c> ();
        List<CCXR_Customer_Table_Status__c> accList1 =[select Customer_Table_Status__c,CCXR_Table__c,Token_Number__c from  
                                                       CCXR_Customer_Table_Status__c where id=:recid];
        for (CCXR_Customer_Table_Status__c acc:acclist1) {
            acc.Customer_Table_Status__c='Occupied';
            acc.CCXR_Table__c=tid;
            acc.Token_Number__c=ran;
            up.add(acc);
        }
      update up;
        // Update the customer table records
        RETURN up;
        // Return the updated customer table records     
    }
    /*
@AuraEnabled method to update the status of table record, customer is assigned to a table
@param recid - Id of the table record
@return List<CCXR_Table__c> - list of updated table records
*/
    @AuraEnabled
    public static List<CCXR_Table__c> tsetstatus(Id recid){
        List<CCXR_Table__c> up= new List<CCXR_Table__c> ();
        // Retrieve the table record that needs to be updated
        List<CCXR_Table__c> accList1 =[select CCXR_Table_Status__c from  CCXR_Table__c where id=:recid];
        for (CCXR_Table__c acc:acclist1) {
            acc.CCXR_Table_Status__c='Occupied';
            
            up.add(acc);
        }
        // Update the table records
        update up;
        // Return the updated table records
        RETURN up;
    }
    /*
@AuraEnabled method to retrieve a list of table records with Vacant or Reserved status
@return List<CCXR_Table__c> - list of table records
*/
    @AuraEnabled(cacheable=true)
    public static List<CCXR_Table__c> getTableRecords() {
        // Retrieve table records with Vacant or Reserved status
        return [SELECT Id,Name,CCXR_Capacity__c FROM CCXR_Table__c where  CCXR_Table_Status__c in ('Vacant', 'Reserved') ];
    }
    /*
@AuraEnabled method  retrieve a list of customer table statuses with Occupied
@return List<CCXR_Customer_Table_Status__c> - list of table records
*/
   @AuraEnabled
    public static List<CCXR_Customer_Table_Status__c> getCustomerTableStatus(){
        List<CCXR_Customer_Table_Status__c> accList =[select Name,Customer_Table_Status__c,Token_Number__c,
                         CCXR_Customer__r.CCXR_Name__c,CCXR_Table__r.Name,CCXR_Customer__r.No_Of_Persons__c from  
                                        CCXR_Customer_Table_Status__c where Customer_Table_Status__c='Occupied'];
        return accList;
    }
   
    @AuraEnabled
    public static CCXR_Customer_Table_Status__c getCustomerReservedData(id csn,id tid,boolean but2)
    {
        CCXR_Customer_Table_Status__c rcst =[select id,Customer_Table_Status__c,Button_1__c,Token_Number__c,CCXR_Table__c
                                             from  CCXR_Customer_Table_Status__c 
                                             where id=:csn];
        
        rcst.Customer_Table_Status__c='Reserved';
        rcst.CCXR_Table__c=tid;
      rcst.Button_1__c=but2;
        update rcst;
       
        return rcst;
        
    }
    @AuraEnabled
    public static List<CCXR_Table__c> getCustomerReservedData1(Id recid){
        List<CCXR_Table__c> up= new List<CCXR_Table__c> ();
        // Retrieve the table record that needs to be updated
        List<CCXR_Table__c> accList1 =[select CCXR_Table_Status__c from  CCXR_Table__c where id=:recid];
        for (CCXR_Table__c acc:acclist1) {
            acc.CCXR_Table_Status__c='Reserved';
            acc.Time_Of_Reservation__c=datetime.now();
            up.add(acc);
        }
        // Update the table records
        update up;
        // Return the updated table records
        RETURN up;
        
    }   
}