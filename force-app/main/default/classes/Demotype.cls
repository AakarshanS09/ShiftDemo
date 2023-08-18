public class Demotype {
    public void methoddemo(){
        sObject obj = new Account(Name = 'Test');
        Account acc = (Account)obj;
        System.debug('Account = ' + acc);
    }
}