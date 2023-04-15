@isTest
private class TableControllerTest {
	@isTest
    private static void testGetTableData(){
        //Creating Employee Data
        CCXR_Restaurant_Employee__c emp=new CCXR_Restaurant_Employee__c();
        emp.CCXR_Name__c='Lohitha';
        emp.CCXR_Type_of_Employee__c='Waiter';
        insert emp;
        //Creating Table
        CCXR_Table__c table=new CCXR_Table__c();
        table.CCXR_Capacity__c=4;
        table.CCXR_Table_Status__c='Vacant';
        table.CCXR_Restaurant_Employee__c=emp.id;
        insert table;        
        //Call the Class
        TableController.getTableData();        
        //Verify the result
        system.assertEquals('Vacant', table.CCXR_Table_Status__c);
    }
    @isTest
    static void testUpdateTable() {
        // Create test data
        CCXR_Table__c table = new CCXR_Table__c( CCXR_Capacity__c=4);
        insert table;

        // Call the method being tested
        TableController.updateTable(table.Id);

        // Verify the expected results
        CCXR_Table__c updatedTable = [SELECT Id, LastModifiedDate FROM CCXR_Table__c WHERE Id = :table.Id];
        System.assertNotEquals(null, updatedTable.LastModifiedDate);
    }
}