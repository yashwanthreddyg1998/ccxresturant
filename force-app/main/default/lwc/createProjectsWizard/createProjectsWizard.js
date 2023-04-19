import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from "lightning/navigation"; 
import ProjectID from '@salesforce/schema/CCX_Project__c.Name';
import ProjectName from '@salesforce/schema/CCX_Project__c.CCX_Project_Name__c';
import AStartDate from '@salesforce/schema/CCX_Project__c.CCX_Actual_Start_Date__c';
import AEndDate from '@salesforce/schema/CCX_Project__c.CCX_Actual_End_Date__c';
import PStartDate from '@salesforce/schema/CCX_Project__c.CCX_Planned_Start_Date__c';
import PEndDate from '@salesforce/schema/CCX_Project__c.CCX_Planned_End_Date__c';
import PDesc from '@salesforce/schema/CCX_Project__c.CCX_Project_Description__c';
export default class CreateProjectsWizard extends NavigationMixin(LightningElement) {
        objectApiName='CCX_Project__c';
        fieldList=[ProjectID,ProjectName,AStartDate,AEndDate,PStartDate,PEndDate,PDesc];
        handleProjectCreate(event){
            const showSuccess = new ShowToastEvent({
                title: 'Success!!',
                message: 'Project Created Successfully',
                variant: 'Success',
            });
            this.dispatchEvent(showSuccess);
            
            this.recordId=event.target.value;
            this[NavigationMixin.Navigate]({
                type: 'standard__navItemPage',
                attributes: {
                    recordid:this.recordId,
                    apiName: 'CCX_On_Project_Screen',
                    actionName: 'edit'
                },            
            })
           
        }
    }