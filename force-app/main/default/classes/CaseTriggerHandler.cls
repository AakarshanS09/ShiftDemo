public class CaseTriggerHandler {
    public Static void updateAccLatestCasNum(List<Case> caslist){
        List<Account> acclist = new List<Account>();
        for(Case cs : caslist){
            if(cs.Accountid != null){
                Account acc = New Account();
               acc.id = cs.AccountId;
                acc.Latest_Case_Number__c = cs.CaseNumber;
                acclist.add(acc);
            }
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
            
        
    }

}