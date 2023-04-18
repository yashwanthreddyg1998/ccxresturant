/* 
  Author : Siddam Shashank 
  Creation Date : 12/03/2023
  Last Modification : 15/03/2023
  Purpose : To insert feedback from customers using "feedbackRecMethod" method. 
*/

public with sharing class feedbackcontroller {
    @AuraEnabled
    public static CCXR_Feedback__c feedbackRecMethod(CCXR_Feedback__c accRec)
    {
        insert accRec;
        return accRec;
    }
}