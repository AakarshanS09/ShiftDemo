@isTest
public class UpdateParentAccountTest {
    
    @testSetup
    Static void setup(){
        List<Account> acclist = new List<Account>();
        acclist.add(new Account(Name = 'Parent'));
        
        for(Integer i=0;i<100;i++){
            acclist.add(new Account(Name='Test'+i));
        }
        insert acclist;
    }

@isTest  
        private static void testQueueable(){
            id parentId=[Select id FROM Account Where Name='Parent'][0].id;
            
            List<Account> acclist=[Select id,Name FROM Account
                                   WHERE Name Like 'TEST%'];
            UpdateparentAccount updateJob = new UpdateparentAccount(acclist,parentId);
			
            
            Test.startTest();
           system.enqueueJob(updateJob);
            Test.stopTest(); 
            
            system.assertEquals(100, [SELECT count() FROM Account WHERE
                                       parentId = :parentId]);
        }    

}