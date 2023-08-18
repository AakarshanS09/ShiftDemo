@isTest
public class UpdateAccountsTest {
    @isTest
    private static void testupdateAccounts(){
        List<Account> acclist = TestUtility.createAccountRecords('Test',4,false);
        for(integer i=0;i<4;i++){
            acclist[i].Active__c = true;
            acclist[i].rating = 'cold';
        }
        insert acclist;
            
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Rating = 'Cold';
        insert acc;
        
        Contact con = New Contact();
        con.FirstName ='Test';
        con.LastName = 'Account';
        con.AccountId = acc.Id;
        insert con;
        
        UpdateAccounts.updateAccount();
        
        Account updatAcc = [Select id,Rating 
                            From Account Where Id =: acc.Id];
        System.assertEquals('Hot', updatAcc.Rating);
    }
       

}