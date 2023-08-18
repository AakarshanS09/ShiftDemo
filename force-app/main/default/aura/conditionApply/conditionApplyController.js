({
	doAction : function(component, event, helper) {
        var inputCmp= component.find("inputCmp");
        var value =component.get("v.value");
        
        if(value>=50){
            component.set("v.flag",true);
            component.set("v.flagHeader",true);
        }else{
            component.set("v.flag",false);
            component.set("v.flagHeader",true);
        }
	}
})