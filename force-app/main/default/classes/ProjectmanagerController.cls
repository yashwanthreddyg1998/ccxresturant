public with sharing class ProjectmanagerController

{
    @AuraEnabled(cacheable=true)
    public static List<CCX_Project_Manager__c>  getprojectmanagerrecords()
    {
        list<CCX_Project_Manager__c> pmrec =[select CCX_Project__c,CCX_User_Account__c,Name from CCX_Project_Manager__c];     
         /*system.debug(pmrec);
        for(CCX_Project_Manager__c pmrec1:pmrec)
        {
            system.debug('project:'+pmrec1.CCX_Project__c);
        system.debug('user account :'+pmrec1.CCX_User_Account__c);
        system.debug('name:'+pmrec1.Name);
        }*/
       
        return pmrec;
       
    }
    

}