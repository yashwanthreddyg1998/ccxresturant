public class UserLoginPageController {
    @AuraEnabled
    public static String checkDetails(String username, String password) { 
        List<CCXR_User__c> userList = [ SELECT Id, UserName__c, Password__c,Employee_Type__c FROM CCXR_User__c
          								  WHERE UserName__c = :username
          								  LIMIT 1];
        
        if(userList.isEmpty()) {
            return 'User does not exist'; 
        } else {
            CCXR_User__c user = userList[0];
            if(user.Password__c == password) {
                return 'Login successful!';
            } else {
                return 'Invalid password, please try again';
            }
        }
        
    }
   
    @AuraEnabled(cacheable=true)
    public static CCXR_User__c getDetails(string username) { 
        CCXR_User__c userList = [ SELECT Id,Employee_Type__c,UserName__c, Password__c FROM CCXR_User__c
          								where UserName__c=:username];
        return userList;
    }
}