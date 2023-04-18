trigger Chef_Order_Trigger on CCXR_Chef_Orders__c (after update) {
  
    if(trigger.isAfter && trigger.isUpdate){
        ChefOrderHelper.updateStatus(trigger.new);
    }
}
/*
  for(CCXR_Chef_Orders__c cord:trigger.new)
 {

  list<CCXR_Order_Line_Item__c> oli=[select id,Name,CCXR_Item_ID__c,CCXR_Order_ID__c from CCXR_Order_Line_Item__c 
                                    where CCXR_Order_ID__c=:cord.CCXR_Order_Id__c and CCXR_Item_ID__c=:cord.CCXR_Items_ID__c ];
for(CCXR_Order_Line_Item__c ol:oli)
{
  ol.CCXR_OrderLineItem_Status__c=cord.Order_status__c;  
}

 }
*/