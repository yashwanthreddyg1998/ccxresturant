import { LightningElement,track } from 'lwc';
import CCXR_CustomerID from '@salesforce/schema/CCXR_Customer__c.Name';
import CCXR_Name from '@salesforce/schema/CCXR_Customer__c.CCXR_Name__c';
import CCXR_Email from '@salesforce/schema/CCXR_Customer__c.CCXR_Email__c';
import CCXR_No_of_Visits from '@salesforce/schema/CCXR_Customer__c.CCXR_No_of_Visits__c';
import CCXR_Phone_Number__c from '@salesforce/schema/CCXR_Customer__c.CCXR_Phone_Number__c';
import No_Of_Persons__c from '@salesforce/schema/CCXR_Customer__c.No_Of_Persons__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 
export default class CustomerScreen extends LightningElement {
    objectApiName='CCXR_Customer__c';
    fieldList=[CCXR_CustomerID,CCXR_Name,CCXR_Email,CCXR_No_of_Visits,CCXR_Phone_Number__c,No_Of_Persons__c];
    @track excustomer = false;
    @track newcust = false;

    options = [
        { label: 'Existing Customer', value: 'Existing Customer' },
        { label: 'New Customer', value: 'New Customer' }
    ];

    handleCustomerCreate()
    {
            const showSuccess = new ShowToastEvent({
                title: 'Success!!',
                message: 'Customer Registration Success',
                variant: 'Success',
            });
            this.dispatchEvent(showSuccess);
    }

    handleChange(event) 
    {
        this.selectedValue=event.target.value;
            if(this.selectedValue=='Existing Customer')
            {
                this.excustomer=true;
                this.newcust=false;
            }
            else             
            {
                this.newcust=true;
                this.excustomer=false;
            }
     }
}