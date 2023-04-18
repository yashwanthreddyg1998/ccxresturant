import { LightningElement,api,track,wire } from 'lwc';
import getAllcheforders from '@salesforce/apex/Chefscreencontroller.getAllcheforders';
import updatecheforderstatus from '@salesforce/apex/Chefscreencontroller.updatecheforderstatus';
import updatecheforderstatus1 from '@salesforce/apex/Chefscreencontroller.updatecheforderstatus1';
import updatechefemployeebusy from '@salesforce/apex/Chefscreencontroller.updatechefemployeebusy';
import updatechefemployeeavailable from '@salesforce/apex/Chefscreencontroller.updatechefemployeeavailable'
import getempnames from '@salesforce/apex/Chefscreencontroller.getempnames';
import { refreshApex } from '@salesforce/apex';
import noHeader from '@salesforce/resourceUrl/NoHeader';
import {loadStyle} from "lightning/platformResourceLoader";

export default class Cheforderscreen extends LightningElement{
  
    @api button1v;
    @api button2v;
    @api records;
    @track cheonfg;
    @api errors;
    @api itemId;
    @api itemIdr;
    @api chefidd;
    @api chefname
    @api nooforders=[];
    @track showButton=true;
    @track showButton1=false;
    accountOptions = [];
    @wire(getAllcheforders,{ } )
    wiredCases(result)
    {
      this.wiredData = result;
      this.records = result.data;
      this.errors = result.error;
      
    

    }

    handleSelection(event) 
    {
      this.chefidd = event.target.value;
    }

    handleButtonClick(event) 
    {
     
      this.button1v=true;
      this.button2v=false;
      this.itemId = event.target.value;
      updatecheforderstatus({ cat: this.itemId, cat1: this.chefidd,but1 :this.button1v,but2 :this.button2v })
      .then(result => 
        {
          this.data=result;
          this.nooforders=this.data;
           if (this.nooforders == 3) 
           {
            updatechefemployeebusy({cid :this.chefidd})
           }
         return refreshApex(this.wiredData);
         })
         .catch((error) => {
          console.error(error);
        });
      }

      handleButtonClick11(event)
       {
        this.button2v=true;
        this.itemIdr = event.target.value;
        updatecheforderstatus1({cat:this.itemIdr,but2 : this.button2v})
        .then(result => {
          this.data=result;
          this.cheonfg=this.data.Assignedtochef__c;
          updatechefemployeeavailable({cid :this.cheonfg})
        return refreshApex(this.wiredData);
      })
      .catch((error) => {
        console.error(error);
      });
    }

    connectedCallback() 
    {
      getAllcheforders({})
       .then(result => 
        {
          this.data=result;
        
        
         })
      
      loadStyle(this, noHeader)
      getempnames()
      .then(result => {
        this.accountOptions = result.map(account => ({
          label: account.Name+' , '+account.CCXR_Name__c+' , '+account.CCXR_Type_Of_Chef__c,
          value: account.Id
        }));
      })
      
    }
   

    handleMouseOver()
    {
      
      
      getempnames()
      .then(result => {
        this.accountOptions = result.map(account => ({
          label: account.Name+' , '+account.CCXR_Name__c+' , '+account.CCXR_Type_Of_Chef__c,
          value: account.Id
        }));
      })

    }
   
  }