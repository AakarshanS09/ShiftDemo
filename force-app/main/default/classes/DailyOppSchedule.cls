public class DailyOppSchedule implements Schedulable{
    
    public void execute(SchedulableContext ctx){
        
        List<Opportunity> Opplist = [Select Id,LeadSource from Opportunity
                                     WHERE LeadSource = null Limit 200];
        
        if(!Opplist.isEmpty()){
        for(Opportunity opp : Opplist){
            opp.LeadSource = 'Web';
        }
        }
        
        if(!Opplist.isEmpty()){
            update Opplist;
        }
        
    }

}