import { LightningElement,api, wire } from 'lwc';
import getCustomerTableStatusData from '@salesforce/apex/test.igg';
import { NavigationMixin } from 'lightning/navigation';
export default class Wel extends LightningElement {
    @api id1='a0P5g00000EgzfFEAR'
   @api Orderlineitems;
   connectedCallback()
   {
       getCustomerTableStatusData({}) 
       .then(result=>{
           this.data=result;
           alert(this.data);
       this.order=this.data.id;
       alert(this.order);  
        
           
       })
       .catch(error=>{
           this.error=error;
       }) 
       }
       
       generateBill()
       {
           getCustomerTableStatusData({}) 
           .then(result=>{
               this.data=result;
               alert(this.data);
               alert(this.data);  
           alert(this.order);  
            
               
           })
           .catch(error=>{
               this.error=error;
           }) 
              
          
         
         
   }
       
     
      
}