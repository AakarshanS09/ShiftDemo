@isTest
public class ContactBatchTest {
    @isTest
    Public static void contactTestCl(){
        List<Contact> conList = new List<Contact>();
        
        for(Integer i=0;i<10;i++){
            Contact con = new Contact();
            con.LastName = 'Test'+ i;
            con.Email = 'aakarshanprakash94@gmail.com';
            conList.add(con);
        }
        
        Test.startTest();
        insert conList;
        
        ContactBatch conProcess = new ContactBatch();
        Id batchId=Database.executeBatch(conProcess, 50); 
        test.stopTest();
        
        List<Contact> updContact = [SELECT Id,LastName,Active__c FROM Contact WHERE ID=:conList[0].Id];
        system.assertEquals(true, updContact[0].Active__c);
        
    }
 /*   @isTest
    Public static void contactTestNg(){
        List<Contact> conList = new List<Contact>();
        
        for(Integer i=0;i<10;i++){
            Contact con = new Contact(); 
            con.LastName = 'Test'+ i;
            conList.add(con);
        }
        
        Test.startTest();
        insert conList;
        
        ContactBatch conProcess = new ContactBatch();
        Id batchId=Database.executeBatch(conProcess, 50); 
        test.stopTest();
        
        List<Contact> updContact = [SELECT Id,LastName,Active__c FROM Contact WHERE ID=:conList[0].Id];
        system.assertEquals(true, updContact[0].Active__c);
        
    }*/
    
    

}