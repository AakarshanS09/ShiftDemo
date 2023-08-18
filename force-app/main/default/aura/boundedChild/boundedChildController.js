({
	updateChild : function(component, event, helper) {
   	component.set("v.childVar","Updated Child attribute");
	},
    
	onChildChange : function(component, event, helper) {
    console.log("Child Value Has Changed");
    console.log("Old Value : "+event.getParam("oldValue"));
    console.log("New Value : "+event.getParam("vaalue"));
	},
})