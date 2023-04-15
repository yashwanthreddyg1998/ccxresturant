import { LightningElement,track, wire, api } from 'lwc';
import getAllFeed from '@salesforce/apex/displayingorderlineitems.displayingorder';
import deteleorderlineitems from '@salesforce/apex/displayingorderlineitems.deteleorderlineitems';
import {refreshApex} from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Orderlines extends LightningElement {
  @api id;
  @api recordid;
  @track itmLtist;
  @track errors;

  @wire(getAllFeed,{csn: '$id' } )
  wiredCases(result)
  {
    this.wiredData = result;
    this.itmLtist = result.data;
    this.errors = result.error;
    
  }
  
  handleRefresh() {
    getAllFeed({csn : this.id})
        .then(result => {
            this.data = result;
            return refreshApex(this.wiredData);
        })
        .catch(error => {
            this.errors = error;
        });
  }
  handleButtonClick(event) {
    this.recordid = event.target.value;
    deteleorderlineitems({ csn: this.recordid })
        .then(() => {
            if (this.recordid != undefined) {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Item deleted successfully.',
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredData);
            } else {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Error In deleting Item',
                        variant: 'error'
                    })
                );
                return;
            }
        })
        .catch(error => {
            console.log('Error In deleting Item : ' + error.body.message);
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Error In deleting Item : ' + error.body.message,
                    variant: 'error'
                })
            );
        });
}



}