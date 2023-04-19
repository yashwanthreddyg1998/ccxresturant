import { LightningElement ,track,api} from 'lwc';

import CCX_User_Name__c from'@salesforce/schema/CCX_User_Account__c.CCX_User_Name__c';
import CCX_Password__c from'@salesforce/schema/CCX_User_Account__c.CCX_Password__c';
import CCX_Registration_Time__c from'@salesforce/schema/CCX_User_Account__c.CCX_Registration_Time__c';
import CCX_Email__c from'@salesforce/schema/CCX_User_Account__c.CCX_Email__c';
import CCX_Is_Project_Manager__c from'@salesforce/schema/CCX_User_Account__c.CCX_Is_Project_Manager__c';
import CCX_Last_Name__c from'@salesforce/schema/CCX_User_Account__c.CCX_Last_Name__c';
import CCX_First_Name__c from'@salesforce/schema/CCX_User_Account__c.CCX_First_Name__c';

import CCX_Employee_Name__c from'@salesforce/schema/CCX_Employee__c.CCX_Employee_Name__c';
import CCX_User_Account__c from'@salesforce/schema/CCX_Employee__c.CCX_User_Account__c';

import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {NavigationMixin} from 'lightning/navigation';

export default class UserAccountScreen extends LightningElement {

    @track isEmployeeCreationEnabled = false;
    @track isUserAccountCreationEnabled = true;
        
    @api recordid;
    
    objectApiName1='CCX_User_Account__c';
    fieldList1=[CCX_User_Name__c,CCX_Password__c,CCX_First_Name__c,CCX_Last_Name__c,CCX_Registration_Time__c,CCX_Is_Project_Manager__c,CCX_Email__c];

    handleUserAccountCreate(event)
    {
        this.isUserAccountCreationEnabled=false;
        this.isEmployeeCreationEnabled=true;

        const evt= new ShowToastEvent({
            title:"User Account Record Created Successfully",
            message:"Record id :"+event.detail.id,
            variant:"success",
        });
        
        this.dispatchEvent(evt);
        this.recordid=event.detail.id;

        alert(this.recordid);
        this.fieldList2 = [CCX_Employee_Name__c,CCX_User_Account__c];
    }

  objectApiName2='CCX_Employee__c';
  handleEmployeeCreate(event)
  {
    const evt= new ShowToastEvent({
        title:"Employee Record Created Successfully",
        message:"Record id :"+event.detail.id,
        variant:"success",
    });

  this.dispatchEvent(evt);
  }
}