import { LightningElement,api,track } from 'lwc';
import LCImage from '@salesforce/resourceUrl/LCImage';
import loginPage from '@salesforce/apex/UserLoginPageController.checkDetails';
import loginPage1 from '@salesforce/apex/UserLoginPageController.getDetails';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UserLoginPage extends NavigationMixin(LightningElement) {
    Empiduser;
    Empidpwd;
    rememberMe = false;
    LCImage = LCImage;
    @api apiName;

    handleUserNameChange(event) {
        this.Empiduser = event.target.value;
    }

    handlePasswordChange(event) {
        this.Empidpwd = event.target.value;
    }

    handleRememberMeChange(event) {
        this.rememberMe = event.target.checked;
    }

    handleLogin() {
        loginPage({ username: this.Empiduser, password: this.Empidpwd })
        loginPage1({ username: this.Empiduser,password: this.Empidpwd})
            .then(result => {
                if (result) {
                if (result.Employee_Type__c=='Chef' && result.Password__c==this.Empidpwd) {
                       
                        this[NavigationMixin.Navigate]({
                            type: 'standard__webPage',
                            attributes: {
                                url: 'https://commercecx125-dev-ed.develop.lightning.force.com/lightning/n/Chef_Screen'
                            }
                            
                        });
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success',
                                message: 'User Login Successfully',
                                variant: 'Success'
                            })
                        );
                    }
                   else if (result.Employee_Type__c=='Waiter' && result.Password__c==this.Empidpwd ) {
                       
                        this[NavigationMixin.Navigate]({
                            type: 'standard__webPage',
                            attributes: {
                                url: 'https://commercecx125-dev-ed.develop.lightning.force.com/lightning/n/CCXR_WaiterScreenTable'
                            }
                        });
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success',
                                message: 'User Login Successfully',
                                variant: 'Success'
                            })
                        );
                    }
                    else if (result.Employee_Type__c=='Front Desk Manager' && result.Password__c==this.Empidpwd) {
                        
                        this[NavigationMixin.Navigate]({
                            type: 'standard__webPage',
                            attributes: {
                                url: 'https://commercecx125-dev-ed.develop.lightning.force.com/lightning/n/CCX_Customer_Table_Status_Screen_New'
                                
                            }
                        });
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Success',
                                message: 'User Login Successfully',
                                variant: 'Success'
                            })
                        );
                    }
                    else  if (result.Employee_Type__c=='Restaurant Manager' && result.Password__c==this.Empidpwd) {
                       
                        this[NavigationMixin.Navigate]({
                            type: 'standard__webPage',
                            attributes: {
                                url: 'https://commercecx125-dev-ed.develop.lightning.force.com/lightning/n/CCXR_Restaurant_Manager_Screen'
                            }
                        });
                        this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'User Login Successfully',
                            variant: 'Success'
                        })
                    );
                    }
                    else {
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error',
                                message: 'Invalid username or password',
                                variant: 'error'
                            })
                        );
                    }
                    
                } 
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.message,
                        variant: 'error'
                    })
                );
            });
    }
}