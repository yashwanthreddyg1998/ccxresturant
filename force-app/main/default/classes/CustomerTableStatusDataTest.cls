@isTest
private class CustomerTableStatusDataTest {

    @isTest
    static void testGetCustomerTableStatusData() {
        CCXR_Customer__c c1= new CCXR_Customer__c();
        c1.CCXR_Name__c='Sunil';
        c1.CCXR_Phone_Number__c='99898998';
        insert c1;
        CCXR_Restaurant_Employee__c r=new CCXR_Restaurant_Employee__c();
        r.CCXR_Name__c='Sunil';
        r.CCXR_Aadhar_Number__c='0000 0000 0000';
        r.CCXR_Type_of_Employee__c='Waiter';
        insert r;
        CCXR_Table__c t= new CCXR_Table__c();
        t.CCXR_Capacity__c=3;
        t.CCXR_Restaurant_Employee__c=r.id;
        insert t;
        // Create a new CCXR_Customer_Table_Status__c record
        CCXR_Customer_Table_Status__c cts = new CCXR_Customer_Table_Status__c(
            Token_Number__c = 123,
            CCXR_Customer__c = c1.id,
            CCXR_Table__c = t.id
        );
        insert cts;

        // Call the getCustomerTableStatusData method with the token value of 123
        CCXR_Customer_Table_Status__c result = CustomerTableStatusData.getCustomerTableStatusData(123);

        // Verify that the returned record matches the expected record
       
        System.assertEquals(cts.Token_Number__c, result.Token_Number__c);
    }
}