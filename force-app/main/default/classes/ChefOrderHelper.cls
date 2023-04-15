public class ChefOrderHelper
{
    public static void updateStatus(List<CCXR_Chef_Orders__c> chefOrdersList)
    { 
        list<CCXR_Order_Line_Item__c> upoli= new list<CCXR_Order_Line_Item__c>();
        for(CCXR_Chef_Orders__c cord:chefOrdersList)
        {
            list<CCXR_Order_Line_Item__c> oli=[select id,Name,CCXR_Item_ID__c,CCXR_Order_ID__c 
                                               from CCXR_Order_Line_Item__c
                                               where CCXR_Order_ID__c=:cord.CCXR_Order_Id__c and 
                                               Id=:cord.orderlineId__c ];
            for(CCXR_Order_Line_Item__c ol:oli)
            {
                ol.CCXR_OrderLineItem_Status__c=cord.Order_status__c; 
                upoli.add(ol);
            }
           
        }
        update upoli; 
    } 
}