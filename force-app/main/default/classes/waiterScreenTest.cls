@isTest
private class waiterScreenTest {

    @isTest
   private static void testGetAllAccountss() {
        // Test data setup
       
       CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Items__c item = new CCXR_Items__c();
        item.CCXR_Item_Name__c='Test Food Item';
        item.CCXR_Price__c=100;
        item.CCXR_Item_Status__c='Available';
        item.CCXR_Serves__c=2;
        insert item;
        
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
        
        CCXR_Customer_Table_Status__c cst=new CCXR_Customer_Table_Status__c();
        cst.CCXR_Customer__c=cust.id;
        cst.CCXR_Table__c=tb.Id;
        cst.Customer_Table_Status__c='Occupied';
        insert cst;
        
        
        CCXR_Order__c ord = new CCXR_Order__c(CCXR_Customer_Table_Status__c=cst.id);
        insert ord;
       
       
       CCXR_Chef_Orders__c order = new CCXR_Chef_Orders__c(
            CCXR_Order_Id__c = ord.id,
            CCXR_Items_ID__c = item.id,
            Order_status__c = 'Ready'
        );
        insert order;

        // Call the method being tested
        List<CCXR_Chef_Orders__c> orders = waiterScreenController.getAllAccountss();

        // Assert the results
        System.assertEquals(1, orders.size());
        System.assertEquals(order.Id, orders[0].Id);
    }
	@isTest
    private static void testStatuspick() {
        // Test data setup
        
        CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Items__c item = new CCXR_Items__c();
        item.CCXR_Item_Name__c='Test Food Item';
        item.CCXR_Price__c=100;
        item.CCXR_Item_Status__c='Available';
        item.CCXR_Serves__c=2;
        insert item;
        
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
        
        CCXR_Customer_Table_Status__c cst=new CCXR_Customer_Table_Status__c();
        cst.CCXR_Customer__c=cust.id;
        cst.CCXR_Table__c=tb.Id;
        cst.Customer_Table_Status__c='Occupied';
        insert cst;
        
        
        CCXR_Order__c ord = new CCXR_Order__c(CCXR_Customer_Table_Status__c=cst.id);
        insert ord;
        
        CCXR_Chef_Orders__c order = new CCXR_Chef_Orders__c(
            CCXR_Order_Id__c = ord.Id,
            CCXR_Items_ID__c = item.Id,
            Order_status__c = 'Ready',
            button3__c = false,
            button4__c = false
        );
        insert order;

        // Call the method being tested
        waiterScreenController.statuspick(order.Id, true, true);

        // Retrieve the updated record
        CCXR_Chef_Orders__c updatedOrder = [SELECT Id, Order_status__c, button3__c, button4__c 
                                            FROM CCXR_Chef_Orders__c WHERE Id = :order.Id];

        // Assert the results
        System.assertEquals('Picked-up', updatedOrder.Order_status__c);
        System.assertEquals(true, updatedOrder.button3__c);
        System.assertEquals(true, updatedOrder.button4__c);
    }
    @isTest
    private static void testStatusser() {
        // Test data setup
        
        CCXR_Restaurant_Employee__c	 rsc=new CCXR_Restaurant_Employee__c();
        rsc.CCXR_Aadhar_Number__c='5328 6358 1129';
        rsc.CCXR_Phone__c='7207601245';
        rsc.CCXR_Type_of_Employee__c='Waiter';
        insert rsc;
        
        CCXR_Items__c item = new CCXR_Items__c();
        item.CCXR_Item_Name__c='Test Food Item';
        item.CCXR_Price__c=100;
        item.CCXR_Item_Status__c='Available';
        item.CCXR_Serves__c=2;
        insert item;
        
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
        
        CCXR_Customer_Table_Status__c cst=new CCXR_Customer_Table_Status__c();
        cst.CCXR_Customer__c=cust.id;
        cst.CCXR_Table__c=tb.Id;
        cst.Customer_Table_Status__c='Occupied';
        insert cst;
        
        
        CCXR_Order__c ord = new CCXR_Order__c(CCXR_Customer_Table_Status__c=cst.id);
        insert ord;
        
        CCXR_Chef_Orders__c order = new CCXR_Chef_Orders__c(
            CCXR_Order_Id__c = ord.id,
            CCXR_Items_ID__c = item.Id,
            Order_status__c = 'Ready',
            button4__c = false
        );
        insert order;

        // Call the method being tested
        waiterScreenController.statusser(order.Id, true);

        // Retrieve the updated record
        CCXR_Chef_Orders__c updatedOrder = [SELECT Id, Order_status__c, button4__c FROM CCXR_Chef_Orders__c WHERE Id = :order.Id];

        // Assert the results
        System.assertEquals('Served', updatedOrder.Order_status__c);
        System.assertEquals(true, updatedOrder.button4__c);
    }
}