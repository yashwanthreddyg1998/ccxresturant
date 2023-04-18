public with sharing class Chefscreencontroller 
{
    /*
 Class Name : Chefscreencontroller,
 Author     : Katapally uday kumar,
 Date Of Creation: 13/03.2023,
 Last Modified Date : 04/03/2023,
 Purpose Of Class : The purpose of this class is to get the cheforders 
 */
    @AuraEnabled(cacheable = true)
    public static List<CCXR_Chef_Orders__c> getAllcheforders(){
        List<CCXR_Chef_Orders__c> accList =[Select Id,CCXR_Order_Id__c,CCXR_Quantity__c,Assignedtochef__r.Name,CCXR_Items_ID__r.CCXR_Item_Category__c,
        CCXR_Items_ID__c,CCXR_Items_ID__r.CCXR_Item_Name__c,CCXR_Table__c,Order_status__c,button__c,button1__c,Assignedtochef__c,CCXR_Accepted_By_Chef__c,CCXR_Order_Id__r.Name FROM CCXR_Chef_Orders__c where Order_status__c='Pending' or Order_status__c='Preparing' or Order_status__c='Ready'];
        return accList;
    }
    @AuraEnabled
    public static Integer updatecheforderstatus(Id cat,Id cat1,boolean but1,boolean but2 )
    {
        CCXR_Chef_Orders__c acc = new CCXR_Chef_Orders__c(Id = cat);
        acc.Order_status__c ='Preparing';
        acc.Assignedtochef__c=cat1;
        acc.button__c=but1;
        acc.button1__c=but2;
        update acc;
       
        List<CCXR_Chef_Orders__c> chefflist1 =[Select Id,Assignedtochef__c,
        Order_status__c FROM CCXR_Chef_Orders__c
        where Assignedtochef__c=:cat1 and Order_status__c='Preparing'];
        Integer nooforders=chefflist1.size();
        
        return nooforders;
    }
    @AuraEnabled
    public static CCXR_Chef_Orders__c updatecheforderstatus1(Id cat,boolean but2)
    {
        CCXR_Chef_Orders__c acc = new CCXR_Chef_Orders__c(Id = cat);
        acc.Order_status__c ='Ready';
        acc.button1__c=but2;
        update acc;
        CCXR_Chef_Orders__c chefacc=[select id,Assignedtochef__c from CCXR_Chef_Orders__c where id=:acc.id ];
        return chefacc;
    }
    @AuraEnabled
    public static void updatechefemployeebusy(Id cid)
    {
        CCXR_Chef_Status__c chefsta=[select id ,CCXR_Chef_Current_Status__c from CCXR_Chef_Status__c where CCXR_Restaurant_Employee__c=:cid];
        chefsta.CCXR_Chef_Current_Status__c ='Busy';
        update chefsta;
    }
      @AuraEnabled
    public static void updatechefemployeeavailable(Id cid)
    {
        CCXR_Chef_Status__c chefsta=[select id ,CCXR_Chef_Current_Status__c from CCXR_Chef_Status__c where CCXR_Restaurant_Employee__c=:cid];
        chefsta.CCXR_Chef_Current_Status__c ='Available';
        update chefsta;
    }
    @AuraEnabled(cacheable=true)
    public static List<CCXR_Restaurant_Employee__c> getempnames(String chefname) {
      
      return [SELECT Id, Name,CCXR_Name__c,CCXR_Type_Of_Chef__c FROM CCXR_Restaurant_Employee__c where CCXR_Type_of_Employee__c='Chef' AND Id IN (SELECT CCXR_Restaurant_Employee__c FROM CCXR_Chef_Status__c WHERE CCXR_Chef_Current_Status__c= 'Available')];
    }
}