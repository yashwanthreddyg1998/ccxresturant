/* 
Author Name : Pranay Naukarkar
Date Of Creation : 31/03/2023
Date last Modified : 03/04/2023
Purpose of Test Class : To Test the Data that we are Fetching in Class EmployeeDataController
*/

@istest
private class EmployeeDataTest 
{
    // To test the data of "displayEmployeeData" method from Controller class "EmployeeDataController"
    @istest
    private static void displayEmployeeDataTest()
    {
         // Create test data
        CCXR_Restaurant_Employee__c emp = new CCXR_Restaurant_Employee__c();
        emp.CCXR_Name__c='Test Name';
        emp.CCXR_Phone__c='2457587847';
        emp.CCXR_Email__c='abc@gmail.com';
        emp.CCXR_Aadhar_Number__c='2255 2255 2255';
        emp.CCXR_Type_of_Employee__c='Chef';
        insert emp;
        
        CCXR_Chef_Status__c cf = new CCXR_Chef_Status__c();
        cf.CCXR_Chef_Current_Status__c='Available';
        cf.CCXR_Restaurant_Employee__c=emp.Id;
        insert cf;
        // Call the method being tested
        EmployeeDataController.getEmployeeList();
        List<CCXR_Restaurant_Employee__c> emplist=[SELECT Id, CCXR_Name__c, CCXR_Phone__c, CCXR_Email__c,CCXR_Aadhar_Number__c,
                                                   CCXR_Type_of_Employee__c
                                                   from CCXR_Restaurant_Employee__c where id=:emp.Id];
          // Verify the expected result
        system.assertEquals(1, emplist.size());
        
    }
    
    // To test the data of "getItemList" method from Controller class "EmployeeDataController"
    @isTest
    private static void getItemListTest()
    {
         // Create test data
        List<CCXR_Items__c> items= new List<CCXR_Items__c>();
        for(integer i=1;i<4;i++)
        {
            CCXR_Items__c item = new CCXR_Items__c();
            item.CCXR_Item_Name__c='Test Food'+ i;
            item.CCXR_Price__c=100;
            item.CCXR_Item_Status__c='Available';
            item.Item_Image_Link__c='https://i.pinimg.com/736x/c4/70/aa/c470aa518b4b87957ee31418f0559419.jpg';
            item.CCXR_Serves__c=2;
            item.CCXR_Item_Prep_Time__c='15 Min';
            items.add(item);
        }
        insert items;
        // Call the method being tested
        EmployeeDataController.getItemList();
        List<CCXR_Items__c> itmlist=[SELECT  id,CCXR_Item_Name__c, CCXR_Price__c, CCXR_Item_Status__c,Item_Image_Link__c,
                                     CCXR_Item_Prep_Time__c,CCXR_Serves__c
                                     FROM CCXR_Items__c];
        // Verify the expected result
        system.assertEquals(3, itmlist.size());
        
    } 
    
    // To test the data of "getTableData1" method from Controller class "EmployeeDataController"
    @isTest
    private static void getTableData1Test()
    {
         // Create test data
        list<CCXR_Table__c> uptables= new list<CCXR_Table__c>();
        for(integer i=1;i<4;i++)
        {
            CCXR_Table__c tb = new CCXR_Table__c();
            tb.CCXR_Capacity__c=4;
            tb.CCXR_Table_Status__c='Vacant';
            
            uptables.add(tb);
        }
        insert uptables;
        // Call the method being tested
        EmployeeDataController.getTableData1();
        list<CCXR_Table__c> tables=[select Name,CCXR_Capacity__c,Table_Image_Link__c,
                                    Assigned_Waiter__c,CCXR_Table_Status__c From CCXR_Table__c
                                   ];
        // Verify the expected result
        system.assertEquals(3, tables.size());
    }
    
    // To test the data of "deleteEmp" method from Controller class "EmployeeDataController"
    @isTest
    private static void deleteEmpTest() 
    {
         // Create test data
        CCXR_Restaurant_Employee__c emp = new CCXR_Restaurant_Employee__c();
        emp.CCXR_Name__c='Test Name';
        emp.CCXR_Phone__c='2457587847';
        emp.CCXR_Email__c='abc@gmail.com';
        emp.CCXR_Aadhar_Number__c='2255 2255 2255';
        emp.CCXR_Type_of_Employee__c='Chef';
        insert emp;
        
        // Call the method being tested
        EmployeeDataController.deleteEmp(emp.Id);
        List<CCXR_Restaurant_Employee__c> empList = [SELECT Id FROM CCXR_Restaurant_Employee__c WHERE Id = :emp.Id];
        
        // Verify the expected result
        System.assertEquals(0, empList.size());
    }
    
    // To test the data of "deleteItems" method from Controller class "EmployeeDataController"
    @isTest
    private static void deleteItemsTest()
    {
         // Create test data
        CCXR_Items__c item = new CCXR_Items__c();
        item.CCXR_Item_Name__c='Test Food Item';
        item.CCXR_Price__c=100;
        item.CCXR_Item_Status__c='Available';
        item.Item_Image_Link__c='https://i.pinimg.com/736x/c4/70/aa/c470aa518b4b87957ee31418f0559419.jpg';
        item.CCXR_Serves__c=2;
        item.CCXR_Item_Prep_Time__c='15 Min';
        insert item;
        
        // Call the method being tested
        EmployeeDataController.deleteItems(item.Id);
        List<CCXR_Items__c> itmList=[SELECT  id
                                     FROM CCXR_Items__c where id=:item.id];
        // Verify the expected result
        system.assertEquals(0, itmList.size());
    } 
    
    // To test the data of "deleteTable" method from Controller class "EmployeeDataController"
    @isTest
    private static void deleteTableTest()
    {
         // Create test data
        CCXR_Table__c tb = new CCXR_Table__c();
            tb.CCXR_Capacity__c=4;
            tb.CCXR_Table_Status__c='Vacant';
        insert tb ;
        
        // Call the method being tested
        EmployeeDataController.deleteTable(tb.Id);
        List<CCXR_Table__c> tbList=[SELECT  id
                                     FROM CCXR_Table__c where id=:tb.id];
        // Verify the expected result
        system.assertEquals(0, tbList.size());
    }
    
    // To test the data of "getAllFeedback" method from Controller class "EmployeeDataController"
     @isTest
    static void getAllFeedbackTest(){
        // Create test data
        CCXR_Customer__c cust = new CCXR_Customer__c();
        cust.CCXR_Name__c='Test Customer';
        cust.No_Of_Persons__c=4;
        cust.CCXR_Phone_Number__c='6303279407';
        insert cust;
        
        CCXR_Table__c tb = new CCXR_Table__c();
        tb.CCXR_Capacity__c=6;
        tb.CCXR_Table_Status__c='Vacant';
        insert tb;
        
        CCXR_Customer_Table_Status__c cst=new CCXR_Customer_Table_Status__c();
        cst.CCXR_Customer__c=cust.id;
        cst.CCXR_Table__c=tb.id;
            
        CCXR_Order__c order = new CCXR_Order__c();
        order.CCXR_Customer_Table_Status__c=cst.Id;
        insert order;
        
        CCXR_Feedback__c fd = new CCXR_Feedback__c();
        fd.CCXR_Order__c = order.Id;
        fd.CCXR_Food_Quality__c = 'Good';
        fd.CCXR_Service_Quality__c = 'Excellent';
        fd.CCXR_Suggestions__c = 'No suggestions';
        insert fd;
        
        // Call the method being tested
        EmployeeDataController.getAllFeedback();
        List<CCXR_Feedback__c> feedList = [Select Id,CCXR_Order__c,CCXR_Food_Quality__c,
                                           CCXR_Service_Quality__c,
                                           CCXR_Suggestions__c from CCXR_Feedback__c where id =:fd.id ];
        
       // Verify the expected result
        System.assertEquals(1, feedList.size()); 
    }
}