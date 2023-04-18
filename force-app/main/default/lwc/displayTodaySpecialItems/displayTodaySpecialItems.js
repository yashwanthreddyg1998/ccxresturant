import { LightningElement,api,wire } from 'lwc';
//import BackgroundImg from '@salesforce/resourceUrl/logo';
import specialItems from '@salesforce/apex/GetSpecialItems.getTodaySpecialMenu';
import createOrderAndOrderLines from '@salesforce/apex/Order_CreationController.createOrderAndOrderLines';
export default class DisplayItems extends LightningElement {
/*imageUrl = BackgroundImg;

get getBackgroundImage(){
    return `background-image:url("${this.imageUrl}")`;
}*/

@api csn;
@api quantitynumber=1;
@api recordId;
@api id;
//Speacial Items
    items;
    @api errors;
    @wire(specialItems,{})
    wiredSpeacialItems({ error, data }) {
        if (data) {
            this.items = data;
            this.errors = undefined;
        } else if (error) {
            console.error=error;
            this.records = undefined;
        }
    }
    handleChange1(event) {
        this.quantitynumber=event.target.value;
        }
    handleClick(event)
    {
       
        this.recordId=event.target.value;
        createOrderAndOrderLines({csn :this.id,itemid:this.recordId,quantity:this.quantitynumber})
    }
}