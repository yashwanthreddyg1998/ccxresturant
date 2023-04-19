import { LightningElement,api } from 'lwc';
import Name from '@salesforce/schema/CCX_Task__c.Name'
import TaskName from '@salesforce/schema/CCX_Task__c.CCX_Task_Name__c'
import ProjectId from '@salesforce/schema/CCX_Task__c.CCX_Project__c'
import priority from '@salesforce/schema/CCX_Task__c.CCX_Priority__c'
import Description from '@salesforce/schema/CCX_Task__c.CCX_Description__c'
import PlannedStartDate from '@salesforce/schema/CCX_Task__c.CCX_Planned_Start_Date__c'
import PlannedEndDate from '@salesforce/schema/CCX_Task__c.CCX_Planned_End_Date__c'
import ActualStartDate from '@salesforce/schema/CCX_Task__c.CCX_Actual_Start_Date__c'
import ActualEndDate from '@salesforce/schema/CCX_Task__c.CCX_Actual_End_Date__c'
import ActualBudget from '@salesforce/schema/CCX_Task__c.CCX_Actual_Budget__c'
import Plannedbudget from '@salesforce/schema/CCX_Task__c.CCX_Planned_Budget__c'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { NavigationMixin } from "lightning/navigation"; 

export default class Ccxtaskform extends  NavigationMixin(LightningElement )
 {
    @api recordId;
    objectApiName='CCX_Task__c';
    Fields=[Name, TaskName,ProjectId,priority,Description,PlannedStartDate,PlannedEndDate,ActualStartDate,
              ActualEndDate, ActualBudget,Plannedbudget];

    recordCreated(event){
        const showSuccess = new ShowToastEvent({
            title: 'Success!!',
            message: 'Task created Successfully',
            variant: 'Success',
        });
        this.dispatchEvent(showSuccess);
        
        this.recordId=event.target.value;
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                recordid:this.recordId,
                apiName: 'CCX_Activity_Screen',
                actionName: 'edit'
            },            
        })
       
    }
}