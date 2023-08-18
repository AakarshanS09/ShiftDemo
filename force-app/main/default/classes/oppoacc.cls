public class oppoacc {
    public void opamethod(){
        Account acc = [Select Id,Phone,Name From Account Where Name ='Tech tros 2'];
        Opportunity oppo = new Opportunity();
        oppo.accountid = acc.id;
        oppo.name = acc.name;
        oppo.Closedate = System.today();
        oppo.StageName = 'Opportunity';
            
        insert oppo;
    }
}