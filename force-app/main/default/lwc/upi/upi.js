import { LightningElement ,track,wire,api} from 'lwc';
import ordernettotal from '@salesforce/schema/CCXR_Order__c.CCXR_Net_Total__c';
import setorderstatus from '@salesforce/apex/ReceiptsDataController.setorderstatus';

export default class Upi extends LightningElement {
    @api order;
    @api recordId;
    @track showUPI = false;
    @track showCredit = false;
    @track showNet = false;
    @track showMob = false;
    @track selectedValue;
    @track cond=false;


    Nettotal = ordernettotal;
  
    options = [
        { label: 'UPI', value: 'UPI' },
        { label: 'Credit/Debit Card', value: 'Credit/Debit Card' },
        { label: 'Net Banking', value: 'Net Banking' },
        { label: 'Mobile Wallet', value: 'Mobile Wallet' }
    ];

    handleChange(event) 
    {
        this.selectedValue=event.target.value;
            if(this.selectedValue=='UPI')
            {
                this.showUPI=true;
                this.showCredit=false;
                this.showNet=false;
                this.showMob=false;
            }
            else if (this.selectedValue=='Credit/Debit Card')
            {
                this.showCredit=true;
                this.showUPI=false;
                this.showNet=false;
                this.showMob=false;
            }
            else  if (this.selectedValue=='Net Banking')
            {
                this.showNet=true;
                this.showCredit=false;
                this.showUPI=false;
                this.showMob=false;
            }
            else 
            {
                this.showMob=true;
                this.showNet=false;
                this.showCredit=false;
                this.showUPI=false;
            }
    }
    onchange(event) 
    { 
            if(event.target.checked)
            {
                setorderstatus({oid:this.order});
                this.cond=true;
            }
           
    }
}