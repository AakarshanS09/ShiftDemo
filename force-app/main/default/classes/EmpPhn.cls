public class EmpPhn {
    Public Static Void EmpWithPhn(){
        List<Employee__c> Emplist = 
            [SElECT Id, Phone__c,Account__r.Phone
             From Employee__c];
        if(!Emplist.isempty()){
            for(Employee__c emp : Emplist){
                 if(emp.Phone__c == null){
                    emp.Phone__c = emp.Account__r.phone;
                }
            }
        }
        if(!Emplist.isempty()){
            update Emplist;
        }  
    }

}