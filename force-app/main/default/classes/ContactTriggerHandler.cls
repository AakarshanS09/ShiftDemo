public class ContactTriggerHandler {
    public static void sendEmailNotification(List<Contact> conlist){
        
        List<Messaging.Email> emaList = new List<Messaging.Email>();
        
        For(Contact con : conlist){
            if(con.Email != null){
                Messaging.SingleEmailMessage emaMsg = new Messaging.SingleEmailMessage();
                string[] toAddress = new string[] {con.Email};
                emaMsg.setToAddresses(toAddress);
                string emailSub = 'Welcome '+ con.LastName;
                emaMsg.setSubject(emailSub);
                string disname = 'Welcome Notification';
                emaMsg.setSenderDisplayName(disname);
                string content = 'Hi ' + con.LastName + ',<br/><br/> '+
                    'Welcome To Salesforce Ecosystem <br/><br/>' +
                    'Thank You <br/><br/>';
                emaMsg.setHtmlBody(content);
                emaList.add(emaMsg);
                
            }
        }
        Messaging.sendEmail(emaList);
    }
    
    public static void totalContactCount(list<Contact> conlist){
        List<Account> accToBeUpdated = new List<Account>();
        Set<Id> accIds = new Set<Id>();
        
        For(Contact con : conlist){
            if(con.AccountId != null){
                accIds.add(con.AccountId);
            }
        }
        
        for(Account acc : [SELECT Id, Total_Contacts__c,(SELECT Id FROM Contacts)  FROM Account Where Id IN:accIds]){
            acc.Total_Contacts__c = acc.contacts.size();
            accToBeUpdated.add(acc);
        }
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
        
    }
    
    public static void preventDuplicate(List<Contact>Newlist){
        List<String> emailValues = new List<String>();
         List<Id> accIds = new List<Id>();
      
        For(Contact con : newlist){
            if(con.AccountId != null){
                accIds.add(con.AccountId);
            }
            if(con.Email != null){
               emailValues.add(con.email); 
            }

        }
          List<Contact> conList = [SELECT Id,AccountId, Email FROM Contact where accountid in:accIds or email in :emailValues ]; 
       
        for(Contact cons : conList){
            if(( emailValues.contains(cons.Email) && cons.AccountId == null) || (accIds.contains(cons.AccountId) && emailValues.contains(cons.Email))){
                cons.addError('This record cannot be created as it it appears to be a duplicate');
            }
        }
    }
    public static void preventPrimaryContact(List<Contact>cocList){
        Set<Id> conId = new Set<Id>();
       // List<Contact> conList= [SELECT Id,Primary_Contact__c FROM contact WHERE AccountId!=null];
        for(Contact con : cocList){
            if(con.Primary_Contact__c && con.AccountId!= null){
                conId.add(con.AccountId);
            }
            for(Contact coc:cocList){
                if(conId.contains(coc.AccountId) && coc.Primary_Contact__c){
                    coc.addError('There is already a primary Contact');
                }
            }
        }
    }
    public static void updateAccount(List<Contact>cocList,Map<Id,Contact> Oldmap){
        Set<Id>accIds=new Set<Id>();
        List<Account>accToBeUpdated=new List<Account>();
        for(contact con:cocList){
            account acc = new account();
            if(con.Active__c && con.Active__c!=OldMap.get(con.Id).Active__c){
               accIds.add(con.accountid);  
               
            }
        }
        for(Account acc : [SELECT Id, counter__c,(SELECT Id,Active__c FROM Contacts)  FROM Account Where Id IN:accIds]){
            if(acc.Contacts!=null){
                for(Contact coc : acc.Contacts){
                if(coc.Active__c){
                    acc.counter__c=acc.counter__c+1;
                    accToBeUpdated.add(acc);
                }
            }
            }
            
        }  
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
        
    }

}