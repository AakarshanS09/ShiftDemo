public class AccCon {
    public void Conphn(){
        List<Contact> Conlist =
            [SElECT Id,LastName,Phone,Account.Phone 
             From Contact Where AccountId != null];
        if(!Conlist.isEmpty()){
            for(Contact Con : Conlist){
                if(Con.Phone == null){
                    Con.Phone = Con.Account.phone;
                }
            }
        } 
        if(!Conlist.isEmpty()){
            update Conlist;
        }
    }

}