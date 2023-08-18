({
	doaction : function(component, event, helper) {
        var inputCmp = component.find("inputCmp");
        var value = inputCmp.get("v.value");
        
        //Is input Numeric
        if(isNaN(value)){
            inputCmp.set("v.errors",
                         [{message:"Input not a Number " + value}]);
        }else{
            //Clear Error
            inputCmp.set("v.errors",null);
        }
	}
})