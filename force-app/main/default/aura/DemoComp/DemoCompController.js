({
	doInit : function(component, event, helper) {
		//component.set("v.Var1","value From Controller")
        var data = {'name':'TestName',
                    'email':'test@test.com'};
        component.set("v.jsObject",data);
        component.set("v.userData",
                      {
                          'myString1':'stringValue',
                          'myInteger1':'2023'
                      })
	}
})