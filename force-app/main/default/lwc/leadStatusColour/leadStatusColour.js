import { LightningElement,api } from 'lwc';

export default class LeadStatusColour extends LightningElement {
    @api leadstatus;
    @api leadstatus1;
  
   
    @api mins;
   
    @api color;
 
  
   
    get getColor() { 
     
      var datetime = this.leadstatus1;
      
      var d1 = new Date(datetime);
      var minute = d1.getMinutes();
      var hour = d1.getHours();
      var newminutes=(hour*60)+minute;
      
      var datetime1 = new Date();
     
      var d11 = new Date(datetime1);
      var minute1 = d11.getMinutes();
      var hour1 = d11.getHours();
      var newminutes1=(hour1*60)+minute1;
      
        this.mins=Math.abs(newminutes1-newminutes);
       

       if (this.mins != undefined) {
         
       
                if (this.mins <=30) {
                    this.color='green';
                  } 
                else if(this.mins >=30) {
                    this.color='red';
                  } 
                 
           return this.color + ' slds-badge';
     
    }
    }
}