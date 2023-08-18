({
	doInit : function(component, event, helper) {
		
       // component.set("v.Message1","Click This Button") 
       //component.set("v.Message2","Click This Button") 
	},
    
    handleClick1 : function(component, event, helper) {
		
       // component.set("v.Message1","Button Clicked") 
        var btn=event.getSource();
        var msg=btn.get("v.label");
      // component.set("v.Message1",event.getSource().get("v.label"));
        if(msg=="ClickMe1"){
          component.set("v.Message1","Button1 Clicked");   
        }else{
            component.set("v.Message1","Button2 Clicked");
        }
	},
    handleClick2 : function(component, event, helper) {
		
        component.set("v.Message2","This Button Also Clicked")  
	}
})