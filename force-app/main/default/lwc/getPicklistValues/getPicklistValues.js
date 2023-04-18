import { LightningElement,wire,track } from 'lwc';

import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ITEM_OBJECT from '@salesforce/schema/CCXR_Items__c';
import itemCategory from '@salesforce/schema/CCXR_Items__c.CCXR_Item_Category__c';
export default class DependentValuesLWC extends LightningElement {
    @track value;
    @track TypeItemsFieldInfoOptions;

    @wire(getObjectInfo, { objectApiName: ITEM_OBJECT })
    objectInfo;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', 
        fieldApiName: itemCategory})
    TypeItemsFieldInfo({ data, error }) {   
        
            if (data) {
                this.TypeItemsFieldData = data;
                this.TypeItemsFieldInfoOptions = this.TypeItemsFieldData.values.filter(
                    (opt,idx) => opt.validFor.includes(idx)
                  );            }
        
    }

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: TYPE_FIELD})
    TypePicklistValues;
}