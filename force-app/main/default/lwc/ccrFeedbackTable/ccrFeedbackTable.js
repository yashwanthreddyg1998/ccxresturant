import { LightningElement,wire,track,api } from 'lwc';
import myStyles from './ccrFeedbackTable.css';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import feedback_obj from '@salesforce/schema/CCXR_Feedback__c';
import foodquality from '@salesforce/schema/CCXR_Feedback__c.CCXR_Food_Quality__c';
import servicequality from '@salesforce/schema/CCXR_Feedback__c.CCXR_Service_Quality__c';
import getAllFeed from '@salesforce/apex/EmployeeDataController.getAllFeedback';
//import myStyles from '@salesforce/resourceUrl/ccrFeedbackTable';
import { loadStyle } from 'lightning/platformResourceLoader';

export default class CcrFeedbackTable extends LightningElement {

  records;
  sortedColumn;
  sortedDirection = 'asc';
  initialRecords;
  @track searchKey;
  @track options1 = [];

  @wire(getObjectInfo, { objectApiName: feedback_obj })
    objectInfo;
    
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: foodquality})
    typePicklistValues1({error, data}) {
        if(data) {
            this.options1 = data.values;
        }
       
    }

    @track options2 = [];

    @wire(getObjectInfo, { objectApiName: feedback_obj })
      objectInfo;
      
      @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: servicequality})
      typePicklistValues({error, data}) {
          if(data) {
              this.options2 = data.values;
          }
         
      }

  renderedCallback() {
    Promise.all([
      loadStyle(this, myStyles)
    ]).then(() => {
      console.log('CSS loaded successfully');
    }).catch(error => {
      console.error(error);
    });
  }

  @wire( getAllFeed )  
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
   

    sortRecs( event ) {

      let colName = event.target.name;
      console.log( 'Column Name is ' + colName );
      if ( this.sortedColumn === colName ) {
          this.sortedDirection = ( this.sortedDirection === 'asc' ? 'desc' : 'asc' );
      }
      else {
          this.sortedDirection = 'asc';
      }

      let isReverse = this.sortedDirection === 'asc' ? 1 : -1;

      this.sortedColumn = colName;

      // sort the data
      this.records = JSON.parse( JSON.stringify( this.records ) ).sort( ( a, b ) => {
          a = a[ colName ] ? a[ colName ].toLowerCase() : ''; // Handle null values

          b = b[ colName ] ? b[ colName ].toLowerCase() : '';
          return a > b ? 1 * isReverse : -1 * isReverse;
      });;

  }


 
handleKeyChange( event ) {  
      
     this.searchKey = event.target.value;  
    
    console.log( 'Search Key is ' + this.searchKey );

    if (this.searchKey ) {  

        this.records = this.initialRecords;

        

            let recs = [];
            for ( let rec of this.records ) {
                let fieldValue = rec['CCXR_Food_Quality__c'];
                console.log( 'Rec is ' + JSON.stringify( rec ) );
                let valuesArray = Object.values( rec );
                console.log( 'valuesArray is ' + valuesArray );

            

                if (fieldValue && fieldValue.toLowerCase() === this.searchKey.toLowerCase()) {
                  recs.push(rec);
                }

                
                
        

            console.log( 'Recs if are ' + JSON.stringify( recs ) );
            this.records = recs;

         }

    }  else {

        this.records = this.initialRecords;

    }

}  
 
handleKeyChange1( event ) {  
      
  this.searchKey = event.target.value;  

 console.log( 'Search Key is ' + this.searchKey );

 if (this.searchKey ) {  

     this.records = this.initialRecords;

      if ( this.records ) {

         let recs = [];
         for ( let rec of this.records ) {
             let fieldValue = rec['CCXR_Service_Quality__c'];
             console.log( 'Rec is ' + JSON.stringify( rec ) );
             let valuesArray = Object.values( rec );
             console.log( 'valuesArray is ' + valuesArray );

         

             if (fieldValue && fieldValue.toLowerCase() === this.searchKey.toLowerCase()) {
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