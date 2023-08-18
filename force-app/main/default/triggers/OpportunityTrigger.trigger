trigger OpportunityTrigger on Opportunity (before insert,after insert,after update,after delete,before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            OpportunityTriggerHandler.oppRating(Trigger.New);
             OpportunityTriggerHandler.updateOppDescrip(Trigger.New,null);
            //OpportunityTriggerHandler.oppAmountReq(Trigger.New);
        }else if(Trigger.isUpdate){
            OpportunityTriggerHandler.updateOppDescrip(Trigger.New,Trigger.oldMap);
            //OpportunityTriggerHandler.closedLostReason(Trigger.New);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OpportunityTriggerHandler.OnAfterInsert(Trigger.New);
            OpportunityTriggerHandler.latestOppAmnt(Trigger.New);
        }else if(Trigger.isUpdate){
            OpportunityTriggerHandler.OnAfterUpdate(Trigger.New,Trigger.oldMap);
            OpportunityTriggerHandler.createRelatedTask(Trigger.New,Trigger.oldMap);

        }else if(Trigger.isDelete){
            OpportunityTriggerHandler.OnAfterDelete(Trigger.old);
        }
    }

}