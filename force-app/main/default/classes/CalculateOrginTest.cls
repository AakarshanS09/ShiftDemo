@isTest
public class CalculateOrginTest {
    @isTest
    public Static void testCountCases(){
        List<Account> acclist = new List<Account>();
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account(Name = 'Test'+i);
            acclist.add(acc);
        }
        insert acclist;
        
        List<Case> caselist = new List<Case>();
        List<Id> accIds = new List<Id>();
        
        for(Account acc : acclist){
            accIds.add(acc.Id);
            for(Integer i=1;i<=3;i++){
                case c = new case();
                c.Status = 'New';
                c.Origin = 'Phone';
                c.AccountId = acc.Id;
                caselist.add(c);
            }
            
            for(Integer i=1;i<=3;i++){
                case c = new case();
                c.Status = 'New';
                c.Origin = 'Email';
                c.AccountId = acc.Id;
                caselist.add(c);
            }
            
            for(Integer i=1;i<=3;i++){
                case c = new case();
                c.Status = 'New';
                c.Origin = 'Web';
                c.AccountId = acc.Id;
                caselist.add(c);
            }
        }
        insert caselist;
        
        Test.startTest();
        CalculateOrgin.countCasesBasedOnOrgin(accIds);
        Test.stopTest();
        
        List<Account> updatedAcc = [SELECT Id,Cases_through_Email__c, Cases_through_Phone__c, Cases_through_Web__c
                                      FROM Account WHERE Id IN: accIds];
        system.assertEquals(3, updatedAcc[0].Cases_through_Email__c);
        system.assertEquals(3, updatedAcc[0].Cases_through_Phone__c);
        system.assertEquals(3, updatedAcc[0].Cases_through_Web__c);


    }
}