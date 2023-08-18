trigger ContactTrigger on Contact (Before Insert, After insert,After Update,After delete,After undelete) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
          //  ContactTriggerHandler.preventDuplicate(Trigger.New);
            //ContactTriggerHandler.preventPrimaryContact(Trigger.New);
        }
        if(Trigger.isAfter){
          // ContactTriggerHandler.sendEmailNotification(Trigger.New);
       	    ContactTriggerHandler.totalContactCount(Trigger.New);
        }
     
    }
    if(Trigger.isAfter && Trigger.isUpdate){
     //   ContactTriggerHandler.updateAccount(Trigger.New,trigger.oldMap);
    }
    
    if(Trigger.isAfter && Trigger.isdelete){
        ContactTriggerHandler.totalContactCount(Trigger.old);
    }
    if(Trigger.isAfter && Trigger.isundelete){
        ContactTriggerHandler.totalContactCount(Trigger.New);
    }
    
}