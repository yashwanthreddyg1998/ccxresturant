import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from "lightning/actions";
import { loadStyle } from "lightning/platformResourceLoader";
/*import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import item_obj from '@salesforce/schema/CCXR_Items__c';
import category from '@salesforce/schema/CCXR_Item__c.CCXR_Category__c';
import subcategory from '@salesforce/schema/CCXR_Item__c.CCXR_Sub_Category__c';
*/
export default class addItems extends NavigationMixin(LightningElement)
{
    /*@track catValues=[];
    @track subCatValues=[];
    @track selectedValue1 = category;
    @track selectedValue2 = subcategory;

    @wire(getObjectInfo, { objectApiName: item_obj })
    objectInfo;

    @wire(getPicklistValues, { recordTypeId:
'$objectInfo.data.defaultRecordTypeId', fieldApiName: category})
    typePicklistValues({error, data}) {
        if(data) {
            this.catValues = data.values;
        }

    }
    @wire(getObjectInfo, { objectApiName: item_obj })
    objectInfo;

    @wire(getPicklistValues, { recordTypeId:
'$objectInfo.data.defaultRecordTypeId', fieldApiName: subcategory})
    typePicklistValues({error, data}) {
        if(data) {
            this.subCatValues = data.values;
        }

    }

    @wire(getObjectInfo, {objectApiName: item_obj })
    objectInfo;
    @track catValues;
    @track subCatValues;

    @wire(getPicklistValues, {recordTypeId:
'$objectInfo.data.defaultRecordTypeId', fieldApiName: subcategory })
    subcategoryFieldInfo({ data, error }) {
        if (data) this.subFieldData = data;
    }
    @wire(getPicklistValues,
{recordTypeId:'$objectInfo.data.defaultRecordTypeId', fieldApiName:
category })
    categoryFieldInfo({ data, error }) {
        if (data) this.catValues = data.values;
    }
    handleUpsellChange(event) {
        let key = this.subFieldData.controllerValues[event.target.value];
        this.subCatValues = this.subFieldData.values.filter(opt =>opt.validFor.includes(key));
    }
*/

    keyIndex = 0;
    @track itemList = [
        {
            id: 0
        }
    ];

    addRow() {
        ++this.keyIndex;
        var newItem = [{ id: this.keyIndex }];
        this.itemList = this.itemList.concat(newItem);
    }

    removeRow(event) {
        if (this.itemList.length >= 2) {
            this.itemList = this.itemList.filter(function (element) {
                return parseInt(element.id) !==
parseInt(event.target.accessKey);
            });
        }
    }

    handleSubmit() {
        var isVal = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element=> {
            isVal = isVal && element.reportValidity();
        });
        if (isVal) {
            this.template.querySelectorAll('lightning-record-edit-form').forEach(element=> {
                element.submit();
            });
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Items successfully created',
                    variant: 'success',
                }),
            );
            /*// Navigate to the Account home page
            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'CCXR_Items__c',
                    actionName: 'home',
                },
            });*/
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: 'Please enter all the required fields',
                    variant: 'error',
                }),
            );
        }
    }

}