import { LightningElement, api,wire, track } from 'lwc';
import getAllFeed from '@salesforce/apex/displayingorderlineitems.displayingorder';
import { refreshApex } from '@salesforce/apex';

export default class Displayingorderlineitems extends LightningElement {
  @api id;
  @track data;
  @track items;
  @track errors;

   @wire(getAllFeed,{csn: '$id' } )
  wiredgetAllFeed(result)
  {
    this.wiredData = result;
    this.items = result.data;
    this.errors = result.error;
    
  }
  handleRefresh()
  {
    alert('hi');
    getAllFeed({csn : this.id})
        .then(result => {
            this.items = result;
            return refreshApex(this.wiredData);
        })
        .catch(error => {
            this.errors = error;
        });
  }
  

  

}