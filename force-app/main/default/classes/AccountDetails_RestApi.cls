/*@RestResource(urlmapping='/accountInfo/*')
global class Postman {
    @httpget
    global static Account getAccount(){
       RestRequest req = RestContext.request;
        String Id = req.requestURI.substring(req.requestURI.lastIndexOf('/')+ 1);
        list<Account> acclist =  new List<Account>();
        Account reAcc = new Account();
        acclist = [SELECT ID,Name FROM Account WHERE Id =:Id];
        if(!acclist.isEmpty()){
        Account acc = new Account();
        acc.Id = acclist[0].Id;
        acc.Name = acclist[0].Name;
        reAcc = acc;
        }
        return reAcc;
        
    }
}*/

    @RestResource(urlMapping='/accountDetails/*')
global class AccountDetails_RestApi {

    @HttpGet
    global static AccountDetail getAccountDetails() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;


        String accId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

        AccountDetail response = new AccountDetail();

        if (string.isBlank(accId)){
            
            response.success = false;
            response.message = 'Account ID is required';
            res.statusCode = 400;
        } else {
            system.debug('accid == ' + accId);
            List<Account> accList = [SELECT Id, Name FROM Account WHERE Id = :accId];
            System.debug('accList=='+ accList);
            //accList == null
            if (accList.isEmpty()) {
                response.success = false;
                response.message = 'There is no account with the Id';
                res.statusCode = 400;
            }else{
                response.success = true;
                response.message = 'Account details retrieved successfully';
                response.accountId = accList[0].Id;
                response.accountName =  accList[0].Name;
                res.statusCode = 200; 
            }
        }  

        return response;
    }

    global class AccountDetail {
        global Boolean success;
        global String message;
        global String accountId;
        global String accountName;
    }
}