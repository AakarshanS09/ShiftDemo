public class AccountCalculator {
    @future
    public static void countcontacts(List<id> accIds){
                List<Account> acclist = 
                        [SElECT Id,Name, 
                        (SELECT Id,LastName From Contacts)
                        From Account Where Id IN: accIds];
         if(!acclist.isEmpty()){
            for(Account acc : acclist){
                acc.Total_Contacts__c = acc.Contacts.size();
            }
        }
        if(!Acclist.isEmpty()){
            update acclist;
        }
        
    }

}