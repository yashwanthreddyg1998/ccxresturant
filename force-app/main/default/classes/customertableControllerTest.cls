@isTest
private class customertableControllerTest {
    @isTest static void testGetAllAccountsas() {
        // Create test data
        
        CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Customer_Table_Status__c testRecord = new CCXR_Customer_Table_Status__c(Customer_Table_Status__c = 'Waiting');
        insert testRecord;
        
        // Call the method being tested
        List<CCXR_Customer_Table_Status__c> result = customertableController.getAllTable();
        
        // Verify the expected result
        System.assertEquals(1, result.size());
        
    }
    
    @isTest static void testSetstatus() {
        // Create test data
        
        CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Table__c testTable = new CCXR_Table__c(CCXR_Table_Status__c = 'Vacant',CCXR_Restaurant_Employee__c=rsc.id);
        insert testTable;
        
        CCXR_Customer_Table_Status__c testRecord = new CCXR_Customer_Table_Status__c(Customer_Table_Status__c = 'Waiting', Token_Number__c = 0);
        insert testRecord;
        
        // Call the method being tested
        List<CCXR_Customer_Table_Status__c> result = customertableController.setstatus(testRecord.Id, testTable.Id, 123);
        
        // Verify the expected result
        System.assertEquals(1, result.size());
        System.assertEquals('Occupied', result[0].Customer_Table_Status__c);
        
        System.assertEquals(123, result[0].Token_Number__c);
    }
    
    @isTest static void testTsetstatus() {
        // Create test data
        
        CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Table__c testTable = new CCXR_Table__c(CCXR_Table_Status__c = 'Vacant',CCXR_Restaurant_Employee__c=rsc.id);
        insert testTable;
        
        // Call the method being tested
        List<CCXR_Table__c> result = customertableController.tsetstatus(testTable.Id);
        
        // Verify the expected result
        System.assertEquals(1, result.size());
        System.assertEquals('Occupied', result[0].CCXR_Table_Status__c);
    }
    
    @isTest static void testGetAccountNames() {
        // Create test data
        
        
        CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Table__c testTable1 = new CCXR_Table__c(CCXr_Capacity__c = 2, CCXR_Table_Status__c = 'Vacant',CCXR_Restaurant_Employee__c=rsc.Id );
        CCXR_Table__c testTable2 = new CCXR_Table__c(CCXr_Capacity__c = 4, CCXR_Table_Status__c = 'Reserved', CCXR_Restaurant_Employee__c=rsc.id);
        insert new List<CCXR_Table__c> { testTable1, testTable2 };
            
            // Call the method being tested
            List<CCXR_Table__c> result = customertableController.getTableRecords();
        
        // Verify the expected result
        System.assertEquals(2, result.size());
        
    }
    
    @isTest static void testGetCustomerTableStatus() {
        // Create test data
        CCXR_Customer_Table_Status__c testRecord = new CCXR_Customer_Table_Status__c(Customer_Table_Status__c = 'Occupied');
        insert testRecord;
        
        // Call the method being tested
        List<CCXR_Customer_Table_Status__c> result = customertableController.getCustomerTableStatus();
    }
    @isTest 
    static void testGetCustomerReservedData() {
        // Create a test record for CCXR_Customer_Table_Status__c
        
        CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Customer__c cust = new CCXR_Customer__c();
        cust.CCXR_Name__c='Test Customer';
        cust.No_Of_Persons__c=4;
        cust.CCXR_Phone_Number__c='6303279407';
        insert cust;
        
        CCXR_Table__c tb = new CCXR_Table__c();
        tb.CCXR_Capacity__c=6;
        tb.CCXR_Table_Status__c='Vacant';
        tb.CCXR_Restaurant_Employee__c=rsc.id;
        insert tb;
        
        CCXR_Customer_Table_Status__c testRecord = new CCXR_Customer_Table_Status__c(
            Customer_Table_Status__c = 'Occupied',
        	CCXR_Customer__c=cust.id,
            CCXR_Table__c=tb.id
        );
        insert testRecord;
        
         CCXR_Customer_Table_Status__c result = CustomerTableController.getCustomerReservedData(
            testRecord.Id, tb.id, 123, true
        );
    }
    
    @isTest 
    static void testGetCustomerReservedData1() {
        // Create a test record for CCXR_Table__c
        
        CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Table__c testRecord = new CCXR_Table__c(
            CCXR_Table_Status__c = 'Vacant',
        	CCXR_Restaurant_Employee__c=rsc.Id
        );
        insert testRecord;

        // Call the method with the test record's ID
        List<CCXR_Table__c> result = CustomerTableController.getCustomerReservedData1(testRecord.Id);

        // Verify that the record was updated correctly
        System.assertEquals(1, result.size());
        System.assertEquals('Reserved', result[0].CCXR_Table_Status__c);
        System.assertNotEquals(null, result[0].Time_Of_Reservation__c);
    }
    
}