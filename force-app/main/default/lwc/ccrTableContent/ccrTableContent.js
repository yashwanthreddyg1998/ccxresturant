import { LightningElement,track,api,wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import deleteTables from '@salesforce/apex/EmployeeDataController.deleteTable';
import getTables from '@salesforce/apex/EmployeeDataController.getTableData1';
//import BackgroundImg from '@salesforce/resourceUrl/logo2'
import { NavigationMixin } from "lightning/navigation";
import {refreshApex} from '@salesforce/apex';
import table_obj from '@salesforce/schema/CCXR_Table__c';
import Status from '@salesforce/schema/CCXR_Table__c.CCXR_Table_Status__c';
export default class CcrTableContent extends NavigationMixin(LightningElement )
{
    //imageUrl = BackgroundImg;
@track getTab;
    @api drecordId;
    @api upRecordIDs;
    initialRecords;
    
@track searchKey;
  @track options1 = [];


    @track isShowModal = false;
    showModalBox() {  
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }

    @track showModalBox1 = false;
    showComp1() {
        this.showModalBox1 = true;
    }
    @wire( getTables )  
  wiredAccount( { error, data } ) {
    if (data) {
       
        this.getTab = data;
        this.initialRecords = data;
        this.error = undefined;

    } else if ( error ) {

        this.error = error;
        this.initialRecords = undefined;
        this.getTab = undefined;

    }
    } 
    @wire(getTables,{ } )
    wiredColumns(result)
    {
      this.wiredData = result;
      this.records = result.data;
      this.errors = result.error;
    }
    
    @wire(getObjectInfo, { objectApiName: table_obj })
    objectInfo;
    
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: Status})
    typePicklistValues1({error, data}) {
        if(data) {
            this.options1 = data.values;
        }
       
    }


    handleKeyChange( event ) {  
      
     this.searchKey = event.target.value;  
    
    console.log( 'Search Key is ' + this.searchKey );

    if (this.searchKey ) {  

        this.getTab = this.initialRecords;

         if ( this.getTab ) {

            let recs = [];
            for ( let rec of this.getTab ) {
                let fieldValue = rec['CCXR_Table_Status__c'];
                console.log( 'Rec is ' + JSON.stringify( rec ) );
                let valuesArray = Object.values( rec );
                console.log( 'valuesArray is ' + valuesArray );
                
                if (this.searchKey.toLowerCase() === 'all') {
                    recs.push(rec);
                }
                else if (fieldValue && fieldValue.toLowerCase() === this.searchKey.toLowerCase()) {
                    recs.push(rec);
                }
            
          }

            console.log( 'Recs if are ' + JSON.stringify( recs ) );
            this.getTab = recs;

         }

    }  else {

        this.getTab = this.initialRecords;

    }

}

    /* get getBackgroundImage(){
        return `background-image:url("${this.imageUrl}")`;
    }
    */
    handleDelete(event) 
        {
            this.drecordId=event.target.value;
            deleteTables({tabRecordId:this.drecordId})
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
            //getTables({upRecordId:this.upRecordIDs})
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.upRecordIDs,
                    objectApiName: 'CCXR_Table__c',
                    actionName: 'edit'
                },
            });
        
            this.i=0
            
        }
        handleMouseOver() {
            if(this.i >= 1)
            {
                return refreshApex(this.wiredData);
            }
            this.i++;
            console.log(this.i)
        }
            
       
}