@isTest
public class DailyOppScheduleTest {
    @isTest
    private Static void testScheduledApex(){
        List<Opportunity> opplist = new List<opportunity>();
        String sch = '0 0 0 ? *  * *' ;
        
        for(Integer i=0;I<500;i++){
            if(i<250){
                opportunity opp = new opportunity();
                opp.Name = 'Test'+i;
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today();
                opplist.add(opp);
                
            }else{
                opportunity opp = new opportunity();
                opp.Name = 'Test'+i;
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today();
                opp.LeadSource = 'Others';
                opplist.add(opp);
            }

        }
        insert opplist;
        
        Test.startTest();
        String jobid = system.schedule('Process Opportunities', sch,new DailyOppSchedule());
        Test.stopTest();
        
        List<Opportunity> Updatedopplist = [Select Id,LeadSource From Opportunity WHERE LeadSource = 'Web'];
        System.assertEquals(200, Updatedopplist.size());    
    }

}