public class OpportunityTriggerHandler {
    public Static void oppRating(List<Opportunity> NewList){
        for(Opportunity opp : NewList){
            if(opp.Amount>=100000 && opp.Amount<=500000){
                opp.Description = 'Hot Opportunity';
            }
        }
    }
    
   /* public static void oppAmountReq(List<Opportunity> NewList){
        for(Opportunity opp : NewList){
            if(opp.Amount == Null){
                opp.addError('Amount Cannot Be Null');
            }
        }
    }*/
    
   /* public static void closedLostReason(List<Opportunity> NewList){
        for(Opportunity opp : NewList){
            if(opp.StageName == 'Closed Lost' && 
               opp.Closed_Lost_Reason__c  ==null){
                   opp.addError('Closed Lost Reason Cannot Be Blank');
               }
        }
    }*/
    
    public static void updateOppDescrip(List<opportunity> newList,Map<Id,Opportunity> OldMap){
        for(Opportunity opp : newList){
            if(OldMap==null ||  opp.StageName!=OldMap.get(opp.Id).StageName){
                if(opp.StageName=='Closed Won'){
                     opp.Description = 'Opportunity is Closed Won';
                }else if(opp.StageName=='Closed Lost'){
                    opp.Description = 'Opportunity is Closed Lost';
            }else{
               opp.Description = 'Opportunity is Open';
                 }
               }        
             }
        }
    
    public static void latestOppAmnt(List<opportunity> opplist){
        List<Account> acclist = new List<Account>();
        for(Opportunity oppo : opplist){
            if(oppo.Accountid != null){
                Account acc = New Account();
               acc.id = oppo.AccountId;
                acc.Latest_Opportunity_Amount__c  = oppo.Amount ;
                acclist.add(acc);
            }
        }
        if(!acclist.isEmpty()){
            update acclist;
        }
    }
    public static void OnAfterInsert(List<opportunity> newList){
        Set<Id> accIds = new Set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        
        for(Opportunity opp : newlist){
            if(opp.AccountId != null){
              accIds.add(opp.AccountId);  
            }
        }
        accToBeUpdated = calculateAnnualRevenue(accIds);
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
    
    public static void OnAfterUpdate(List<opportunity> newList,Map<Id,Opportunity> OldMap){
         Set<Id> accIds = new Set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        
        for(Opportunity opp : newlist){
            if(opp.AccountId != null && opp.Amount != OldMap.get(opp.Id).Amount){
              accIds.add(opp.AccountId);  
            }
        }
        accToBeUpdated = calculateAnnualRevenue(accIds);
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
    
    public static void OnAfterDelete(List<Opportunity> OldList){
        Set<Id> accIds = new Set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        
        for(Opportunity opp : OldList){
            if(opp.AccountId != null){
              accIds.add(opp.AccountId);   
            }
        }
        accToBeUpdated = calculateAnnualRevenue(accIds);
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
    
    public static List<Account> calculateAnnualRevenue(Set<Id> accIds){
        
        List<Account> accToBeUpdated = new List<Account>();
         Map<Id,Decimal> accIdToAnnualRevenue = new Map<Id,Decimal>(); 
        
        for(Opportunity opp : [SELECT Id,Amount,AccountId FROM Opportunity WHERE AccountId IN:accIds]){
            Decimal total = 0;
            if(accIdToAnnualRevenue.containsKey(opp.AccountId)){
                total = accIdToAnnualRevenue.get(opp.AccountId);
            }
            if(opp.Amount != null){
               total = total + opp.Amount;
            }
            accIdToAnnualRevenue.put(opp.AccountId,total);
        }
        
        if(!accIdToAnnualRevenue.isEmpty()){
            for(Id i : accIdToAnnualRevenue.KeySet()){
                Account acc = new Account();
                acc.Id = i;
                acc.AnnualRevenue = accIdToAnnualRevenue.get(i);
                accToBeUpdated.add(acc);
            }
        }
        return accToBeUpdated;
    }
    
    public static void createRelatedTask(List<opportunity> newList,Map<Id,Opportunity> OldMap){
        List<Task> taslist = new List <TasK>();
        for(Opportunity opp : newlist){
            if(opp.StageName != OldMap.get(opp.Id).StageName){
                Task ts = new Task();
                ts.WhatId = opp.Id;
                ts.Subject = 'Email';
                ts.Status = 'In Progress';
                ts.Priority = 'Normal';
                ts.OwnerId =  System.Label.User_Id;
               
                taslist.add(ts);
            }
        }
        if(!taslist.isEmpty()){
            insert taslist;
        }
    }


}