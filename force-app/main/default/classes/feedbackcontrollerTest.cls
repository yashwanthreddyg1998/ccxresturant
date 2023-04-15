@istest
private class feedbackcontrollerTest 
{
    @istest
    
    private static void insertingfeedbackrecord()
    {
        //creating customer data
        CCXR_Customer__c customer = new CCXR_Customer__c();
        customer.CCXR_Name__c = 'uday';
        customer.No_Of_Persons__c = 7;
        customer.CCXR_Phone_Number__c ='453728';
        insert customer;
        
        //creating table data
        CCXR_Table__c table = new CCXR_Table__c();
        table.CCXR_Capacity__c = 8;
        insert table;
        //Creating CustomerStatus Table Data
        CCXR_Customer_Table_Status__c customerStatus = new CCXR_Customer_Table_Status__c ();
        customerStatus.CCXR_Customer__c = customer.Id;
        customerStatus.CCXR_Table__c = table.Id;
        customerStatus.Customer_Table_Status__c = 'Occupied';
        customerStatus.Token_Number__c = 8750;
        insert customerStatus;
        //Creating Order
        CCXR_Order__c neword = new CCXR_Order__c();
        neword.CCXR_Order_Status__c='Progress';
        neword.CCXR_Tax__c=0.05;
        neword.CCXR_Customer_Table_Status__c=customerStatus.Id;
        insert neword;
        
        //Creating Feedaback data
        CCXR_Feedback__c newfeedback = new CCXR_Feedback__c();
        newfeedback.CCXR_Food_Quality__c='Good';
        newfeedback.CCXR_Service_Quality__c='Average';
        newfeedback.CCXR_Suggestions__c='Oil should be decreased in food';
        newfeedback.CCXR_Order__c=neword.id;
        
       CCXR_Feedback__c insertedRec= feedbackcontroller.feedbackRecMethod( newfeedback);
        CCXR_Feedback__c retrievedRec = [SELECT Id, Name, CCXR_Food_Quality__c,CCXR_Service_Quality__c,CCXR_Order__c from CCXR_Feedback__c where Id=:insertedRec.Id];
        System.assertEquals(newfeedback.CCXR_Food_Quality__c, retrievedRec.CCXR_Food_Quality__c);
        
        
    }
    
    
}