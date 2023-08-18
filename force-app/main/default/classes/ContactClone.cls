public class ContactClone implements Queueable {
    
    private Contact con;
    private String industryValue;
    
    public ContactClone(Contact con,String industryValue){
        this.con = con;
        this.industryValue = industryValue;
    }
    
    public void execute(QueueableContext context){
        List<Account> acclist = [Select Id,Name From Account
                                 where Industry =:industryValue LIMIT 200];
        
        List<Contact> conlist = new List<Contact>();
        
        for(Account acc : acclist){
            Contact c = con.clone(false,false,false,false);
            c.AccountId = acc.Id;
            conlist.add(c);
        }
        if(!conlist.isEmpty()){
            insert conlist;
        } 
    }
    

}