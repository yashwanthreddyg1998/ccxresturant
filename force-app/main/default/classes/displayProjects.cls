public class displayProjects {
    @AuraEnabled(cacheable=true)
    public static  void getProjects(){
       /* LISt<CCX_Project__c> project=[Select CCX_Project_Name__c,
                                      (select Name,CCX_Start_Date__c FROM CCX_On_Projects__r)
                                      From CCX_Project__c];
        system.debug('ID:'+project);
        return project;
        */
        
        for(CCX_Project__c u: [select CCX_Project_Name__c,(select Name,CCX_Start_Date__c FROM CCX_On_Projects__r) from CCX_Project__c])
		{   
    		for(CCX_On_Project__c c:u.CCX_On_Projects__r)
         	System.debug('Project Name:'+u.CCX_Project_Name__c+'   On Project Name:'+c.Name);
           
		}
        
        
    }
}