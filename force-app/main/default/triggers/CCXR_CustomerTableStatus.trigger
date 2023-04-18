trigger CCXR_CustomerTableStatus on CCXR_Customer__c (after insert)
{
    list<CCXR_Customer__c> custTableStatus = new list <CCXR_Customer__c>();
    for(CCXR_Customer__c cts:trigger.new)
    {
        CCXR_Customer_Table_Status__c ct = new CCXR_Customer_Table_Status__c();
        
        ct.Customer_Table_Status__c='Waiting';
            ct.CCXR_Customer__c=cts.id;
            ct.Timeofvisit__c=datetime.now();
           
            
        insert ct;
        
    /*    CCXR_Customer_Table_Status__c acc = [SELECT CreatedDate FROM CCXR_Customer_Table_Status__c where id=:ct.id];
        String createDateStr = acc.CreatedDate.format('yyyy-MM-dd HH:mm:ss');
        System.debug('Create date as string: ' + createDateStr);
        
        Customer_Visit_History__c cvh=new Customer_Visit_History__c();
        cvh.CCXR_Customer_Id__c=cts.Name;
        cvh.CCXR_Number_Of_Persons__c=cts.No_Of_Persons__c;
        cvh.CCXR_Customer_Visited_Date_and_Time__c=createDateStr;
    
        
        
        insert cvh;
*/
    }
}