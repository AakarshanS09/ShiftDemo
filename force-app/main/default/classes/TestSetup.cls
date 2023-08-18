@isTest
public class TestSetup {
    @testsetup
    private Static void Setup(){
        List<Account> acclist = new List<Account>();
        For(Integer i=0;i<2;i++){
            Account acc = new Account();
            acc.Name = 'Test' + i;
            acclist.add(acc);
        }
        insert acclist;
    }
    @isTest
    private Static void method1(){
        Account acc1 = [Select Id,Name,Phone From Account Where Name = 'Test0'];
        acc1.Phone = '1112224';
        update acc1;
        Account acc2 = [Select Id,Name,Phone From Account Where Name = 'Test1'];
        delete acc2;
    }
    @isTest
    private Static void method2(){
     Account acc1 = [Select Id,Name,Phone From Account Where Name = 'Test0'];
        system.assertEquals(null, acc1.Phone);

        
    }

}