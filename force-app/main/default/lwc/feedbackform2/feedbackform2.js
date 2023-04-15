import { LightningElement, wire, track,api} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import feedback_obj from '@salesforce/schema/CCXR_Feedback__c';
import foodquality from '@salesforce/schema/CCXR_Feedback__c.CCXR_Food_Quality__c';
import servicequality from '@salesforce/schema/CCXR_Feedback__c.CCXR_Service_Quality__c';
import suggestions from '@salesforce/schema/CCXR_Feedback__c.CCXR_Suggestions__c';

import order from '@salesforce/schema/CCXR_Feedback__c.CCXR_Order__c';
import getfeedback from '@salesforce/apex/feedbackcontroller.feedbackRecMethod';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 
import imageUrl from '@salesforce/resourceUrl/logo';

export default class FeedbackForm2 extends LightningElement 
{
    @track options1 = [];
    @track options2 = [];
    @track selectedValue1 = foodquality;
    @track selectedValue2 = servicequality;
   
    @track ord = order;
    @track suggest = suggestions;
    disableButton = false;
    @api ordername;
    @api order;
   
    @track imageUrl1= imageUrl;
    feedback = {

      
        CCXR_Order__c : this.ord,
        CCXR_Food_Quality__c :this.selectedValue1,

        CCXR_Service_Quality__c:this.selectedValue2,
        CCXR_Suggestions__c: this.suggestions
    }

    
    @wire(getObjectInfo, { objectApiName: feedback_obj })
    objectInfo;
    
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: foodquality})
    typePicklistValues({error, data}) {
        if(data) {
            this.options1 = data.values;
        }
       
    }
    handleChange1(event)
     {
        this.feedback.CCXR_Food_Quality__c = event.target.value;
        console.log(this.feedback.CCXR_Food_Quality__c);
    }

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: servicequality})
    wiredPicklistValues({error, data}) {
        if(data) {
            this.options2 = data.values;
            
        }
    }
    handleChange2(event) {
        this.feedback.CCXR_Service_Quality__c = event.target.value;
       
        console.log(this.feeedback.CCXR_Service_Quality__c);
    }

  
   
    handlesuggestion(event)
    {
        this.feedback.CCXR_Suggestions__c = event.target.value;

    }

    createfeedbackRec() {
        console.log(this.feedback.CCXR_Food_Quality__c);
        console.log(this.feedback.CCXR_Service_Quality__c);
        console.log(this.feedback.CCXR_Order__c);
        this.feedback.CCXR_Order__c = this.order;
        alert( this.feedback.CCXR_Order__c);
        getfeedback({ accRec : this.feedback })
        
        .then(() => {
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Success',
                      message: 'Thanks For Ur Feedback!!!',
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
          this.disableButton= true;
    


}}