import { LightningElement,track,wire,api } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import getItmList from '@salesforce/apex/EmployeeDataController.getItemList';
import items_obj from '@salesforce/schema/CCXR_Items__c';
import itemCategory from '@salesforce/schema/CCXR_Items__c.CCXR_Item_Category__c';
import itemsubCategory from '@salesforce/schema/CCXR_Items__c.CCXR_Item_SubCategory__c';
//import itemName from '@salesforce/schema/CCXR_Items__c.CCXR_Item_Name__c';
//import price from '@salesforce/schema/CCXR_Items__c.CCXR_Price__c';
import deleteRecordItm from '@salesforce/apex/EmployeeDataController.deleteItems';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//import BackgroundImg from '@salesforce/resourceUrl/logo2';
import { NavigationMixin } from "lightning/navigation";

export default class CcrRS extends NavigationMixin(LightningElement ) {
   // imageUrl = BackgroundImg;

    @track error;
    @track  records;
 @api record;
 @api key;
    @api upRecordIDs;
    @api imageURL;
    @api drecordId;
    @track searchKey;
    @track options1 = [];
  
    @wire(getObjectInfo, { objectApiName: items_obj })
      objectInfo;
      
      @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: itemCategory})
      typePicklistValues1({error, data}) {
          if(data) {
              this.options1 = data.values;
          }
         
      }
  
      @track options2 = [];
  
      @wire(getObjectInfo, { objectApiName: items_obj })
        objectInfo;
        
        @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: itemsubCategory})
        typePicklistValues({error, data}) {
            if(data) {
                this.options2 = data.values;
            }
           
        }
        @wire( getItmList )  
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
    
    @track isShowModal=false;
    showModalBox() {  
        this.isShowModal = true;
    }
    hideModalBox() {  
        this.isShowModal = false;
    }

    @track showModalBox1 = false;
    showComp1() {
        this.showModalBox1 = true;
        this.records = this.initialRecords;
    }
    
    
    itmList = [
        { id:'1',label: 'Item Name', fieldName: 'CCXR_Item_Name__c' },
        { id:'2',label: 'Item Status', fieldName: 'CCXR_Item_Status__c' },
        { id:'3',label: 'Item Image', fieldName: 'Item_Image_Link__c' },
        { id:'4',label: 'Item Description', fieldName: 'CCXR_Description__c' },
        { id:'5',label: 'Item Description', fieldName: 'CCXR_Price__c' }
       ];

       
     
       /* get getBackgroundImage(){
            return `background-image:url("${this.imageUrl}")`;
        }*/
    handleDelete(event) 
        {
            this.drecordId=event.target.value;
            
            
            deleteRecordItm({delRecordId:this.drecordId})
              .then(() => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Record deleted successfully.',
                            variant: 'success'
                        })
                    );
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
            
            // getItmList({upRecordId:this.upRecordIDs})
             this[NavigationMixin.Navigate]({
                 type: 'standard__recordPage',
                 attributes: {
                     recordId: this.upRecordIDs,
                     objectApiName: 'CCXR_Items__c',
                     actionName: 'edit'
                 },
             });
        }

    
        handleKeyChange(event) {
          this.searchKey = event.target.value;
          this.key2=this.searchKey;
          this.searchKey1=this.key;
          console.log('Search Key is ' + this.searchKey);
          console.log('Search Key is ' + this.searchKey1);
          if(this.searchKey1){
        
          if (this.searchKey) {
            this.records = this.initialRecords;
        
            if (this.records) {
              let recs = [];
              for (let rec of this.records) {
                let fieldValue1 = rec['CCXR_Item_Category__c'];
                let fieldValue2 = rec['CCXR_Item_SubCategory__c'];
               
                if (this.searchKey.toLowerCase() === 'all') {
                  recs.push(rec);
              }
              else if (fieldValue1 && fieldValue1.toLowerCase() === this.searchKey.toLowerCase() &&
                    fieldValue2 && fieldValue2.toLowerCase() === this.searchKey1.toLowerCase()) {
                  recs.push(rec);
                }
              }
        
              
              this.records = recs;
             
            }
          } else {
            this.records = this.initialRecords;
          }
        }
        else{
          if (this.searchKey) {
            this.records = this.initialRecords;
        
            if (this.records) {
              let recs = [];
              for (let rec of this.records) {
                let fieldValue1 = rec['CCXR_Item_Category__c'];
               
               
                if (this.searchKey.toLowerCase() === 'all') {
                  recs.push(rec);
              }
              else if (fieldValue1 && fieldValue1.toLowerCase() === this.searchKey.toLowerCase() ) {
                  recs.push(rec);
                }
              }
        
              
              this.records = recs;
             
            }
          } else {
            this.records = this.initialRecords;
          }

        }
        }
        


     //Item subcategory
        handleKeyChange1( event ) {  
          this.searchKey = event.target.value;
          this.key=this.searchKey;
          this.searchKey1=this.key2;
          console.log('Search Key is ' + this.searchKey);
          console.log('Search Key is ' + this.searchKey1);
        
          if (this.searchKey) {
            this.records = this.initialRecords;
        
            if (this.records) {
              let recs = [];
              for (let rec of this.records) {
                let fieldValue1 = rec['CCXR_Item_Category__c'];
                let fieldValue2 = rec['CCXR_Item_SubCategory__c'];
               
        
                if (fieldValue1 && fieldValue1.toLowerCase() === this.searchKey1.toLowerCase() &&
                    fieldValue2 && fieldValue2.toLowerCase() === this.searchKey.toLowerCase()) {
                  recs.push(rec);
                }
              }
        
              
              this.records = recs;
             
            }
          } else {
            this.records = this.initialRecords;
          }
        }

        //Item Name
        handleKeyChange2( event ) {  
      
          this.searchKey = event.target.value;  
        
         console.log( 'Search Key is ' + this.searchKey );
        
         if (this.searchKey ) {  
        
             this.records = this.initialRecords;
        
              if ( this.records ) {
        
                 let recs = [];
                 for ( let rec of this.records ) {
                     let fieldValue = rec['CCXR_Item_Name__c'];
                     console.log( 'Rec is ' + JSON.stringify( rec ) );
                     let valuesArray = Object.values( rec );
                     console.log( 'valuesArray is ' + valuesArray );
        
                 
        
                     if (fieldValue && fieldValue.toLowerCase().includes(this.searchKey.toLowerCase())) {
                       recs.push(rec);
                     }
        
                     
                     
                 }
        
                 console.log( 'Recs if are ' + JSON.stringify( recs ) );
                 this.records = recs;
        
              }
        
         }  else {
        
             this.records = this.initialRecords;
        
         }
        
        } 

        //Item Price

        handleKeyChange3( event ) {  
      
          this.searchKey = event.target.value;  
        
         console.log( 'Search Key is ' + this.searchKey );
        
         if (this.searchKey ) {  
        
             this.records = this.initialRecords;
        
              if ( this.records ) {
        
                 let recs = [];
                 for ( let rec of this.records ) {
                     let fieldValue = rec['CCXR_Price__c'];
                     console.log( 'Rec is ' + JSON.stringify( rec ) );
                     let valuesArray = Object.values( rec );
                     console.log( 'valuesArray is ' + valuesArray );
        
                 
        
                     if (fieldValue && fieldValue == this.searchKey) {
                       recs.push(rec);
                     }
        
                     
                     
                 }
        
                 console.log( 'Recs if are ' + JSON.stringify( recs ) );
                 this.records = recs;
        
              }
        
         }  else {
        
             this.records = this.initialRecords;
        
         }
        
        } 
   
    }