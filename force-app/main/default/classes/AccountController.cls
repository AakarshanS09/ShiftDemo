public class AccountController {
    @AuraEnabled
    public static List<Account> getAccounts(){
        List<Account> acclist =new List<Account>();
        acclist = [SELECT Id,Name FROM Account Limit 10];
        return acclist;
    }

}