public class OppProcessor implements Database.Batchable<sObject>, Database.Stateful {
    public integer recordCount = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,Name From Opportunity]);

    }
    
    public void execute(Database.BatchableContext bc, List<opportunity> opps){
        for(Opportunity op : opps){
            op.LeadSource = 'Web';
        }
        update opps;
        recordCount = recordCount + opps.size();
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug ('Total records Processed...' + recordCount);
    }

}