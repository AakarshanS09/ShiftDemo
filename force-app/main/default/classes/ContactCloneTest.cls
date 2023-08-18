@isTest
public class ContactCloneTest {
    
    @testsetup
    Static void setup(){
        List<Account> acclist = new List<Account>();
        for(Integer i=1;i<=5;i++){
            Account acc =new Account();
            acc.Name = 'Queue'+i;
            acc.Industry = 'Media';
            acclist.add(acc);
        }
        insert acclist;
        
    }
    
    @isTest
    public static void testcontactclone(){
        //Contact cont= [SELECT Id FROM Contact WHERE LastName='QueueableApex'];
        Contact con = new Contact(LastName='QueueableApex');
        insert con;
        String industryValue = 'Media';
        
        Test.startTest();
        ContactClone conClone = new ContactClone(con,industryValue);
		Id jobId = system.enqueueJob(conClone);
        Test.stopTest();
        
        System.assertEquals(5, [SELECT Count() FROM Contact
                                WHERE AccountId IN (SELECT Id FROM Account
                                                   WHERE Industry = 'Media')]);
        
    } 

}