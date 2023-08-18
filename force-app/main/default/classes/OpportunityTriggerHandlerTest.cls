@isTest
public class OpportunityTriggerHandlerTest {
    @isTest
    public Static void updateOppDescrip(){
        list<Opportunity> opplist = new List<opportunity>();
        
        For(Integer i=0;i<5;i++){
            Opportunity oppo = new Opportunity();
            oppo.Name = 'Tech '+ i;
            Oppo.CloseDate = System.today();
            oppo.StageName = 'Prospecting';
            oppo.Amount = 200000;
            opplist.add(oppo);
        }
        test.startTest();
        insert opplist;
        test.stopTest();
        
        List<Opportunity> updatedOpp = [SELECT id,Name,Amount,Description FROM Opportunity WHERE id =:opplist[0].id ];
        system.assertEquals('Opportunity is Open', updatedOpp[0].Description);
        
    }
    
    @isTest
    public Static void preventOppInsertion(){
        list<Opportunity> opplist = new List<opportunity>();
        For(Integer i=0;i<5;i++){
            Opportunity oppo = new Opportunity();
            oppo.Name = 'Tech '+ i;
            Oppo.CloseDate = System.today();
            oppo.StageName = 'Prospecting';
            opplist.add(oppo);
        }
        Test.startTest();
        Boolean ExceptionThrown = false;
        
        try{
            insert opplist;
        }
        catch(Exception e){
            Boolean ExpextedExcpetionThrown = 
                (e.getMessage().contains('Amount Cannot Be Null'))? True : False;
            system.assertEquals(true, ExpextedExcpetionThrown, e.getMessage());
        }
        Test.stopTest();
        
    }
    
    @isTest
    public static void oppClosedLostReason(){
        list<Opportunity> opplist = new List<opportunity>();
        For(Integer i=0;i<5;i++){
            Opportunity oppo = new Opportunity();
            oppo.Name = 'Tech '+ i;
            Oppo.CloseDate = System.today();
            oppo.StageName = 'Prospecting';
             opplist.add(oppo);
        }
        Test.startTest();
        insert opplist;
        for(Opportunity Opp : opplist){
            opp.StageName = 'Closed Lost';
        }
        Boolean ExceptionThrown = false;
        try{
            update opplist;
        }
        catch(Exception e){
             Boolean ExpextedExcpetionThrown = 
                     (e.getMessage().contains('ClosedLostReason Cannot Be Empty'))? True : False;
                 system.assertEquals(true, ExpextedExcpetionThrown, e.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    private Static void updateOppDescripWon(){
        list<Opportunity> opplist = new List<opportunity>();
        
        For(Integer i=0;i<5;i++){
            Opportunity oppo = new Opportunity();
            oppo.Name = 'Tech '+ i;
            Oppo.CloseDate = System.today();
            oppo.Amount = 200000;
            oppo.StageName = 'Prospecting';
            opplist.add(oppo);
        }
        test.startTest();
        insert opplist;
        for(Opportunity opp : opplist){
            opp.StageName = 'Closed Won';
        }
        update opplist;
        test.stopTest();
        
        List<Opportunity> updatedOpp = [SELECT id,Name,Amount,Description FROM Opportunity WHERE id =:opplist[0].id ];
        system.assertEquals('Opportunity is Closed Won', updatedOpp[0].Description);
    }
    @isTest
    private Static void updateOppDescripLost(){
        list<Opportunity> opplist = new List<opportunity>();
        
        For(Integer i=0;i<5;i++){
            Opportunity oppo = new Opportunity();
            oppo.Name = 'Tech '+ i;
            Oppo.CloseDate = System.today();
            oppo.Amount = 200000;
            oppo.StageName = 'Prospecting';
            opplist.add(oppo);
        }
        test.startTest();
        insert opplist;
        for(Opportunity opp : opplist){
            opp.StageName = 'Closed Lost';
            opp.Closed_Lost_Reason__c= 'there is no way';
        }
        update opplist;
        test.stopTest();
        
        List<Opportunity> updatedOpp = [SELECT id,Name,Amount,Description FROM Opportunity WHERE id =:opplist[0].id ];
        system.assertEquals('Opportunity is Closed Lost', updatedOpp[0].Description);
    }
    
    @isTest
    public static void PopulateLatestAmnt(){
         List<Account> acclist = New List<Account>();
        List<Opportunity> opplist = new List<Opportunity>();
        
        for(Integer i = 0;i<5;i++){
        Account acc = new Account();
            acc.Name = 'Tech '+ i;
            acclist.add(acc);
        }
        
        insert acclist;
          For(Account acc : acclist){
            Opportunity oppo = new Opportunity();
            oppo.Name = acc.Name;
            Oppo.CloseDate = System.today();
            oppo.StageName = 'Prospecting';
            oppo.Amount = 2000;
            oppo.AccountId = acc.Id;  
            opplist.add(oppo);
        }
        test.startTest();
        insert opplist;
        test.stopTest();
        
         List<Opportunity> updatedopp = [SELECT id,Amount From Opportunity WHERE id =: opplist[0].id];
        List<Account> acslist = [SELECT Id,Latest_Opportunity_Amount__c   From Account WHERE Id =: acclist[0].id];
        system.assertEquals(updatedopp[0].Amount, acslist[0].Latest_Opportunity_Amount__c );
    }
    
      @isTest
    private Static void createOppTask(){
        list<Opportunity> opplist = new List<opportunity>();
        
        For(Integer i=0;i<5;i++){
            Opportunity oppo = new Opportunity();
            oppo.Name = 'Tech '+ i;
            Oppo.CloseDate = System.today();
            oppo.StageName = 'Prospecting';
            opplist.add(oppo);
        }
        test.startTest();
   try{
                 insert opplist;
             }
             catch(Exception e){
                 Boolean ExpextedExcpetionThrown = 
                     (e.getMessage().contains('Amount Cannot Be Null'))? True : False;
                 system.assertEquals(true, ExpextedExcpetionThrown, e.getMessage());
             }
        for(Opportunity opp : opplist){
            opp.StageName = 'Closed Won';
        }
        update opplist;
        test.stopTest();
        
        List<Task> updatedTask = [SELECT id,Subject FROM Task WHERE id =:opplist[0].id ];
        system.assert(updatedTask!=null,'Task is not Created');
    }
}