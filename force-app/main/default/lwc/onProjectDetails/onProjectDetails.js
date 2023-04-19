import { LightningElement,track,api,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from "lightning/navigation"; 
export default class OnProjectDetails extends NavigationMixin(LightningElement) {
    @api recordId;
    keyIndex = 0;
    @track onProjectList = [
        {
            id: 0
        }
    ];

    addRow() {
        ++this.keyIndex;
        var newOnProject = [{ id: this.keyIndex }];
        this.onProjectList = this.onProjectList.concat(newOnProject);
    }

    removeRow(event) {
        if (this.onProjectList.length >= 2) {
            this.onProjectList = this.onProjectList.filter(function (element) {
                return parseInt(element.id) !== parseInt(event.target.accessKey);
            });
        }
    }

    handleSubmit(event) {
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
                    message: 'On Project Created Successfully',
                    variant: 'success',
                }),
            );
            this.dispatchEvent(showSuccess);
            
            this[NavigationMixin.Navigate]({
                type: 'standard__navItemPage',
                attributes: {
                    
                    apiName: 'CCXClientPartner',
                    actionName: 'edit',
                    recordId: this.recordId
                },            
            })
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