public class UpdateContactMailingAddress implements Database.Batchable<sObject>, Database.Stateful{
    
    public Integer recordCount = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SElECT Id,BillingStreet,BillingCity,BillingState,BillingPostalCode,'+ 
                        '(SELECT Id,MailingStreet,MailingCity,MailingState,MailingPostalCode From Contacts)'+
                          'From Account Where BillingCountry = \'USA\'' 
                                       );

    }
    
    public void execute(Database.BatchableContext bc,List<Account> acclist){
        List<Contact> conlist = new List<Contact>();
        
        for( Account acc : acclist){
            for ( Contact con :acc.Contacts){
                con.MailingStreet = acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
                con.MailingState = acc.BillingState;
                con.MailingPostalCode = acc.BillingPostalCode;
                conlist.add(con);
                recordCount++;
            }
        }
        update conlist;
    }
        public void finish(Database.BatchableContext bc){
            System.debug('Records Count ='+recordCount);
        }
    


}