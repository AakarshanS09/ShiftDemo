public with sharing class ContactController {
   private String sortOrder = 'FirstName';
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accId){
        return[SELECT Id,FirstName,LastName,Phone,Email 
               FROM Contact WHERE AccountId=: accId WITH
                SECURITY_ENFORCED];
    }

}