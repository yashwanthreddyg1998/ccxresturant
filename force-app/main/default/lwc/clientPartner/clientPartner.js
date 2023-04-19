import { LightningElement,track } from 'lwc';
import Name from '@salesforce/schema/CCX_Client_Partner__c.Name';
import CCX_CP_Address__c from '@salesforce/schema/CCX_Client_Partner__c.CCX_CP_Address__c';
import CCX_CP_Details__c from '@salesforce/schema/CCX_Client_Partner__c.CCX_CP_Details__c';
import CCX_CP_Name__c from '@salesforce/schema/CCX_Client_Partner__c.CCX_CP_Name__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 
export default class CustomerScreen extends LightningElement {
    objectApiName='CCX_Client_Partner__c';
    fieldList=[Name,CCX_CP_Address__c,CCX_CP_Details__c,CCX_CP_Name__c,];
    
    @track newcust = true;

    options = [
        
        { label: 'Client Partner', value: 'Client Partner' }
    ];

    handleCustomerCreate()
    {
            const showSuccess = new ShowToastEvent({
                title: 'Success!!',
                message: 'Client Partner Success',
                variant: 'Success',
            });
            this.dispatchEvent(showSuccess);
    }
}