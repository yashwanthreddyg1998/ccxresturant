import { LightningElement,track,api } from 'lwc';
import Name from '@salesforce/schema/CCX_Activity__c.CCX_Activity_Name__c'
import ActualBudget from '@salesforce/schema/CCX_Activity__c.CCX_Actual_Budget__c'
import ActualEndDate from '@salesforce/schema/CCX_Activity__c.CCX_Actual_End_Date__c'
import ActualStartDate from '@salesforce/schema/CCX_Activity__c.CCX_Actual_Start_Date__c'
import PlannedBudget from '@salesforce/schema/CCX_Activity__c.CCX_Planned_Budget__c'
import PlannedStartDate from '@salesforce/schema/CCX_Activity__c.CCX_Planned_Start_Date__c'
import PlannedEndDate from '@salesforce/schema/CCX_Activity__c.CCX_Planned_End_Date__c'
import Priority from '@salesforce/schema/CCX_Activity__c.CCX_Priority__c'
import Task from '@salesforce/schema/CCX_Activity__c.CCX_Task__c'
import Description from '@salesforce/schema/CCX_Activity__c.CCX_Description__c'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from "lightning/navigation"; 

export default class CcxActivityForm extends NavigationMixin(LightningElement )
{
    
    @api accountRecordId;
    objectApiName='CCX_Activity__c';

    Fields1=[Name,ActualBudget,ActualStartDate,ActualEndDate,PlannedBudget,PlannedStartDate,PlannedEndDate,
             Priority,Task,Description ];

    recordCreated(event){
        alert('hivc');
        this.accountRecordId = event.detail.id;
        alert(this.accountRecordId);
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                recordidd:this.accountRecordId,
                apiName: 'CCX_Assigned_Form',
                actionName: 'edit'
            },
            state : {
                nooverride: '1',
                defaultFieldValues:"Activity=this.accountRecordId"
            }
            
        })
      
     
    }

}
    
   /* handleButton(event){
        this.recordId=event.target.value;
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'CCX_Assigned_Form',
                actionName: 'edit'
            },
            
        })
    }*/