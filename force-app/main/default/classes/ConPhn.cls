public class ConPhn {
    public Static void Accconphn(){
        List<Account> acclist = 
            [SElECT Id, Name, Phone, 
             (Select Id, Phone From Contacts) 
             From Account Where CreatedDate = LAST_YEAR];
        List<Contact> Conlist = new List<Contact>();
        if(!acclist.isEmpty()){
            for(Account acc : acclist){
                if(acc.Phone != null){
                    for(Contact Con : acc.Contacts){
                        Contact conrec = new Contact();
                        conrec.id = Con.id;
                        conrec.phone = acc.phone;
                        Conlist.add(conrec);
                    }
                }
            }
        }
         if(!Conlist.isEmpty()){
            update Conlist;
    }
    }
}