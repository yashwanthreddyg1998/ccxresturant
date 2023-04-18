import { LightningElement,track,wire,api } from 'lwc';
import getEmpList from '@salesforce/apex/EmployeeDataController.getEmployeeList';
import getItmList from '@salesforce/apex/EmployeeDataController.getItemList';
import { NavigationMixin } from 'lightning/navigation';
import noHeader from '@salesforce/resourceUrl/NoHeader';
import {loadStyle} from "lightning/platformResourceLoader";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';
export default class CcxRestaurantManager extends NavigationMixin(LightningElement) 
{
    @track error;
    @track empList ;
    @api  itmList;
 
    @track isShowModal=false;

     @wire(getEmpList,{ } )
       wiredColumns(result)
       {
         this.wiredData = result;
         this.empList = result.data;
         this.errors = result.error;
       }
    showModalBox() {  
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }


    @track showAddEmpComponent = false;
    showComp3() {
    this.showAddEmpComponent = true;
    }
    hideModalBox1() {  
        this.showAddEmpComponent = false;
    }

    @track displayEmpComponent = false;
    showComp4() {
    this.displayEmpComponent = true;
    return refreshApex(this.wiredData);

    }

    @track showAddItem2Component=false;

    showModalBox() {  
        this.showAddItem2Component = true;
    }

    hideModalBox() {  
        this.showAddItem2Component = false;
    }

    iconName1;
    iconName2;
    iconName3;
    iconName4;
    iconName5;
    iconName6;

    connectedCallback() {
    this.iconName1 = "standard:home";
    this.iconName2 = "standard:people";
    this.iconName3 = "standard:scan_card";
    this.iconName4 = "standard:identifier";
    this.iconName5 = "standard:feedback";
    this.iconName6 = "standard:record";

    loadStyle(this, noHeader);
    }

  columns = [
    { id:'1',label: 'Name', fieldName: 'CCXR_Name__c' },
    { id:'2',label: 'Type Of Employee', fieldName: 'CCXR_Type_of_Employee__c' },
    { id:'3',label: 'Phone Number', fieldName: 'CCXR_Phone__c', type: 'phone' },
    { id:'4',label: 'Email Address', fieldName: 'CCXR_Email__c', type: 'email' },
    { id:'5',label: 'Status', fieldName: 'CCXR_Chef_Statuses__r.CCXR_Chef_Current_Status__c' }
   ];

   itmList = [
    { id:'1',label: 'Item Name', fieldName: 'CCXR_Item_Name__c' },
    { id:'2',label: 'Item Status', fieldName: 'CCXR_Item_Status__c' },
    { id:'3',label: 'Item Image', fieldName: 'Item_Image_Link__c' },
    { id:'4',label: 'Item Description', fieldName: 'CCXR_Description__c' },
    { id:'5',label: 'Item Description', fieldName: 'CCXR_Price__c' }
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


    @wire(getItmList)
   WiredItems({
        error,
        data
    }) {
        if (data) {
            this.itmList = data;
        } else if(error) {
            this.error = error;
        }
    }

    

}