import { LightningElement } from 'lwc';
import User_Account_ID from '@salesforce/schema/CCX_User_Account__c.Name';
import CCX_First_Name__c from '@salesforce/schema/CCX_User_Account__c.CCX_First_Name__c';
import CCX_Last_Name__c from '@salesforce/schema/CCX_User_Account__c.CCX_Last_Name__c';
import CCX_Email__c from '@salesforce/schema/CCX_User_Account__c.CCX_Email__c';
import CCX_User_Name__c from '@salesforce/schema/CCX_User_Account__c.CCX_User_Name__c';
import CCX_Password__c from '@salesforce/schema/CCX_User_Account__c.CCX_Password__c';
import CCX_Is_Project_Manager__c from '@salesforce/schema/CCX_User_Account__c.CCX_Is_Project_Manager__c';
import CCX_Registration_Time__c from '@salesforce/schema/CCX_User_Account__c.CCX_Registration_Time__c';

import {NavigationMixin} from 'lightning/navigation';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class UserAccount extends LightningElement {

    objectApiName='CCX_User_Account__c';
    fieldList=[CCX_First_Name__c,CCX_Last_Name__c,CCX_Email__c,CCX_User_Name__c,CCX_Password__c,CCX_Is_Project_Manager__c,CCX_Registration_Time__c];  

    handleUserAccountCreate(event){
        const evt= new ShowToastEvent({
            title:"User Account Record Created Successfully",
            message:"Record id :"+event.detail.id,
            variant:"success",
        });
    
        showEmployeePage() 
        {  
            this.showEmployeePage = true;
        }
        this.dispatchEvent(evt);
       /* this[NavigationMixin.Navigate]({
            type: 'custom__objectPage',
                attributes: {
                objectApiName: 'CCX_Employee__c',
                actionName: 'home'
                },
            });*/
  }
}