import { LightningElement,track,wire,api } from 'lwc';
import getEmpList from '@salesforce/apex/EmployeeDataController.getEmployeeList';

export default class CcrRS1 extends LightningElement {
    @track error  ;
    @track empList ;

    columns = [
        { id:'1',label: 'Name', fieldName: 'CCXR_Name__c' },
        { id:'2',label: 'Type Of Employee', fieldName: 'CCXR_Type_of_Employee__c' },
        { id:'3',label: 'Phone Number', fieldName: 'CCXR_Phone__c', type: 'phone' },
        { id:'4',label: 'Email Address', fieldName: 'CCXR_Email__c', type: 'email' },
        { id:'5',label: 'Status', fieldName: 'CCXR_Chef_Statuses__r.CCXR_Chef_Current_Status__c' }
       ];

       @wire(getEmpList)
       wiredColumns({
           error,
           data
       }) {
           if (data) {
               this.empList = data;
           } else if(error) {
               this.error = error;
           }
       }
}