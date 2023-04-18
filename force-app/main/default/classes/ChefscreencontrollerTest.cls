@isTest
private class ChefscreencontrollerTest {
    @isTest
    
    private static void testGetAllChefOrders() {
        // Test data setup
        CCXR_Chef_Orders__c order1 = new CCXR_Chef_Orders__c(
            CCXR_Order_Id__c = 'a022w00000nh3GpAAI',
            CCXR_Quantity__c = 1,
            CCXR_Items_ID__c = 'a002w00000aFdgDAAS',
            
            Order_status__c = 'Preparing'
        );
        CCXR_Chef_Orders__c order2 = new CCXR_Chef_Orders__c(
            CCXR_Order_Id__c = 'a022w00000nh3GpAAI',
            CCXR_Quantity__c = 2,
            CCXR_Items_ID__c = 'a002w00000aFdgDAAS',
            
            Order_status__c = 'Preparing'
        );
        insert new List<CCXR_Chef_Orders__c> { order1, order2 };
            
            // Test method execution
            List<CCXR_Chef_Orders__c> orders = Chefscreencontroller.getAllcheforders();
        
        // Assertion
        System.assertEquals(2, orders.size());
    }
    @isTest
    private static void testUpdateChefOrderStatus()
    {
         CCXR_Chef_Orders__c order = new CCXR_Chef_Orders__c();
        order.Order_status__c = 'Pending';
        order.CCXR_Order_Id__c = 'a022w00000nh3GpAAI';
        insert order;
        
        // Create a test chef employee record
        CCXR_Restaurant_Employee__c employee = new CCXR_Restaurant_Employee__c();
        employee.CCXR_Type_of_Employee__c = 'Chef';
        employee.CCXR_Name__c = 'Test Chef';
        insert employee;
        //calling apex class
        Chefscreencontroller.updatecheforderstatus(order.Id, employee.Id, true, false);
        
        // Retrieve the updated record and verify 
        CCXR_Chef_Orders__c updatedOrder = [SELECT Order_status__c, Assignedtochef__c, button__c, button1__c FROM 
                                            CCXR_Chef_Orders__c WHERE Id =:order.Id];
        System.assertEquals('Preparing', updatedOrder.Order_status__c);
        System.assertEquals(employee.Id, updatedOrder.Assignedtochef__c);
        System.assertEquals(true, updatedOrder.button__c);
        System.assertEquals(false, updatedOrder.button1__c);
    }
    @isTest
    private static void testUpdateChefOrderStatus1() {
        // Test data setup
        CCXR_Chef_Orders__c order = new CCXR_Chef_Orders__c(
            CCXR_Order_Id__c = 'a022w00000nh3GpAAI',
            CCXR_Quantity__c = 1,
            CCXR_Items_ID__c = 'a002w00000aFdgDAAS',
            
            Order_status__c = 'Preparing'
        );
        insert order;
        
        // Test method execution
        Chefscreencontroller.updatecheforderstatus1(order.Id, true);
        order = [SELECT Id, Order_status__c, button1__c FROM CCXR_Chef_Orders__c WHERE Id = :order.Id];
        
        // Assertion
        System.assertEquals('Ready', order.Order_status__c);
        System.assertEquals(true, order.button1__c);
    }
    @isTest
    private static void testUpdateChefEmployeeBusy() 
    {
        // Test data setup
        CCXR_Restaurant_Employee__c emp = new CCXR_Restaurant_Employee__c();
        emp.CCXR_Name__c = 'Test Chef';
        emp.CCXR_Type_of_Employee__c = 'Chef';
        
        insert emp;
        
        CCXR_Chef_Status__c chefStatus = new CCXR_Chef_Status__c();
        chefStatus.CCXR_Restaurant_Employee__c = emp.Id;
        chefStatus.CCXR_Chef_Current_Status__c = 'Available';
        
        insert chefStatus;
        
        
        
        
        //Arrange
        CCXR_Restaurant_Employee__c emp1 = [SELECT Id FROM CCXR_Restaurant_Employee__c WHERE 
                                            CCXR_Name__c ='Test Chef' LIMIT 1];
        
        
        
        Chefscreencontroller.updatechefemployeebusy(emp1.Id);
        
        
        //Assert
        CCXR_Chef_Status__c chefStatus1 = [SELECT CCXR_Chef_Current_Status__c FROM CCXR_Chef_Status__c 
                                           WHERE CCXR_Restaurant_Employee__c =: emp1.Id LIMIT 1];
        System.assertEquals('Busy', chefStatus1.CCXR_Chef_Current_Status__c);
        
        
        
    }
     @isTest
    private static void testupdatechefemployeeavailable() 
    {
         CCXR_Restaurant_Employee__c emp = new CCXR_Restaurant_Employee__c();
        emp.CCXR_Name__c = 'Test Chef';
        emp.CCXR_Type_of_Employee__c = 'Chef';
        insert emp;
        
        Chefscreencontroller.updatechefemployeeavailable(emp.Id);
        CCXR_Chef_Status__c chefsta=[select id ,CCXR_Chef_Current_Status__c from CCXR_Chef_Status__c where CCXR_Restaurant_Employee__c=:emp.id];
        chefsta.CCXR_Chef_Current_Status__c ='Available';
        update chefsta;
        
        
        
    }
}