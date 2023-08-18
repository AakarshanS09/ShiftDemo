public class ConPhnmap {
    public static void updateContactPhone(){
        List<Account> accList = [SELECT Id,Phone FROM Account
                                 WHERE CreatedDate = LAST_YEAR AND
                                  Phone != null];
        Map<Id,Account> accIdToAccountMap = new Map<Id,Account>(accList);
        
        List<Contact> conList = [SELECT Id,AccountId,Phone From Contact
                                 WHERE AccountId IN:accIdToAccountMap.KEYSET()];
        List<Contact> contactsToBeUpdated = new List<Contact>();
        if(!conList.isEmpty()){
            for(Contact con : conList){
                if(accIdToAccountMap.containskey(con.AccountId)){
                    Contact conRec = new Contact();
                    conRec.id = Con.id;
                    conRec.Phone = accIdToAccountMap.get(con.AccountId).Phone;
                    contactsToBeUpdated.add(conRec);
                }
            }
        }
         if(!contactsToBeUpdated.isEmpty()){
            update contactsToBeUpdated;
    }
    }
}