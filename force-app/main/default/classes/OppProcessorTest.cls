@isTest
public class OppProcessorTest {
    @isTest
    private Static void testbatchclass(){
        List<opportunity> opplist = new List<Opportunity>();
        
        for(integer i=0; i<200; i++){
            opplist.add(
                new Opportunity(Name = 'Test'+i,StageName = 'Prospecting',CloseDate = System.today() ));
            
        }
        insert opplist;
        
        test.startTest();
        OppProcessor oppProcess = new OppProcessor();
		Id batchIds = Database.executeBatch(oppProcess,200);
        test.stopTest();
        
        list<Opportunity> updatedopps = [Select Id From Opportunity Where LeadSource = 'Web'];
        system.assertEquals(200, updatedopps.size());
    }

}