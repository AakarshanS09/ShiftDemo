public class ConAcc {
    public Static void Accountwithcon(){
        
    
        List<Account> acclist = 
                        [SElECT Id,Name, 
                        (SELECT Id,FirstName,LastName From Contacts)
                        From Account Where CreatedDate = LAST_YEAR];
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