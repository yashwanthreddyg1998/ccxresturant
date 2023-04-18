({
 doInit : function(component, event, helper) {
        var action = component.get("c.fetchCustomer");
         action.setParams({
            "custId" : component.get("v.recordId").toString()
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var data;
            if(state === 'SUCCESS'){
                var result = response.getReturnValue();
                component.set("v.customer", result);
            }
        });
        $A.enqueueAction(action);
 },
    sendWhatsApp : function(component, event, helper){
        var customer = component.get("v.can");
        var msg = 'Hello '+customer.CCXR_Name__c+','+component.find("myText").get("v.value");
        var url= "https://wa.me/91"+customer.CCXR_Phone_Number__c+"?text="+msg;
        window.open(url, '_blank');
        $A.get("e.force:closeQuickAction").fire();
    }
    
})