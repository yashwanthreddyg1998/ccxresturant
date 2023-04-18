trigger WaiterAssignments on CCXR_Table__c (before update)
{
    for (CCXR_Table__c table : Trigger.new)
    {
        Integer tablesAssigned = [SELECT COUNT() FROM CCXR_Table__c WHERE CCXR_Restaurant_Employee__c = :table.CCXR_Restaurant_Employee__c];
        if (tablesAssigned > 4)
        {
            table.addError('Cannot assign more than 4 tables to the same employee.');
        }
    }

}