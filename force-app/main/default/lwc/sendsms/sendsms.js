import { LightningElement,api ,track} from 'lwc';

import sendSMS from '@salesforce/apex/MessageController.sendSMS';
import {ShowToastEvent} from 'lightning/platformShowToastEvent'; // import toast message event .


export default class Sendsms extends LightningElement {

    mobile = '';
     msg = '';
    
    handleClick(event)
    {
        var inp= this.template.querySelector(`[data-id="mobileNumber"]`);
        this.mobile=inp.value;

        var inps= this.template.querySelector(`[data-id="smsBody"]`);
        this.msg=inps.value;
        debugger;

        alert('hello');
         alert(this.mobile);
         alert(this.msg);

        if(this.mobile!=='' && this.msg!=='')
        { 
            sendSMS({mobileNumber:this.mobile,message:this.msg})
            .then(result => {
                console.log(JSON.stringify(result));
                if(result.status==='SUCCESS')
                {
                    this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Message Info',
                        message: 'Message Sent',
                        variant: 'success'
                    }),);
                }
          })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Message Center',
                        message: error.message,
                        variant: 'error'
                    }),
                );
            });
        }
        else{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Message Center',
                    message: 'Enter Mobile number and SMS Message',
                    variant: 'error'
                }),
            );
        }
    } 
}