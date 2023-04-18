//Author:R Yaswanth Reddy
//Date Creation :20/03/2023
//Date Modified:24/03/2023
//Purpose of the Class: Order status field is set to 'Ready' or 'Picked-up'.
//This Class contains 3 methods

public class waiterScreenController
{
       @AuraEnabled(cacheable = true)
    public static List<CCXR_Chef_Orders__c> getAllAccountss(){
        // Retrieve  records with Ready' or 'Picked-up status
        List<CCXR_Chef_Orders__c> accList =[Select Id,CCXR_Order_Id__c,CCXR_Table__c,
        CCXR_Items_ID__c,Order_status__c,button3__c,button4__c,Assignedtochef__r.Name,assigned_waiter__c,CCXR_Accepted_By_Chef__c,CCXR_Items_ID__r.CCXR_Item_Name__c,CCXR_Order_Id__r.Name FROM CCXR_Chef_Orders__c where Order_status__c in ('Ready','Picked-up')];
        return accList;
        // Return the list of customer table records
    }
    /*
* @AuraEnabled - This annotation enables the method to be called by an Aura component.
* Updates the Order_status__c field of the CCXR_Chef_Orders__c record with the provided Id to 'Picked-up'.
* @param cat - The Id of the CCXR_Chef_Orders__c record to update.
* @param but1 - A boolean value to update the button3__c field of the CCXR_Chef_Orders__c record.
* @param but2 - A boolean value to update the button4__c field of the CCXR_Chef_Orders__c record.
*/
    @AuraEnabled
    public static void statuspick(Id cat,boolean but1,boolean but2)
    {
        CCXR_Chef_Orders__c acc = new CCXR_Chef_Orders__c(Id = cat);
        acc.Order_status__c ='Picked-up';
        acc.button3__c=but1;
        acc.button4__c=but2;
        update acc;
        

}
   /*
* @AuraEnabled - This annotation enables the method to be called by an Aura component.
* Updates the Order_status__c field of the CCXR_Chef_Orders__c record with the provided Id to 'Served'.
* @param cat - The Id of the CCXR_Chef_Orders__c record to update.
* @param but2 - A boolean value to update the button4__c field of the CCXR_Chef_Orders__c record.
*/
@AuraEnabled
public static void statusser(Id cat,boolean but2)
{
    CCXR_Chef_Orders__c acc = new CCXR_Chef_Orders__c(Id = cat);
    acc.Order_status__c ='Served';
  
    acc.button4__c=but2;
    update acc;
        

}
}