({
	doInit : function(component, event, helper) {
        $A.createComponent(
            "lightning:button",
            {
                "aura:id":"FindableAuraId",
                "label":"ClickMe",
                "onclick":component.getReference("c.handleClick")
            },
            function(newButton,status,errorMessage){
                if(status==="SUCCESS"){
                    var body=component.get("v.body");
                    body.push(newButton);
                    component.set("v.body",body);
                }else if(status === "INCOMPLETE"){
                    console.log("No response server or client is offline");
                }else if(status === "ERROR"){
                    console.log("Error "+ errorMessage)
                }
            }
        );
	},
    handleClick : function(component, event, helper){
        component.set("v.message","Button Clicked");
    }
})