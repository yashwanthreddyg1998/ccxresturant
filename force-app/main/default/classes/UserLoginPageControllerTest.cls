@IsTest
private class UserLoginPageControllerTest {
    
    @IsTest
    static void testCheckDetails() {
        // Create test user
        CCXR_User__c user = new CCXR_User__c();
        user.UserName__c='testuser';
        user.Password__c='testpassword';
        user.Employee_Type__c='Waiter';
        insert user;
        
        // Test successful login
        String result = UserLoginPageController.checkDetails('testuser', 'testpassword');
        System.assertEquals('Login successful!', result);
        
        // Test invalid password
        result = UserLoginPageController.checkDetails('testuser', 'wrongpassword');
        System.assertEquals('Invalid password, please try again', result);
        
        // Test user does not exist
        result = UserLoginPageController.checkDetails('nonexistentuser', 'anypassword');
        System.assertEquals('User does not exist', result);
    }
    
    @IsTest
    static void testGetDetails() {
        // Create test user
        CCXR_User__c user = new CCXR_User__c();
        user.UserName__c='testuser';
        user.Password__c='testpassword';
        user.Employee_Type__c='Waiter';
        insert user;
        
        // Test getting user details
        CCXR_User__c result = UserLoginPageController.getDetails('testuser');
        System.assertEquals(user.Id, result.Id);
        System.assertEquals(user.UserName__c, result.UserName__c);
        System.assertEquals(user.Password__c, result.Password__c);
        System.assertEquals(user.Employee_Type__c, result.Employee_Type__c);
    }
    
}