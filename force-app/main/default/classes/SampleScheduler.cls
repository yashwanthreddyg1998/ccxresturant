global class SampleScheduler implements Schedulable{
    global void execute(SchedulableContext SC)
    { 
        list<CCXR_Table__c> tables1=[select id,CCXR_Table_Status__c 
                                    from CCXR_Table__c 
                                    where CCXR_Table_Status__c='Reserved' and restimeinmins__c >=3];
        
       for(CCXR_Table__c c:tables1)
       {
           c.CCXR_Table_Status__c='Vacant';
           update c; 
       }
        
        
    }
 }