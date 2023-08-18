trigger EmployeeTrigger on Employee__c (before delete,after delete,after undelete,after insert,after update) {
    if(Trigger.isdelete){
        if(Trigger.isBefore){
            EmployeetriggerHandler.EmployeeStatus(Trigger.old);
        }else if(Trigger.isAfter){
            EmployeetriggerHandler.updateLeftEmpCountOnAcc(Trigger.old);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isUndelete){
            EmployeetriggerHandler.undeleteEmployees(Trigger.New);
        }
        if(Trigger.isInsert){
            EmployeetriggerHandler.emailToEmployee(trigger.New,null);
        }
        if(Trigger.isUpdate){
         //   EmployeetriggerHandler.emailToEmployee(trigger.New,Trigger.Oldmap);
        }
    } 
}