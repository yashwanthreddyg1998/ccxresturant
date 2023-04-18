@isTest
private class CCXR_CustomerTableStatus_Test {

    static testMethod void testCCXRCustomerTableStatus() {
        // Create a new CCXR_Customer__c record
        CCXR_Customer__c customer = new CCXR_Customer__c();

        // Add the record to a list
        List<CCXR_Customer__c> customers = new List<CCXR_Customer__c>();
        customers.add(customer);

        // Insert the records
        insert customers;

        // Query the CCXR_Customer_Table_Status__c records for the inserted customer records
        List<CCXR_Customer_Table_Status__c> tableStatuses = [            SELECT Customer_Table_Status__c, CCXR_Customer__c, Timeofvisit__c            FROM CCXR_Customer_Table_Status__c            WHERE CCXR_Customer__c = :customer.Id        ];

        // Assert that one record was created
        System.assertEquals(1, tableStatuses.size());

        // Assert that the record has the expected values
        CCXR_Customer_Table_Status__c tableStatus = tableStatuses[0];
        System.assertEquals('Waiting', tableStatus.Customer_Table_Status__c);
        System.assertEquals(customer.Id, tableStatus.CCXR_Customer__c);
        System.assertNotEquals(null, tableStatus.Timeofvisit__c);
    }

}