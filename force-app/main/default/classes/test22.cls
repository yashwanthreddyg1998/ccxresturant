public class test22 {

  @AuraEnabled(cacheable=true)
    
        public static list<CCXR_Order_Line_Item__c>  igg1()
        {
          list<CCXR_Order_Line_Item__c> cts1=new list<CCXR_Order_Line_Item__c>() ;
           list<CCXR_Order_Line_Item__c> cts = [select id from CCXR_Order_Line_Item__c where CCXR_Order_Id__r.id='a022w00000nf6LEAAY' ];
            for(CCXR_Order_Line_Item__c c:cts)
            {
                c.CCXR_OrderLineItem_Status__c='Served';
                cts1.add(c);
            }
            update cts1;
            
            return cts;
        }
   

}