public class Demosobject {
    public void sobjmethod(){
        List<Account> acclist = new List<Account>();
        Set<Id> accIds = new Set<Id>();
        List<String> accname = new List<String>();
         acclist = [Select Id,Name From Account Limit 2];
        Map<Id,Account> idacc =  new Map<Id,Account>(acclist);
       
        if(!acclist.isEmpty()){
            for(Account acc : acclist){
                accIds.add(acc.Id);
            }
        }
       // System.debug('accIds = '+ accIds);
        if(!accids.isEmpty()){
            for(Id i : accIds)
                if(idacc.containskey(i)){
                    system.debug('map value...' +idacc.get(i));
                }
                //system.debug('i...'+ i);
            
        }
    }
}