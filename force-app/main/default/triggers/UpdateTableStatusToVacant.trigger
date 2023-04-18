trigger UpdateTableStatusToVacant on CCXR_Table__c (after update) 
{	
/*   List<CCXR_Table__c> tablesToUpdate = new List<CCXR_Table__c>();
   Integer minutesUntilVacant = 15; // Change this value as needed
    for (CCXR_Table__c res : Trigger.new) 
    {
        if (res.CCXR_Table_Status__c == 'Reserved' && res.Time_Of_Reservation__c < System.now()) 
        {
            // Calculate the reservation expiration time
            DateTime expirationTime = res.Time_Of_Reservation__c.addMinutes(minutesUntilVacant);
            CCXR_Table__c table = new CCXR_Table__c(CCXR_Table_Status__c = 'Vacant');
            tablesToUpdate.add(table);
        }
    }
    if (!tablesToUpdate.isEmpty()) 
    {
        update tablesToUpdate;
    }
*/
}