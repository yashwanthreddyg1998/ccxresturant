@isTest
private class CustomerTableStatusTest {
    
    @isTest
    private static void testGetCustomerTableStatus() {
        // Create test data
        
         CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
         
        CCXR_Customer__c customer = new CCXR_Customer__c(CCXR_Name__c = 'Test Customer', No_Of_Persons__c = 4,CCXR_Phone_Number__c ='90890');
        insert customer;
        
        CCXR_Table__c table = new CCXR_Table__c();
        table.CCXR_Capacity__c = 6;
        table.CCXR_Restaurant_Employee__c=rsc.id ;
        insert table;
        
        CCXR_Customer_Table_Status__c customerStatus = new CCXR_Customer_Table_Status__c(
            CCXR_Customer__c = customer.Id,
            CCXR_Table__c = table.Id,
            
            Customer_Table_Status__c = 'Occupied',
            Token_Number__c = 1234
        );
        insert customerStatus;
        
        // Call the method being tested
        CustomerTableStatusController.getCustomerTableStatus();
        
        // Verify the expected results
        System.assertEquals(4, customer.No_Of_Persons__c);
    }
}