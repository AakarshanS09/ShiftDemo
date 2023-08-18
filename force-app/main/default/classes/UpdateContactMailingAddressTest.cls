@isTest
public class UpdateContactMailingAddressTest {
    @isTest
    
    public static void testAddressCopy(){
        List<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        
        for(Integer i=0; i<5; i++){
            Account acc = new Account(Name = 'Test'+ i, billingcity = 'New York', billingcountry ='USA');
            acclist.add(acc);
            
        }
        insert acclist;
        
        for(Account acc: acclist){
            Contact con = new Contact();
            con.LastName = 'Tech';
            con.AccountId = acc.id;
            conlist.add(con);
        }
        insert conlist;
        
        test.startTest();
        UpdateContactMailingAddress accProcess = new UpdateContactMailingAddress();
		Id batchId = Database.executeBatch(accProcess);
        test.stopTest();
        
        Integer countedContact = [Select Count() FROM Contact WHERE MailingCity = 'New York'];
        system.assertEquals(5, countedContact);
        
            
    }

}