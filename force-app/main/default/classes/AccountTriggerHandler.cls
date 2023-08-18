public class AccountTriggerHandler {
     
    public static void preventDelete(List<Account> Oldlist){
        for(Account acc : Oldlist){
            if(acc.Active__c){
                acc.addError(Label.PreventDelete);
            }
        }
    }  
    
   /* public static void preventUpdate(List<Account> Oldlist){
        for(Account acc : Oldlist){
            if(acc.CreatedDate == System.today()){
                acc.addError('Account Cannot Be Updated');
            }
        }
    }*/
    
    public static void updateRating(List<Account> Newlist,Map<Id,Account> Oldmap){
        for(Account acc : Newlist ){
            if((acc.Industry == 'Media'&& Oldmap == null)|| 
                acc.Industry == 'Media'&& acc.Industry !=Oldmap.get(acc.Id).Industry  ){
                acc.Rating = 'Hot';
                }
            
        }
    }
    
  public static void removeRating(List<Account> Newlist,Map<Id,Account> Oldmap){
        for(Account acc : Newlist){
            if(acc.Industry != 'Media' && Oldmap.get(acc.Id).Industry =='Media'){
                acc.Rating = null;
            }
        }
    }
    
    public static void copyBillingToShipping(List<Account> newlist,Map<Id,Account> Oldmap){
        for(Account acc :newlist ){
            if((acc.Copy_Billing_To_Shipping__c && Oldmap == null)||
              (acc.Copy_Billing_To_Shipping__c && 
               acc.Copy_Billing_To_Shipping__c !=Oldmap.get(acc.Id).Copy_Billing_To_Shipping__c)){
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingStreet = acc.BillingState;
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }
        }
    }
    
    public static void createRelatedCon(List<Account> NewList){
        List<Contact> conlist = new List<Contact>(); 
        for(Account acc :  NewList){
            Contact conc = new Contact();
            conc.LastName = acc.Name;
            conc.AccountId = acc.Id;
            conlist.add(conc);
        }
        if(!conlist.isempty()){
            insert conlist;
        }
    }
   
    public Static void createRelatedOpp(List<Account> Newlist){
        List<opportunity> newOpp = new List<opportunity>();
        
        for(Account acc : newlist){
            opportunity opp = new opportunity();
            opp.Name =acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate =system.today();
            opp.AccountId = acc.Id;
            newOpp.add(opp);
            } 
        
        Database.SaveResult[] srList = Database.insert(newOpp,false);
        
        for(Integer i=0;i<srList.size();i++){
            if(!srList[i].isSuccess()){
                String errors = 'In Opportunity...';
                for(Database.Error err : srList[i].getErrors()){
                    errors = errors + err.getMessage();
                }
              Newlist[i].addError(errors);  
            }
        }
      
     
    }
    
    public Static void updatePhoneDescrip(List<Account> Newlist,Map<Id,Account> Oldmap){
        for(Account acc : Newlist){
            if(acc.Phone != Oldmap.get(acc.Id).phone && Oldmap != null && acc.Phone == null){
                acc.addError('You cannot make phone as blank');
            }else if(acc.Phone != Oldmap.get(acc.Id).phone && Oldmap != null){
                acc.Description = 'Phone is modified on Account';
            }   
            } 
        }
    
    
    public static void updateRelatedOppPhone(List<Account> Newlist,Map<Id,Account> Oldmap){
        
        Map<Id,Account> accIdToAccMap = new Map<Id,Account>();
        List<Opportunity> OpptoBeUpdated = new List<Opportunity>();
        
        for(Account acc : Newlist){
            if(acc.Phone != Oldmap.get(acc.Id).phone && Oldmap != null){
                accIdToAccMap.put(acc.Id,acc);
            }
    }
        for(Opportunity opp : [Select Id,AccountId,phone__c From Opportunity WHERE AccountId IN : accIdToAccMap.keySet()]){
        Opportunity Oppo = new Opportunity();
            if(accIdToAccMap.containskey(opp.AccountId)){
                oppo.Id = opp.Id;
            	oppo.phone__c = accIdToAccMap.get(opp.AccountId).phone;
            	OpptoBeUpdated.add(Oppo);
            }
            
        }
        
        if(!OpptoBeUpdated.isEmpty()){
            Update OpptoBeUpdated;
        }
        }
     
     public static void updateRelatedConPhone(List<Account> Newlist,Map<Id,Account> Oldmap){
        
        Set<Id> accIds = new Set<Id>();
        List<Contact> ContoBeUpdated = new List<Contact>();
        
        for(Account acc : Newlist){
            if(acc.Phone != Oldmap.get(acc.Id).phone && Oldmap != null){
                accIds.add(acc.Id);
            }
    }
       for(Account acc : [SELECT Id,Phone,(SELECT Id,HomePhone FROM Contacts)
                          FROM Account WHERE id=: accIds ]){
                              if(acc.Contacts!=null){
                                  for(Contact Con : acc.Contacts){
                                      con.HomePhone = acc.Phone;
                                      ContoBeUpdated.add(con);
                                  }    
                              }                   
                          }
        
        if(!ContoBeUpdated.isEmpty()){
            Update ContoBeUpdated;
        }
        }
     
       public static void updRelatedConAddress(List<Account> Newlist,Map<Id,Account> Oldmap){
        
        Map<Id,Account> accIdToAccMap = new Map<Id,Account>();
        List<Contact> ContoBeUpdated = new List<Contact>();
            
        for(Account acc : Newlist){
            if((acc.BillingCity  != Oldmap.get(acc.Id).BillingCity||
                acc.BillingCountry  != Oldmap.get(acc.Id).BillingCountry||
                acc.BillingState  != Oldmap.get(acc.Id).BillingState||
                acc.BillingStreet  != Oldmap.get(acc.Id).BillingStreet||
                acc.BillingPostalCode  != Oldmap.get(acc.Id).BillingPostalCode) 
               && Oldmap != null){
                accIdToAccMap.put(acc.Id,acc);
            }
    }
           for(Contact con : [Select Id,AccountId,MailingAddress  From Contact WHERE AccountId IN : accIdToAccMap.keySet()]){
               Contact conc = new Contact();
            if(accIdToAccMap.containskey(con.AccountId)){
                conc.Id = con.Id;
            	conc.MailingCity = accIdToAccMap.get(con.AccountId).BillingCity;
                conc.MailingCountry = accIdToAccMap.get(con.AccountId).BillingCountry;
                conc.MailingState = accIdToAccMap.get(con.AccountId).BillingState;
                conc.MailingStreet = accIdToAccMap.get(con.AccountId).BillingStreet;
                conc.MailingPostalCode = accIdToAccMap.get(con.AccountId).BillingPostalCode;
            	ContoBeUpdated.add(conc);
            }
           }
           if(!ContoBeUpdated.isEmpty()){
            Update ContoBeUpdated;
        } 
       }
     public static void updateRelatedOppStageName(List<Account> Newlist,Map<Id,Account> Oldmap){
        
        Map<Id,Account> accIdToAccMap = new Map<Id,Account>();
        List<Opportunity> OpptoBeUpdated = new List<Opportunity>();
        
        for(Account acc : Newlist){
            if(!acc.Active__c && Oldmap.get(acc.Id).Active__c ){
                accIdToAccMap.put(acc.Id,acc);
            }
    }
        for(Opportunity opp : [Select Id,AccountId,StageName From Opportunity WHERE AccountId IN : accIdToAccMap.keySet()]){
            if(accIdToAccMap.containskey(opp.AccountId)){
                for(Account acc : Newlist){
                     if(!acc.Active__c && opp.StageName != 'Closed Won'){
                        opp.StageName = 'Closed Lost';
                    }
                }
               
            	OpptoBeUpdated.add(Opp);
            }
            
        }
        
        if(!OpptoBeUpdated.isEmpty()){
            Update OpptoBeUpdated;
        }
        }
   
}