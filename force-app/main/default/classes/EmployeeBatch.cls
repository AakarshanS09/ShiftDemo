public class EmployeeBatch implements Database.Batchable<sObject> {
   
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,Name,Active__c From Employee__c]);

    }
    
    public void execute(Database.BatchableContext bc, List<Employee__c> accList){
        for(Employee__c acc : accList){
            if(!acc.Active__c){
               acc.Active__c = true; 
            }
        }
        update accList;
       
    }
    
    public void finish(Database.BatchableContext bc){
    }

}