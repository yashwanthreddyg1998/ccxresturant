/* Author Name : Satya Umesh
Date Of Creation : 12/04/2023
Date last Modified : 13/04/2023
Purpose of Test Class : To Test the Data that we are Feteching in Class ExistingCustomerController
*/


@istest
private class ExistingCustomerTest
{
	@isTest
    static void testGetPhoneNum() 
    {
        // Create test data
        CCXR_Customer__c customer = new CCXR_Customer__c(CCXR_Phone_Number__c = '1234567890', No_Of_Persons__c = 2);
        insert customer;
        
        // Call the controller method
        List<CCXR_Customer__c> result = ExistingCustomerController.getPhoneNum('1234567890');
        
        // Verify the results
        System.assertEquals(1, result.size(), 'Expected 1 record to be returned');
        CCXR_Customer__c actualCustomer = result[0];
        System.assertEquals(customer.Id, actualCustomer.Id, 'Incorrect record returned');
        System.assertEquals(customer.CCXR_Phone_Number__c, actualCustomer.CCXR_Phone_Number__c, 'Incorrect phone number');
        System.assertEquals(customer.No_Of_Persons__c, actualCustomer.No_Of_Persons__c, 'Incorrect number of persons');
    }
    @isTest
    static void testCreateCST() {
        // Create a test customer record
        CCXR_Customer__c customer = new CCXR_Customer__c(CCXR_Phone_Number__c = '123-456-7890', No_Of_Persons__c = 2);
        insert customer;
        
        // Call the controller method
        ExistingCustomerController.createCST(customer.Id);
        
        // Verify the results
        List<CCXR_Customer_Table_Status__c> tableStatuses = [SELECT Id, Customer_Table_Status__c FROM CCXR_Customer_Table_Status__c WHERE CCXR_Customer__c = :customer.Id];
         System.assertEquals('Waiting', tableStatuses[0].Customer_Table_Status__c, 'Incorrect customer table status');
        
        List<Customer_Visit_History__c> visitHistories = [SELECT Id, CCXR_Customer_Id__c, CCXR_Number_Of_Persons__c, CCXR_Customer_Visited_Date_and_Time__c FROM Customer_Visit_History__c WHERE CCXR_Customer_Id__c = :customer.Name];
        Customer_Visit_History__c visitHistory = visitHistories[0];
        
        System.assertEquals(customer.Name, visitHistory.CCXR_Customer_Id__c, 'Incorrect customer Id');
        System.assertEquals(customer.No_Of_Persons__c, visitHistory.CCXR_Number_Of_Persons__c, 'Incorrect number of persons');
    }
}