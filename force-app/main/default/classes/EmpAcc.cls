public class EmpAcc {
    Public Static void CountToSal(){
        List<Account> Accemplist = 
            [SElECT Id,Name,Total_Salary__c,
             (Select Id,Salary__c From Employees__r) From Account];
        if(!Accemplist.isEmpty()){
            for(Account Acc : Accemplist){
                Decimal TotalSal = 0;
                for(Employee__c emp : Acc.Employees__r){
                    TotalSal = TotalSal+emp.Salary__c;
                }
                Acc.Total_Salary__c = TotalSal;
            }
        }
        if(!Accemplist.isEmpty()){
            update Accemplist;
        } 
    }

}