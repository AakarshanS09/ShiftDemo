public class FlowAccountAction {
    @InvocableMethod
    public Static List<String> ReturnAccountName(List<ID> ids){
        
        List<String> accountNames = new List<String>();
        List<Account> accounts = [Select Name from Account WHERE Id in:ids];
        
        For(Account account : accounts){
            accountNames.add(account.Name);
        }
        return accountNames;
    }

}