({
	updateParent : function(component, event, helper) {
   	component.set("v.parentVar","Updated Parent attribute");
		
	},
    onParentVarChange : function(component, event, helper) {
	console.log("Parent Value Has Changed");
    console.log("Old Value : "+event.getParam("oldValue"));
    console.log("New Value : "+event.getParam("vaalue"));	
	}
})