public class ListDemo {
    public void listMethod(){
       
        List<Account> Acc = new List<Account>();
        
        Acc = [Select Id, Name From Account limit 1];
            
            System.debug('Acc = ' + Acc);
        
    }

}