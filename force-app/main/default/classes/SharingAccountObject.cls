public class SharingAccountObject {
    public static void shareRecords(){
        
        List<Account> accList = [SELECT Id,Name From Account WHERE Id='0015i00000fDF0BAAW'];
        
        AccountShare accShare = new AccountShare();
        accShare.AccountAccessLevel='Read';
        accShare.OpportunityAccessLevel='Read';
        accShare.UserOrGroupId = '0055i000005yJxRAAU';
        accShare.AccountId =accList[0].id ;
        
        if(accList.size()>0){
             insert accShare;
        }
           
                
    }

}