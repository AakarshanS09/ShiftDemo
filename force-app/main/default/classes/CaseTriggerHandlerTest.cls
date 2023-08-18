@isTest
public class CaseTriggerHandlerTest {
    @isTest
    public static void populateLatCasNum(){
        
        List<Account> acclist = New List<Account>();
        List<Case> caslist = new List<Case>();
        
        for(Integer i = 0;i<5;i++){
        Account acc = new Account();
            acc.Name = 'Tech '+ i;
            acclist.add(acc);
        }
        
        insert acclist;
            
            for(Account acc : acclist){
                Case cs = new Case();
                cs.Status = 'New';
                cs.Origin = 'Phone';
                cs.AccountId = acc.Id;
                caslist.add(cs);
            }
        Test.startTest();
        insert caslist;
        Test.stopTest();
        
        List<Case> updatedcase = [SELECT id,CaseNumber From Case WHERE id =: caslist[0].id];
        List<Account> acslist = [SELECT Id,Latest_Case_Number__c  From Account WHERE Id =: acclist[0].id];
        system.assertEquals(updatedcase[0].CaseNumber, acslist[0].Latest_Case_Number__c);
    }
   
}