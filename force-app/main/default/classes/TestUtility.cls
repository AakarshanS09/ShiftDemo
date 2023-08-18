public class TestUtility {
    public Static List<Account> createAccountRecords(String Name,Integer Count, Boolean isInsert){
        List<Account> acclist = new List<Account>();
        for(Integer i=0; i<Count;i++){
            Account acc = new Account();
            acc.Name = Name + i;
            acclist.add(acc);
        }
        if(isInsert){
            insert acclist;
        }
        return acclist;
    }

}