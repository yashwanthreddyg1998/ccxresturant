import { LightningElement,wire,track,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'; 
import myStyles from './ccrReceiptsTable.css';
import getReceiptList from '@salesforce/apex/ReceiptsDataController.getReceiptList';
import { loadStyle } from 'lightning/platformResourceLoader';

export default class CcrReceiptsTable extends NavigationMixin(LightningElement) {
    @track contactsRecord;
    @track searchKey;
     records;
    initialRecords;
    renderedCallback() {
      Promise.all([
        loadStyle(this, myStyles)
      ]).then(() => {
        console.log('CSS loaded successfully');
      }).catch(error => {
        console.error(error);
      });
    }

    @wire( getReceiptList )  
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
    handleKeyChange( event ) {  
      
        this.searchKey = event.target.value;  
       
       console.log( 'Search Key is ' + this.searchKey );
   
       if (this.searchKey ) {  
   
           this.records = this.initialRecords;
   
                let recs = [];
                for ( let rec of this.records ) {
                   let fieldValue = rec['Transaction_Date__c'];
                   console.log( 'Rec is ' + JSON.stringify( rec ) );
                   let valuesArray = Object.values( rec );
                   console.log( 'valuesArray is ' + valuesArray );
                
                   if (fieldValue && fieldValue === this.searchKey) {
                     recs.push(rec);
                   }
                 console.log( 'Recs if are ' + JSON.stringify( recs ) );
               this.records = recs;
            }
        }  else {
                this.records = this.initialRecords;
        }
    }
 
    // update searchValue var when input field value change
    /*searchKeyword(event) {
        this.searchValue = event.target.value;
    }*/
 
    // call apex method on button click 
   /* handleSearchKeyword() {
        
        if (this.searchValue !== '') {
            getContactList({
                    searchDate: this.searchValue
                })
                .then(result => {
                    // set @track contacts variable with return contact list from server  
                    this.contactsRecord = result;
                })
                .catch(error => {
                   
                    const event = new ShowToastEvent({
                        title: 'Error',
                        variant: 'error',
                        message: error.body.message,
                    });
                    this.dispatchEvent(event);
                    // reset contacts var with null   
                    this.contactsRecord = null;
                });
        } else {
            // fire toast event if input field is blank
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Search text missing..',
            });
            this.dispatchEvent(event);
        }
    }*/
 
     

      
}