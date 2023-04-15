import { LightningElement,track,wire,api } from 'lwc';
import getEmpList from '@salesforce/apex/EmployeeDataController.getEmployeeList';
import deleteRecordById from '@salesforce/apex/EmployeeDataController.deleteEmp';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import employee_obj from '@salesforce/schema/CCXR_Restaurant_Employee__c';
import typeofemp from '@salesforce/schema/CCXR_Restaurant_Employee__c.CCXR_Type_of_Employee__c';
//import BackgroundImg from '@salesforce/resourceUrl/logo2';
import { NavigationMixin } from "lightning/navigation";
import {refreshApex} from '@salesforce/apex';

export default class CcrRS1 extends NavigationMixin(LightningElement )
{ 
    //imageUrl = BackgroundImg;
    records;
    sortedColumn;
    sortedDirection = 'asc';
    initialRecords;
    @track searchKey;
    @track options1 = [];
    @track error ;
    @track empList;
    @api drecordId;
    @track i=0;
    @api upRecordIDs;
    columns = [
        { id:'1',label: 'Name', fieldName: 'CCXR_Name__c' },
        { id:'2',label: 'Type Of Employee', fieldName: 'CCXR_Type_of_Employee__c' },
        { id:'3',label: 'Phone Number', fieldName: 'CCXR_Phone__c', type: 'phone' },
        { id:'4',label: 'Email Address', fieldName: 'CCXR_Email__c', type: 'email' },
        { id:'5',label: 'Status', fieldName: 'CCXR_Chef_Statuses__r.CCXR_Chef_Current_Status__c' }
       ];

       @wire(getObjectInfo, { objectApiName: employee_obj })
    objectInfo;
    
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: typeofemp})
    typePicklistValues({error, data}) {
        if(data) {
            this.options1 = data.values;
        }
        
    }


    @wire( getEmpList )  
    wiredAccount( { error, data } ) {
      if (data) {
    
          this.records = data;
          this.initialRecords = data;
          this.error = undefined;
    
      } else if ( error ) {
    
          this.error = error;
          this.initialRecords = undefined;
          this.records = undefined;
    
      }
    } 

   

    handleKeyChange(event) {
        this.searchKey = event.target.value;
    
        console.log('Search Key is ' + this.searchKey);
    
        if (this.searchKey) {
            this.records = this.initialRecords;
    
            if (this.records) {
                let recs = [];
                for (let rec of this.records) {
                    let fieldValue = rec['CCXR_Type_of_Employee__c'];
                    console.log('Rec is ' + JSON.stringify(rec));
                    let valuesArray = Object.values(rec);
                    console.log('valuesArray is ' + valuesArray);
    
                    if (this.searchKey.toLowerCase() === 'all') {
                        recs.push(rec);
                    }
                    else if (fieldValue && fieldValue.toLowerCase() === this.searchKey.toLowerCase()) {
                        recs.push(rec);
                    }
                }
    
                console.log('Recs if are ' + JSON.stringify(recs));
                this.records = recs;
            }
    
        } else  {
            // Set records to initialRecords to show all data
            this.records = this.initialRecords;
        }
    }


       
       @wire(getEmpList,{ } )
       wiredColumns(result)
       {
         this.wiredData = result;
         this.records = result.data;
         this.errors = result.error;
       }
      /* get getBackgroundImage(){
        return `background-image:url("${this.imageUrl}")`;
    }*/
    
    handleDelete(event) 
    {
        this.drecordId=event.target.value;
        
        
        deleteRecordById({selRecordId:this.drecordId})
          .then(() => {
           
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted successfully.',
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredData);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Error deleting record: ' + error.body.message,
                        variant: 'error'
                    })
                );
            });
            
    }
    handleUpdate(event)
       {
           
            this.upRecordIDs=event.target.value;
            
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.upRecordIDs,
                    objectApiName: 'CCXR_Restaurant_Employee__c',
                    actionName: 'edit'
                },
                
            }),
            this.i=0;
            return refreshApex(this.wiredData);
           
            
        }
        handleMouseOver() {
            if(this.i >= 1)
            {
                return refreshApex(this.wiredData);
            }
            this.i++;
            console.log(this.i);
        }
    
    
}