trigger AccountTrigger on Account (before insert,after insert,before update,after update,before delete) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            AccountTriggerHandler.updateRating(Trigger.New,null);
             AccountTriggerHandler.copyBillingToShipping(Trigger.New,null);
        }else if(Trigger.isAfter){
            AccountTriggerHandler.createRelatedOpp(Trigger.New);
             //  AccountTriggerHandler.createRelatedCon(Trigger.New);
        }
    }
       
     if(Trigger.isupdate){
        if(Trigger.isBefore){
            AccountTriggerHandler.updateRating(Trigger.New,trigger.oldMap);
            AccountTriggerHandler.updatePhoneDescrip(Trigger.New,trigger.oldMap);
            AccountTriggerHandler.copyBillingToShipping(Trigger.New,trigger.oldMap);
          //  AccountTriggerHandler.preventUpdate(Trigger.New);
        }else if(Trigger.isAfter){
            AccountTriggerHandler.updateRelatedOppPhone(Trigger.New,trigger.oldMap);
            AccountTriggerHandler.updateRelatedConPhone(Trigger.New,trigger.oldMap);
            AccountTriggerHandler.updRelatedConAddress(Trigger.New,trigger.oldMap);
            AccountTriggerHandler.updateRelatedOppStageName(Trigger.New,trigger.oldMap);

        }
}
    
    if(Trigger.isDelete){
        if(Trigger.isBefore){
            AccountTriggerHandler.preventDelete(Trigger.Old);
            
        }
    }
}