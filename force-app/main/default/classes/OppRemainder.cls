public class OppRemainder implements Schedulable{
    public void execute(SchedulableContext ctx){
        List<Opportunity> opplist = [SELECT Id,StageName,CloseDate,OwnerId 
                                     FROM Opportunity
                                      WHERE isClosed= false AND closeDate < TODAY];
        List<Task> tasklist = new list<Task>();
        if(!opplist.isEmpty()){
            for(Opportunity opp : opplist){
                Task tsk = new Task();
                tsk.Subject = 'Reminder Task';
                tsk.Status = 'open';
                tsk.Priority = 'Normal';
                tsk.WhatId = opp.Id;
                tsk.OwnerId = opp.OwnerId;
                tasklist.add(tsk);
            }
        }
        if(!tasklist.isEmpty()){
            insert tasklist;
        }
    }

}