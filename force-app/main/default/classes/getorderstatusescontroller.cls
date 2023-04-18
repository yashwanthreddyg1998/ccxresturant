//Author Name:-K.jagadeeswar Reddy
 //  Date Of Creation:- 24-03-2023
  // Date last modified :-28-03-2023

  // Purpose :- To get the data of order and orderlineitems Which order status are completed 
  //                         and orderlineitemstatus are served
public class getorderstatusescontroller {
    
    @AuraEnabled(cacheable=true)
    // passing order id as parameter
    public static list<CCXR_Order_Line_Item__c> orderstatuses(Id orderid)
    {
        integer i=0;
        integer j=0;
        // Storing orderlineitems list in n1 variable
        list<CCXR_Order_Line_Item__c> n1=new  list<CCXR_Order_Line_Item__c> ();
        // fetching the data of order status completed 
        list<CCXR_Order_Line_Item__c>                            
            
            orderst=[select CCXR_OrderLineItem_Status__c,CCXR_Order_ID__r.CCXR_Order_Status__c,
                     CCXR_Order_ID__r.CCXR_Customer__c, CCXR_Order_ID__r.CCXR_Table__c,CCXR_Order_ID__r.Name,
                     CCXR_Order_ID__r.CCXR_Grand_Total__c,CCXR_Order_ID__r.CCXR_Tax__c,CCXR_Order_ID__r.CCXR_OrderDiscount__c,
                     CCXR_Order_ID__r.CCXR_Net_Total__c,
                     Name,CCXR_Item_Name__c,CCXR_Quantity__c,CCXR_Price__c,CCXR_Total__c
                     from CCXR_Order_Line_Item__c
                     where  
                     CCXR_Order_ID__r.CCXR_Order_Status__c ='Completed' AND CCXR_Order_ID__C=:orderid
                    ];
        // Itertating orderdata with order lineitems and fetching the data of orderlineitem status served
        for(CCXR_Order_Line_Item__c oli:orderst)
        {
            i++;
            if(oli.CCXR_OrderLineItem_Status__c=='Served')
            {
                j++;
            }
            
            if(i==j)
            {   
                n1.add(oli);
            }
        }
        return n1;
    }
}