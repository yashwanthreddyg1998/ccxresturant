public with sharing class Order_CreationController
{
    
    public static Id neworderid;
    @AuraEnabled()
    public static void  createOrderAndOrderLines(id csn,id itemid,integer quantity)
    {
        CCXR_Items__c item = [select id,CCXR_Item_Category__c,CCXR_Item_SubCategory__c from CCXR_Items__c where id=:itemid ];
        
        CCXR_Customer_Table_Status__c cts = [select CCXR_Customer__c,CCXR_Table__c,
                                             (select id,CCXR_Order_Status__c from CCXR_Orders__r
                                              where CCXR_Order_Status__c='Progress' ) from CCXR_Customer_Table_Status__c where
                                              id=:csn WITH SECURITY_ENFORCED];
        System.debug(cts);
        list<CCXR_Order__c > exorder = new  list<CCXR_Order__c>();
        exorder = cts.CCXR_Orders__r;
        if(exorder.size()==0)
        {
            CCXR_Order__c neworder = new CCXR_Order__c();
            neworder.CCXR_Customer_Table_Status__c=cts.Id;
            neworder.CCXR_Order_Status__c ='Progress';
            database.SaveResult dbs = database.insert(neworder,false);
            if (dbs.isSuccess()) {
                
                System.debug('Account Successfully inserted, Account Id is: ' + dbs.getId());
                neworderid =dbs.getId();
                
            }
        }
        CCXR_Order_Line_Item__c orderlineitem = new CCXR_Order_Line_Item__c ();    
        if(neworderid == null)
        {
            for(CCXR_Order__c ord:exorder)
            {
                orderlineitem.CCXR_Order_ID__c = ord.id ;
            }
        }
        else
        {
            orderlineitem.CCXR_Order_ID__c = neworderid ;
            
        }
        orderlineitem.CCXR_Item_ID__c = itemid;
        orderlineitem.CCXR_Quantity__c = quantity;
        orderlineitem.CCXR_Item_Category__c= item.CCXR_Item_Category__c;
        orderlineitem.CCXR_Item_SubCategory__c=item.CCXR_Item_SubCategory__c;
        insert orderlineitem;
        System.debug('OLI Successfully inserted, OLI Id is: ' + neworderid);
    }
    @AuraEnabled(cacheable=true)
    public static CCXR_Order__c  getCustomerTableStatusData(id csn)
    {
        CCXR_Order__c cts = [select id,Name from CCXR_Order__c where CCXR_Customer_Table_Status__r.id=:csn and CCXR_Order_Status__c='Progress' ];
        
        return cts;
    }
    
    @AuraEnabled
    public static CCXR_Order__c  getCustomerTableStatusData1(id csn)
    {
        boolean status=true;
        CCXR_Order__c cts = [select id,Name,CCXR_Order_Status__c from CCXR_Order__c where CCXR_Customer_Table_Status__r.id=:csn and CCXR_Order_Status__c='Progress' ];
        
        list<CCXR_Order_Line_Item__c>  orderst=[select CCXR_OrderLineItem_Status__c,CCXR_Order_ID__r.CCXR_Order_Status__c,
                                                CCXR_Order_ID__r.CCXR_Customer__c, CCXR_Order_ID__r.CCXR_Table__c,CCXR_Order_ID__r.Name,
                                                CCXR_Order_ID__r.CCXR_Grand_Total__c,CCXR_Order_ID__r.CCXR_Tax__c,CCXR_Order_ID__r.CCXR_OrderDiscount__c,
                                                CCXR_Order_ID__r.CCXR_Net_Total__c,
                                                Name,CCXR_Item_Name__c,CCXR_Quantity__c,CCXR_Price__c,CCXR_Total__c
                                                from CCXR_Order_Line_Item__c
                                                where  
                                                CCXR_Order_ID__C=:cts.id
                                               ];
        
        for(CCXR_Order_Line_Item__c oli:orderst)
        {
            system.debug(oli.Name);
            if(oli.CCXR_OrderLineItem_Status__c!='Served')
            {
                System.debug(oli.CCXR_OrderLineItem_Status__c);
                status=false;
                
            }
        }
        system.debug(status);
        if(status!=false)
        {
            cts.CCXR_Order_Status__c='Completed';
            update cts;
            
        }
        return cts;
    }
}

/*cts.CCXR_Order_Status__c='Completed';
update cts;*/
/*Order_Creation obj = new Order_Creation();
obj.createOrderAndOrderLines('a012w000019usWcAAI','a032w00000VJMsBAAX','a002w00000aDNcHAAW',2);*/