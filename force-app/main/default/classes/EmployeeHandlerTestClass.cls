@isTest
public class EmployeeHandlerTestClass {
    @isTest
    public static void emailNotification(){
        List<Account> acclist = New List<Account>();
        List<Employee__c> emplist = new List<Employee__c>();
        for(Integer i = 0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Tech '+ i;
            acclist.add(acc);
        }
         insert acclist;
        For(Account acc : acclist){
            Employee__c emp = new Employee__c ();
            emp.Name = 'test';
            emp.Account__c = acc.Id;
            emp.Email__c = 'aakarshanprakash94@gmail.com';
            emplist.add(emp);
        }
        Test.startTest();
        insert emplist;
        Test.stopTest();
    }
    
}