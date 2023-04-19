import { LightningElement,track,api } from 'lwc';
import Name from '@salesforce/schema/CCX_Assigned__c.Name'
import Activity from '@salesforce/schema/CCX_Assigned__c.CCX_Activity__c'
import Employee from '@salesforce/schema/CCX_Assigned__c.CCX_Employee__c'
import Role from '@salesforce/schema/CCX_Assigned__c.CCX_Role__c'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CcxAssignedForm extends LightningElement 
{
    @api recordidd;
    objectApiName='CCX_Assigned__c';
    Fields=[Name,Activity,Employee,Role];

    recordCreated(){
        const showSuccess = new ShowToastEvent({
            title: 'Success!!',
            message: 'Assigned created Successfully',
            variant: 'Success',
        });
        this.dispatchEvent(showSuccess);
      
    }
}