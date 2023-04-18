import { LightningElement } from 'lwc';

export default class ReceiptReport extends LightningElement {
    redirectToReport(evt) {
        evt.preventDefault();
        evt.stopPropagation();
        this[NavigationMixin.Navigate](this.reportUrl);
    }
    
    connectedCallback() {
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__webPage',
            attributes: {
                url: '/lightning/r/Report/00O5g00000GUSExEAP/view'
            },
        }).then(url => {
            this.reportUrl = url;
        });
    }
}