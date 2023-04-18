import { LightningElement } from 'lwc';
import Name from '@salesforce/schema/CCXR_Restaurant_Employee__c.CCXR_Name__c'
import Phone from '@salesforce/schema/CCXR_Restaurant_Employee__c.CCXR_Phone__c'
import Email from '@salesforce/schema/CCXR_Restaurant_Employee__c.CCXR_Email__c'
import Aadhar_Number from '@salesforce/schema/CCXR_Restaurant_Employee__c.CCXR_Aadhar_Number__c'
import Type_of_Employee from '@salesforce/schema/CCXR_Restaurant_Employee__c.CCXR_Type_of_Employee__c'
import Type_Of_Chef from '@salesforce/schema/CCXR_Restaurant_Employee__c.CCXR_Type_Of_Chef__c'
//import BackgroundImg from '@salesforce/resourceUrl/logo2';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 
export default class Registration extends LightningElement {
   /* imageUrl = BackgroundImg;

    get getBackgroundImage(){
        return `background-image:url("${this.imageUrl}")`;
    }
   */
    objectApiName = 'CCXR_Restaurant_Employee__c'; 
    Fields1 = [Name, Phone,Email,Aadhar_Number,Type_of_Employee,Type_Of_Chef]; 

    recordCreated(){
        const showSuccess = new ShowToastEvent({
            title: 'Success!!',
            message: 'Registration Success',
            variant: 'Success',
        });
        this.dispatchEvent(showSuccess);
    }
}