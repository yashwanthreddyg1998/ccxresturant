@isTest
private class Order_CreationTest
{
    @istest
    private static void additemstest()
    {
        Id neworderid;
        CCXR_Items__c item = new CCXR_Items__c();
        item.CCXR_Item_Name__c='Test Food Item';
        item.CCXR_Price__c=100;
        item.CCXR_Item_Status__c='Available';
        item.CCXR_Serves__c=2;
        insert item;
        
        CCXR_Customer__c cust = new CCXR_Customer__c();
        cust.CCXR_Name__c='Test Customer';
        cust.No_Of_Persons__c=4;
        cust.CCXR_Phone_Number__c='6303279407';
        insert cust;
        
        CCXR_Table__c tb = new CCXR_Table__c();
        tb.CCXR_Capacity__c=6;
        tb.CCXR_Table_Status__c='Vacant';
        insert tb;
        
        CCXR_Customer_Table_Status__c cst=new CCXR_Customer_Table_Status__c();
        cst.CCXR_Customer__c=cust.id;
        cst.CCXR_Table__c=tb.Id;
        cst.Customer_Table_Status__c='Occupied';
        insert cst;
        
        integer ct=[select count() from CCXR_Order__c
                    where CCXR_Customer_Table_Status__c=:cst.Id and CCXR_Order_Status__c='Progress'];
        
        list<CCXR_Order__c> exorder = [select Id from CCXR_Order__c where CCXR_Customer_Table_Status__c=:cst.Id];
        
        CCXR_Order__c neworder = new CCXR_Order__c();
        
        if(ct==0)
        {
            neworder.CCXR_Customer_Table_Status__c=cst.Id;
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
        orderlineitem.CCXR_Item_ID__c = item.id;
        orderlineitem.CCXR_Quantity__c = 2;
        orderlineitem.CCXR_Item_Category__c= item.CCXR_Item_Category__c;
        orderlineitem.CCXR_Item_SubCategory__c=item.CCXR_Item_SubCategory__c;
        insert orderlineitem;
        
        Order_CreationController.createOrderAndOrderLines(cst.id,item.id,2);
    }            
}