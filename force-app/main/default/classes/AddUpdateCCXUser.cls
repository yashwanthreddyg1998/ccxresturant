public class AddUpdateCCXUser {
        public static void addCCXUser(List<User> newusers)
        {
           list<CCXR_User__c> addnewusers=new list<CCXR_User__c>();
            For(User u:newusers)
            {
               CCXR_User__c newuser=new CCXR_User__c();
                newuser.UserName__c=u.UserName;
                addnewusers.add(newuser);
            }
            insert addnewusers;
        }
        public static void updateCCXUser(List<User> oldusers,List<User> updatedusers)
        {
            List<Id> userIds=new List<Id>();
             For(User u:oldusers)
             {
                userIds.add(u.Id); 
             }
           
          list<CCXR_User__c> updatenewusers=[select id,Username__c,UserId__c,Password__c From CCXR_User__c
                                             Where UserId__c in:userIds];
          list<CCXR_User__c> updatenewusers2=new list<CCXR_User__c>();
            For(User u:updatedusers)
            {
                For(CCXR_User__c nu:updatenewusers)
            {
               CCXR_User__c updateuser=new CCXR_User__c();
                if(u.Id==nu.UserId__c && u.UserName !=nu.UserName__c)
                {
                nu.UserName__c=u.UserName;
                updatenewusers2.add(nu);
            }
            }
            update updatenewusers2;  
        }
        }
    }