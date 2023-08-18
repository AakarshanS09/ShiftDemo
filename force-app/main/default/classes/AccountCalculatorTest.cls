@isTest
public class AccountCalculatorTest {
    @isTest
    private Static void countContactTest(){
        List<Account> acclist = new List<Account>();
        
        for(Integer i;i<250;i++){
            acclist.add(new Account(Name = 'Test'+ i));
            
        }
        insert acclist;
        
        List<Contact> conlist = new List<Contact>();
        List<Id> accId = new List<Id>();
        
        For(Account acc : acclist ){
            conlist.add(new Contact(FirstName ='Tech', LastName = acc.Name,Accountid=acc.id));
            accId.add(acc.id);
        }
        insert conlist;
        
        Test.startTest();
        AccountCalculator.countcontacts(accId);
        Test.stopTest();
        
        list<Account> updacc = [Select Name,Id,Number_of_contacts__c From Account];
        
        system.assertEquals(1,updacc[0].Number_of_contacts__c, 'Contacts are not counted successfully');
    } 

}