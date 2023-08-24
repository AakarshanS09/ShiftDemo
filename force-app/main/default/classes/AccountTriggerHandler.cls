public with sharing class AccountTriggerHandler {
    public static void updateRating(List<Account> newlist, Map<Id, Account> oldmap) {
        for (Account acc : newlist) {
            if ((acc.Industry == 'Media' && oldmap == null) || acc.Industry == 'Media' && acc.Industry != oldmap.get(acc.Id).Industry) {
                acc.Rating = 'Hot';
            }
        }
    }

    public static void updatePhoneDescrip(List<Account> newlist, Map<Id, Account> oldmap) {
        for (Account acc : newlist) {
            if (acc.Phone != oldmap.get(acc.Id).phone && oldmap != null) {
                acc.Description = 'Phone number is given';
            }
        }
    }

    public static void preventDelete(List<Account> oldlist) {
        for (Account acc : oldlist) {
            if (acc.Active__c) {
                acc.addError(Label.PreventDelete);
            }
        }
    }

    /* public static void preventUpdate(List<Account> oldlist){
for(Account acc : oldlist){
if(acc.CreatedDate == System.today()){
acc.addError('Account Cannot Be Updated');
}
}
}*/

    public static void removeRating(List<Account> newlist, Map<Id, Account> oldmap) {
        for (Account acc : newlist) {
            if (acc.Industry != 'Media' && oldmap.get(acc.Id).Industry == 'Media') {
                acc.Rating = null;
            }
        }
    }

    public static void copyBillingToShipping(List<Account> newlist, Map<Id, Account> oldmap) {
        for (Account acc : newlist) {
            if (
                (acc.Copy_Billing_To_Shipping__c && oldmap == null) ||
                (acc.Copy_Billing_To_Shipping__c && acc.Copy_Billing_To_Shipping__c != oldmap.get(acc.Id).Copy_Billing_To_Shipping__c)
            ) {
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingStreet = acc.BillingState;
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }
        }
    }

    public static void createRelatedCon(List<Account> newList) {
        List<Contact> conlist = new List<Contact>();
        for (Account acc : newList) {
            Contact conc = new Contact();
            conc.LastName = acc.Name;
            conc.AccountId = acc.Id;
            conlist.add(conc);
        }
        if (!conlist.isempty()) {
            insert as user conlist;
        }
    }

    public static void createRelatedOpp(List<Account> newlist) {
        List<opportunity> newOpp = new List<opportunity>();

        for (Account acc : newlist) {
            opportunity opp = new opportunity();
            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = system.today();
            opp.AccountId = acc.Id;
            newOpp.add(opp);
        }

        Database.SaveResult[] srList = Database.insert(newOpp, false);

        for (Integer i = 0; i < srList.size(); i++) {
            if (!srList[i].isSuccess()) {
                String errors = 'In Opportunity...';
                for (Database.Error err : srList[i].getErrors()) {
                    errors = errors + err.getMessage();
                }
                Newlist[i].addError(errors);
            }
        }
    }

    public static void updateRelatedOppPhone(List<Account> newlist, Map<Id, Account> oldmap) {
        Map<Id, Account> accIdToAccMap = new Map<Id, Account>();
        List<Opportunity> opptoBeUpdated = new List<Opportunity>();

        for (Account acc : newlist) {
            if (acc.Phone != oldmap.get(acc.Id).phone && oldmap != null) {
                accIdToAccMap.put(acc.Id, acc);
            }
        }
        for (Opportunity opp : [
            SELECT Id, AccountId, phone__c
            FROM Opportunity
            WHERE AccountId IN :accIdToAccMap.keySet()
            WITH SECURITY_ENFORCED
        ]) {
            Opportunity oppo = new Opportunity();
            if (accIdToAccMap.containskey(opp.AccountId)) {
                oppo.Id = opp.Id;
                oppo.phone__c = accIdToAccMap.get(opp.AccountId).phone;
                opptoBeUpdated.add(oppo);
            }
        }

        if (!OpptoBeUpdated.isEmpty()) {
            update opptoBeUpdated;
        }
    }

    public static void updateRelatedConPhone(List<Account> newlist, Map<Id, Account> oldmap) {
        Set<Id> accIds = new Set<Id>();
        List<Contact> conToBeUpdated = new List<Contact>();

        for (Account acc : Newlist) {
            if (acc.Phone != Oldmap.get(acc.Id).phone && Oldmap != null) {
                accIds.add(acc.Id);
            }
        }
        for (Account acc : [
            SELECT Id, Phone, (SELECT Id, HomePhone FROM Contacts)
            FROM Account
            WHERE id = :accIds
            WITH SECURITY_ENFORCED
        ]) {
            if (acc.Contacts != null) {
                for (Contact con : acc.Contacts) {
                    con.HomePhone = acc.Phone;
                    conToBeUpdated.add(con);
                }
            }
        }

        if (!conToBeUpdated.isEmpty()) {
            update conToBeUpdated;
        }
    }

    public static void updRelatedConAddress(List<Account> newlist, Map<Id, Account> oldmap) {
        Map<Id, Account> accIdToAccMap = new Map<Id, Account>();
        List<Contact> contoBeUpdated = new List<Contact>();

        for (Account acc : newlist) {
            if (
                (acc.BillingCity != Oldmap.get(acc.Id).BillingCity ||
                acc.BillingCountry != Oldmap.get(acc.Id).BillingCountry ||
                acc.BillingState != Oldmap.get(acc.Id).BillingState ||
                acc.BillingStreet != Oldmap.get(acc.Id).BillingStreet ||
                acc.BillingPostalCode != Oldmap.get(acc.Id).BillingPostalCode) && Oldmap != null
            ) {
                accIdToAccMap.put(acc.Id, acc);
            }
        }
        for (Contact con : [
            SELECT Id, AccountId, MailingAddress
            FROM Contact
            WHERE AccountId IN :accIdToAccMap.keySet()
            WITH SECURITY_ENFORCED
        ]) {
            Contact conc = new Contact();
            if (accIdToAccMap.containskey(con.AccountId)) {
                conc.Id = con.Id;
                conc.MailingCity = accIdToAccMap.get(con.AccountId).BillingCity;
                conc.MailingCountry = accIdToAccMap.get(con.AccountId).BillingCountry;
                conc.MailingState = accIdToAccMap.get(con.AccountId).BillingState;
                conc.MailingStreet = accIdToAccMap.get(con.AccountId).BillingStreet;
                conc.MailingPostalCode = accIdToAccMap.get(con.AccountId).BillingPostalCode;
                ContoBeUpdated.add(conc);
            }
        }
        if (!ContoBeUpdated.isEmpty()) {
            update ContoBeUpdated;
        }
    }
    public static void updateRelatedOppStageName(List<Account> newlist, Map<Id, Account> oldmap) {
        Map<Id, Account> accIdToAccMap = new Map<Id, Account>();
        List<Opportunity> opptoBeUpdated = new List<Opportunity>();

        for (Account acc : newlist) {
            if (!acc.Active__c && Oldmap.get(acc.Id).Active__c) {
                accIdToAccMap.put(acc.Id, acc);
            }
        }
        for (Opportunity opp : [
            SELECT Id, AccountId, StageName
            FROM Opportunity
            WHERE AccountId IN :accIdToAccMap.keySet()
            WITH SECURITY_ENFORCED
        ]) {
            if (accIdToAccMap.containskey(opp.AccountId)) {
                for (Account acc : Newlist) {
                    if (!acc.Active__c && opp.StageName != 'Closed Won') {
                        opp.StageName = 'Closed Lost';
                    }
                }

                opptoBeUpdated.add(Opp);
            }
        }

        if (!opptoBeUpdated.isEmpty()) {
            update opptoBeUpdated;
        }
    }
}
