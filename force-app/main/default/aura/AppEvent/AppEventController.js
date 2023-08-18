({
	fireAppEvent : function(component, event, helper) {
        
        var appEvent=$A.get("e.c:ApplicationEvent");
        
        appEvent.setParams({
            "message":"Value from application Event Notifier"
        });
        
        appEvent.fire();
	}
})