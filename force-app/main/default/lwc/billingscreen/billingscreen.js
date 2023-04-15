import { LightningElement ,api,wire,track} from 'lwc';
import ordername from '@salesforce/schema/CCXR_Order__c.Name';
import Customer from '@salesforce/schema/CCXR_Order__c.CCXR_Customer__c';
import Table from '@salesforce/schema/CCXR_Order__c.CCXR_Table__c';
import datetime from '@salesforce/schema/CCXR_Order__c.CCXR_Order_Date_Time__c';
import ordergrandtotal from '@salesforce/schema/CCXR_Order__c.CCXR_Grand_Total__c';
import ordertax from '@salesforce/schema/CCXR_Order__c.CCXR_Tax__c';
import orderdiscount from '@salesforce/schema/CCXR_Order__c.CCXR_OrderDiscount__c';
import ordernettotal from '@salesforce/schema/CCXR_Order__c.CCXR_Net_Total__c';
import displayoederlineitems from '@salesforce/apex/getorderstatusescontroller.orderstatuses'; 

import { NavigationMixin } from 'lightning/navigation';

import {loadStyle} from 'lightning/platformResourceLoader'
import COLORS from '@salesforce/resourceUrl/colors'

export default class Billingscreen extends NavigationMixin(LightningElement) {
    @api recordId;
    @track error  ;
    @track Orderlineitems ;
    orders;
    @api order;
    @api ordername;
    @track isShowModal =false;
    @api paymentv;
    @api  feedbackv;

    isCssLoaded = false

    @api objectApiName;
   /* connectedCallback() {
        console.log(this.recordId);
        displayoederlineitems({
            orderid:this.recordId
            
         })
      }*/
     // Expose a field to make it available in the template
     Name = ordername;
     Customer = Customer;
     Table = Table;
     grandtotal = ordergrandtotal;
     Tax = ordertax;
     Discount = orderdiscount;
     Nettotal = ordernettotal;
     Datetime = datetime
     // Flexipage provides recordId and objectApiName
     
    columns = [
        { id:'1',label: 'ItemId', fieldName: 'Name' },
        { id:'2',label: 'Name', fieldName: 'CCXR_Item_Name__c' },
        { id:'3',label: 'Quantity', fieldName: 'CCXR_Quantity__c' },
        { id:'4',label: 'Price', fieldName: 'CCXR_Price__c' },
        { id:'5',label: 'Total', fieldName: 'CCXR_Total__c'  }
       ];
       connectedCallback(){
        displayoederlineitems({orderid :this.order}) 
        .then(result=>{
            this.data=result;
            this.Orderlineitems = this.data;
         
            
        
           
     
        
            
        })
        .catch(error=>{
            this.error=error;
        })
    }
    renderedCallback(){ 
        if(this.isCssLoaded) return
        this.isCssLoaded = true
        loadStyle(this, COLORS).then(()=>{
            console.log("Loaded Successfully")
        }).catch(error=>{ 
            console.error("Error in loading the colors")
        })
    }
    gotopayment() {
        let compDefinition = {
            componentDef: "c:upi",
            attributes: {
                ordername: this.ordername,
                order: this.order
              
            }
        };
     
        // Base64 encode the compDefinition JS object
        let encodedCompDef = btoa(JSON.stringify(compDefinition));
        this[NavigationMixin.Navigate]({
            type: "standard__webPage",
            attributes: {
                url: "/one/one.app#" + encodedCompDef
            }
        });
    }
   
    gotoFeedback() {
        let compDefinition = {
            componentDef: "c:feedbackform2",
            attributes: {
                ordername: this.ordername,
                order: this.order
              
            }
        };
     
        // Base64 encode the compDefinition JS object
        let encodedCompDef = btoa(JSON.stringify(compDefinition));
        this[NavigationMixin.Navigate]({
            type: "standard__webPage",
            attributes: {
                url: "/one/one.app#" + encodedCompDef
            }
        });
    }
}