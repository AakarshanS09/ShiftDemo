public class ContactBatch implements Database.Batchable<sObject>,Database.Stateful {
    
    List<Id> successId = new List<Id>();
    List<Id> failureId = new List<Id>();
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id,Name,Active__c, lastName From Contact WHERE Active__c=FALSE]);
        
    }
    public void execute(Database.BatchableContext bc, List<Contact> conlist){
        
        //List<Contact> conToBeUpdated= new List<Contact>();
        if(!conlist.isEmpty()){
            for(contact con : conlist){
            if(!con.Active__c){
                con.Active__c= true;
                if(Test.isRunningTest() && con.LastName == 'Test9'){
                   con.LastName = null; 
                }
            }
        // conToBeUpdated.add(con);   
        }
        }
        
        Database.SaveResult[] srList= Database.update(conlist,false);
        
        for(Database.SaveResult sr : srList){
            if(sr.isSuccess()){
                successId.add(sr.getId());
            }
            else{
                for(Database.Error err : sr.geterrors()){
                    failureId.add(sr.getId());
                } 
            }
            
        }
    } 
    public void finish(Database.BatchableContext bc){
        
         AsyncApexJob a = [SELECT Status, NumberOfErrors, JobItemsProcessed,
                                TotalJobItems, CreatedBy.Email
                         FROM AsyncApexJob 
                         WHERE Id = :BC.getJobId()];
        
        if(failureId.size()>0){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            String[] toAddresses = new String[] { a.CreatedBy.Email };
                mail.setToAddresses(toAddresses);
            mail.setSubject('Contact Sucessfully updated to'+ a.Status);
            
            mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems +
                                  ' batches with '+ a.NumberOfErrors + ' failures.'+'SuccessRecordids: '+successId +';'+ 'failRecordids: '+ failureId);
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        
        if(successId.size()>0){
            Messaging.MassEmailMessage emails = new Messaging.MassEmailMessage();
                        
            emails.setTargetObjectIds(successId);
            emails.setTemplateID('00X5i0000012cMb');
            Messaging.sendEmail(new Messaging.MassEmailMessage[] {emails});  
        }
        
        
        
      /*  
        String[] toAddresses = new String[] { a.CreatedBy.Email };
        c
        if(successId.size()>0){
            sendEmail('Contact Sucessfully updated to True',successId );
        }
        
        if(failureId.size()>0){
            sendEmail('Contact was not updated',failureId );
        }
        mail.setSubject('Contact Sucessfully updated to'+ a.Status);
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'ContactCreation'];
        mail.setTemplateID(emailTemplate.Id); 
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //mail.setWhatId(contact.Id); 
        
    }*/
    
   // static void sendEmail(String subject, Set<Id> recordIds){
        
    }
    
}