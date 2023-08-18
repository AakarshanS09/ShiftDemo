({
	myAction : function(component, event, helper) {
        component.set("v.Columns",[
            {label:"FirstName",fieldName:"FirstName",type:"text"},
            {label:"LastName",fieldName:"LasttName",type:"text"},
            {label:"Phone",fieldName:"Phone",type:"phone"},
            {label:"Email",fieldName:"Email",type:"Email"}
        ]);
        
        var action=component.get("c.getContacts");
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this,function(data){
          component.set("v.Contacts",data.getReturnValue());                 
        });
        $A.enqueueAction(action);
	}
})