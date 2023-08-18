public class EmployeetriggerHandler {
    public Static void EmployeeStatus(List<Employee__c> oldList){
        Profile p = [SELECT Id From Profile WHERE Name = 'System Administrator'];
        for( Employee__c  emp : oldList){
            if(emp.Active__c == true ) {
                emp.addError('Active Employee cannot be removed');
            }
        }
    }
    
   
    
    
    public Static void updateLeftEmpCountOnAcc(List<Employee__c> oldList){
        Set<Id> accIds = new Set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        Map<Id,Account>accIdToMap;
        List< Employee__c > empList = new List< Employee__c >();
        Map<Id,Decimal> accIdToTotalCount = New Map<Id,Decimal>();
        
        for( Employee__c emp: oldList){
            if(emp.Account__c != null){
                accIds.add(emp.Account__c);
                emplist.add(emp);
            }
        }
        
        if(!accIds.isEmpty()){
            accIdToMap = new Map<Id,Account>([SELECT Id,Name,Left_Employee_Count__c  
                                               FROM Account WHERE Id IN:accIds ]);
      
        }
         system.debug('sss' +accIdToMap );
        if(!empList.isempty()){
            for(Employee__c emp : emplist){
                if(accIdToMap.containskey(emp.Account__c)){
                    if(accIdToTotalCount.containskey(emp.Account__c)){
                        Decimal count = accIdToTotalCount.get(emp.Account__c) + 1;
                        accIdToTotalCount.put(emp.Account__c,count);
                    }else{
                        system.debug('mm'+ emp.Account__c + 'rr' + accIdToMap );
                         accIdToTotalCount.put(emp.Account__c,accIdToMap.get(emp.Account__c).Left_Employee_Count__c + 1);
                    }
                }
            }
        }
        
        for(Id accId : accIdToTotalCount.keyset()){
            Account acc = new Account();
            acc.id = accId;
            acc.Left_Employee_Count__c = accIdToTotalCount.get(accId);
            accToBeUpdated.add(acc);
        }
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
     public static void undeleteEmployees(List<Employee__c>NewList){
        List<Employee__c> empToBeUpdated = new List<Employee__c>();
         Set<Id> accIds = new Set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        Map<Id,Account>accIdToMap;
        List< Employee__c > empList = new List< Employee__c >();
        Map<Id,Decimal> accIdToTotalCount = New Map<Id,Decimal>();
        
        for(Employee__c emp : NewList){
            Employee__c e = new Employee__c();
            e.id = emp.Id;
            e.Active__c = true;
            empToBeUpdated.add(e);
            if(emp.Account__c != null){
                accIds.add(emp.Account__c);
                emplist.add(emp);
            }
        }
        
        if(!accIds.isEmpty()){
            accIdToMap = new Map<Id,Account>([SELECT Id,Name,Left_Employee_Count__c  
                                               FROM Account WHERE Id IN:accIds ]);
      
        }
         system.debug('sss' +accIdToMap );
        if(!empList.isempty()){
            for(Employee__c emp : emplist){
                if(accIdToMap.containskey(emp.Account__c)){
                    if(accIdToTotalCount.containskey(emp.Account__c)){
                        Decimal count = accIdToTotalCount.get(emp.Account__c) - 1;
                        accIdToTotalCount.put(emp.Account__c,count);
                    }else{
                        system.debug('mm'+ emp.Account__c + 'rr' + accIdToMap );
                         accIdToTotalCount.put(emp.Account__c,accIdToMap.get(emp.Account__c).Left_Employee_Count__c - 1);
                    }
                }
            }
        }
        
        for(Id accId : accIdToTotalCount.keyset()){
            Account acc = new Account();
            acc.id = accId;
            acc.Left_Employee_Count__c = accIdToTotalCount.get(accId);
            accToBeUpdated.add(acc);
        }
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
        
        if(!empToBeUpdated.isEmpty()){
            update empToBeUpdated;
        }
            
    } 
    
    public static void emailToEmployee(list<Employee__c>emplist,Map<id,Employee__c>Oldmap){
        list<Messaging.Email> emaList = new List<Messaging.Email>();
        
        for(Employee__c emp:emplist){
            if((Oldmap == null && emp.Email__c != null)||
               (Oldmap != null && emp.Email__c != null && oldmap.get(emp.Id).email__c == null)){
                    Messaging.SingleEmailMessage emaMsg = new Messaging.SingleEmailMessage();
                string[] toAddress = new string[] {emp.Email__c};
                emaMsg.setToAddresses(toAddress);
                string emailSub = 'Welcome '+ emp.Name;
                emaMsg.setSubject(emailSub);
                string disname = 'Welcome Notification';
                emaMsg.setSenderDisplayName(disname);
                string content = 'Hi ' + emp.Name + ',<br/><br/> '+
                    'Welcome To Our Company <br/><br/>' +
                    'Thank You <br/><br/>';
                emaMsg.setHtmlBody(content);
                emaList.add(emaMsg);
               }
        }
         Messaging.sendEmail(emaList);
    }

}