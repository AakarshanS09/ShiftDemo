public class UpdateAccounts {
    public Static void updateAccount(){
        List<Account> accToBeUpdated = new List<Account>();
        Set<Id> accIdSet = new Set<Id>();
        
        for(Contact Con : [Select Id,Account.Id From Contact
                            WHERE NAME Like '%Test%'
                            AND Account.Id != NULL]){
                                if(!accIdSet.contains(con.Account.Id)){
                                    Account acc = new Account();
                                    acc.Id = con.Account.Id;
                                    acc.Rating = 'Hot';
                                    accToBeUpdated.add(acc);
                                    accIdSet.add(con.Account.Id);
                                }               
                            }
        if(!accToBeUpdated.isempty()){
            update accToBeUpdated;
        }
    }

}