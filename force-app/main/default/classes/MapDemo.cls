public class MapDemo {
    public static void mapmethod(){
        
        List<Account> Acclist = [Select Id,Name from Account Limit 2];
        Map<Id,Account> InStr = new Map<Id,Account>(Acclist);
       
        System.debug('Instr...'+ InStr);

        
        
    }

}