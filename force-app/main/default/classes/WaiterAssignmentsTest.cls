@isTest
public class WaiterAssignmentsTest 
{    
    static testMethod void testWaiterAssignments() 
     {       
        // Create test data
        CCXR_Restaurant_Employee__c employee = new CCXR_Restaurant_Employee__c(CCXR_Name__c='Lohitha',CCXR_Type_of_Employee__c='Waiter');
        insert employee;        
         List<CCXR_Table__c> tables = new List<CCXR_Table__c>();
         for (Integer i = 0; i < 5; i++)
         {
           CCXR_Table__c table = new CCXR_Table__c();          
           table.CCXR_Restaurant_Employee__c = employee.Id;
           tables.add(table);
         }
         insert tables;            
         // Trigger update that should result in an error
            tables[0].CCXR_Restaurant_Employee__c = null;
            tables[1].CCXR_Restaurant_Employee__c = employee.Id;
            tables[2].CCXR_Restaurant_Employee__c = employee.Id;
            tables[3].CCXR_Restaurant_Employee__c = employee.Id;
            tables[4].CCXR_Restaurant_Employee__c = employee.Id;                 
            // Verify        
             try
             {
                update tables;
             } 
            catch (DmlException e) 
            {
            // check if the error message is as expected
            String expectedErrorMessage = 'Cannot assign more than 4 tables to the same employee.';
            System.assert(e.getMessage().contains(expectedErrorMessage), 'Error message should be: ' + expectedErrorMessage);
            }
     } 
}