import { LightningElement ,track } from 'lwc';

export default class Netbanking extends LightningElement {
    @track selectedOption;
    options = [    { label: 'Allahabad Bank', value: 'Allahabad Bank' },  
               { label: 'HSBC', value: 'HSBC' },    
               { label: 'ICICI', value: 'ICICI' }
            ];


    handleOptionChange(event) {
        this.selectedOption = event.target.value;
    }
}