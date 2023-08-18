@isTest
public class AccountTriggerRatingTest {
    
    @isTest
    private static void preventAccDeletion(){
        list<Account> acclist = new List<Account>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio'+i;
            acc.Active__c = true;
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
        Boolean exceptionThrown = false;
        try{
            delete acclist;
        }
        catch(Exception e){
            exceptionThrown = true;
            Boolean expectedExceptionThrown = (e.getMessage().contains(label.PreventDelete)) ? true:false;
            system.assertEquals(true, expectedExceptionThrown, e.getMessage());
        }
        system.assertEquals(true, exceptionThrown, 'No exception Thrown');
        Test.stopTest();
    }
    
   /* public static void preventUpdate(){
        list<Account> acclist = new List<Account>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio'+i;
            acc.Active__c = true;
            acclist.add(acc);
        }
        
        Test.startTest();
        insert acclist;
        for(Account acc : acclist){
            acc.Phone = '98887';
        }
        Boolean exceptionThrown = false;
        try{
            update acclist;
        }
        catch(Exception e){
            exceptionThrown = true;
            Boolean expectedExceptionThrown = 
                (e.getMessage().contains('Account Cannot Be Upated')) ? true:false;
            system.assertEquals(true, expectedExceptionThrown, e.getMessage());
        }
        system.assertEquals(true, exceptionThrown, 'No exception Thrown');
        Test.stopTest();
    }*/
    
     @isTest
    public Static void updateAccrating(){
        list<Account> acclist = new List<Account>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio'+i;
            acc.Industry = 'Media';
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
        Test.stopTest();
        
        list<Account> updatedAcc = [SELECT Id,Rating From Account WHERE id =:acclist[0].id];
        system.assertEquals('Hot', updatedAcc[0].Rating);
    }
    
    @isTest
    public Static void updatedAccrating(){
        list<Account> acclist = new List<Account>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio'+i;
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
        for(Account acc : acclist){
            acc.Industry = 'Media';
        }
        update acclist;
        Test.stopTest();
        
        list<Account> updatedAcc = [SELECT Id,Rating From Account WHERE id =:acclist[0].id];
        system.assertEquals('Hot', updatedAcc[0].Rating);
    }
    
    @isTest
    public static void updateBillingToShiping(){
        List <Account> acclist = new List<Account>();
        for(Integer i=0;i<5;i++){
        Account acc = new Account();
            acc.Name = 'Trio'+i;
            acc.BillingCountry = 'USA';
            acc.BillingCity = 'Test';
            acc.BillingState = 'TN';
            acc.BillingStreet = '2/789 main road';
            acc.BillingPostalCode = '678966';
            acc.Copy_Billing_To_Shipping__c = true;
            acclist.add(acc);
        }
         Test.startTest();
        insert acclist;
        Test.stopTest();
        
        list<Account> updatedAcc = [SELECT Id,ShippingCountry From Account WHERE id =:acclist[0].id];
        system.assertEquals('USA', updatedAcc[0].ShippingCountry);
    }
    
    @isTest
    public static void createRelatedCon(){
        list<Account> acclist = new List<Account>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio '+i;
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
        Test.stopTest();
        
     List <Contact> conlist = [Select id,LastName FROM Contact WHERE Accountid =: acclist[0].id ];
    system.assert(conlist!=null,'Contact is not Created');
    }
    
    @isTest
    public static void createRelatedOpp(){
        list<Account> acclist = new List<Account>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio '+i;
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
        Test.stopTest();
        
     List <Opportunity> opplist = [Select id FROM Opportunity WHERE Accountid =: acclist[0].id ];
    system.assert(opplist!=null,'Opportunity is not Created');
    }
    
    @isTest
    public static void updateAccDescription(){
         list<Account> acclist = new List<Account>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio '+i;
            acc.Phone = '9879777';
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
       
        
        for(Account acc : acclist){
            acc.Phone = '678756';
        }
        update acclist;
         Test.stopTest();
        List<Account> updatedacc = [SELECT Id,Description FROM Account WHERE Id=:acclist[0].id];
        system.assertEquals('Phone is modified on Account', updatedacc[0].Description); 
    }
    
     @isTest
    public static void updateRelatedOppPhn(){
        list<Account> acclist = new List<Account>();
        List<Opportunity> opplist = new List<Opportunity>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio '+i;
            acc.Phone = '8785567';
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
        
        for(Account acc :acclist){
            Opportunity oppo = new Opportunity();
            oppo.Name = acc.Name;
            Oppo.CloseDate = System.today().adddays(7);
            oppo.StageName = 'Prospecting';
            oppo.Amount = 2000;
            oppo.AccountId = acc.Id;  
            opplist.add(oppo);
        }
         insert opplist;
        
        for(Account acc :acclist){
            acc.Phone = '9334543';
        }
        update acclist;
        Test.stopTest();
   List<Opportunity> updatedopp = [SELECT Id,phone__c FROM Opportunity WHERE Id=:opplist[0].id];
        system.assertEquals('9334543', updatedopp[0].phone__c);
    
}
    
 @isTest
    public static void updateRelatedConPhn(){
        list<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio '+i;
            acc.Phone = '8785567';
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
        
        for(Account acc :acclist){
            Contact con = new Contact();
            con.LastName = acc.Name;
            con.AccountId = acc.Id;  
            conlist.add(con);
        }
         insert conlist;
        
        for(Account acc :acclist){
            acc.Phone = '9334543';
        }
        update acclist;
        Test.stopTest();
   List<Contact> updatedCon = [SELECT Id,HomePhone  FROM Contact WHERE Id=:conlist[0].id];
        system.assertEquals('9334543', updatedCon[0].HomePhone );
    
}
    
    @isTest
    public static void updRelatedConMailAddress(){
        list<Account> acclist = new List<Account>();
        List<Contact> conlist = new List<Contact>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio '+i;
            acc.Phone = '8785567';
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
        
        for(Account acc :acclist){
            Contact con = new Contact();
            con.LastName = acc.Name;
            con.AccountId = acc.Id;  
            conlist.add(con);
        }
         insert conlist;
        
        for(Account acc :acclist){
            acc.BillingCountry = 'USA';
            acc.BillingCity = 'Test';
            acc.BillingState = 'TN';
            acc.BillingStreet = '2/789 main road';
            acc.BillingPostalCode = '678966';
        }
        update acclist;
        Test.stopTest();
   List<Contact> updatedCon = [SELECT Id,MailingCountry  FROM Contact WHERE Id=:conlist[0].id];
        system.assertEquals('USA', updatedCon[0].MailingCountry );
    
}
     @isTest
    public static void updateRelOppStage(){
        list<Account> acclist = new List<Account>();
        List<Opportunity>opplist = new List<Opportunity>();
        For(Integer i=0;i<5;i++){
            Account acc = new Account();
            acc.Name = 'Trio '+i;
            acc.Active__c = true;
            acclist.add(acc);
        }
        Test.startTest();
        insert acclist;
        
          for(Account acc :acclist){
            Opportunity oppo = new Opportunity();
            oppo.Name = acc.Name;
            Oppo.CloseDate = System.today().adddays(7);
            oppo.StageName = 'Prospecting';
            oppo.Amount = 2000;
            oppo.AccountId = acc.Id;  
            opplist.add(oppo);
        }
         insert opplist;
        
        for(Account acc :acclist){
            acc.Active__c = false;
        }
        update acclist;
        Test.stopTest();
        
     List <Opportunity> updatedopp = [Select id,StageName FROM Opportunity WHERE Accountid =: acclist[0].id ];
    system.assertEquals('Closed Lost', updatedopp[0].StageName);
    }
    
}