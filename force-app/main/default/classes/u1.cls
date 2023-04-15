public class u1 
{
     list<id> tids=new list<id>();
        public void new1()
        {
        list<CCXR_Table__c> tables1=[select id,CCXR_Table_Status__c,Time_Of_Reservation__c
                                    from CCXR_Table__c 
                                    where CCXR_Table_Status__c='Reserved' and restimeinmins__c >=3];
        
       for(CCXR_Table__c c:tables1)
       {
           c.CCXR_Table_Status__c='Vacant';
           c.Time_Of_Reservation__c=null;
           
           update c; 
       }
    }

}