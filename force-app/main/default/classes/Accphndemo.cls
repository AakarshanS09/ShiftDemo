public class Accphndemo {
    public static void phnmethod(){
        List<account> acclist = new List<account>();
        for(Account acc: [Select Name,id From Account Where Name = 'Tech tros 2']){
            acc.Phone = '127764';
            acclist.add(acc);
        }
        if(!acclist.isempty()){
            update acclist;
        }
    }
}