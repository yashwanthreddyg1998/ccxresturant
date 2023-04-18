import { LightningElement ,track} from 'lwc';

export default class Mobilewallet extends LightningElement {
    @track selectedOption;
    options = [    { label: 'Airtel Money', value: 'Airtel Money' },  
               { label: 'Amazon Pay', value: 'Amazon Pay' },    
               { label: 'PhonePe Wallet', value: 'PhonePe Wallet' }
            ];


    handleOptionChange(event) {
        this.selectedOption = event.target.value;
    }
}