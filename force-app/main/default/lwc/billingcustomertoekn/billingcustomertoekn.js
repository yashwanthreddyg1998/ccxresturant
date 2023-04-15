import { LightningElement,track,api,wire } from 'lwc';
import CustomerTableStatusData from '@salesforce/apex/Getbillingdetailscontroller.getOrder';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import BackgroundImg from '@salesforce/resourceUrl/customerWelcomePageBG';
export default class Billingcustomertoekn extends NavigationMixin(LightningElement) {
    @api tokenNumber='';
    @api records;
    @api errors; 
    @track imageUrl = BackgroundImg;
   
    get getBackgroundImage(){
        return `background-image:url("${this.imageUrl}")`;
    }
    handleTokenChange(event) 
    {
        this.tokenNumber=event.target.value;
        
    }
    /*enter() {
        parseInt(this.tokenNumber)
        alert(this.tokenNumber);
         
        //Navigate to a specific CustomTab.
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'CCXR_Menu_Screen'
            },
            state: {
                c__tokenNumber2:500
            }
        });
        
    }*/
    enter() 
    {
         CustomerTableStatusData({tokenNumber:this.tokenNumber})
       .then(result=>{
            this.data=result;
           let compDefinition = {
                componentDef: "c:billingscreen",
                attributes: {
                     token: this.tokenNumber,
                     order:this.data.Id,
                     ordername:this.data.Name,
                     paymentv:true
                  
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
           
     
    })
}
}