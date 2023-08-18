@isTest
public class PostmanTest {
    @testSetup public static void setup() {
        // Create common test accounts
        List<Account> acc = new List<Account>();
        List<Contact> conList = new List<Contact>();
        for(Integer i=0;i<5;i++) {
            acc.add(new Account(Name = 'TestAcc'+i));
        }
        insert acc;  
        for(Account acclist : acc){
            Contact con = new Contact();
            con.LastName = acclist.name;
            con.AccountId = acclist.Id;
            conlist.add(con);
        }
        insert conlist;
    }

 

    @isTest
    static void testGetAccountDetails_Success() {


        RestRequest request = new RestRequest();
         Account acct = [SELECT Id,Name FROM Account WHERE Name='TestAcc0'];
        
        system.debug('acct== ' + acct );
        request.requestURI = '/services/apexrest/accountDetails/' +  acct.Id;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        AccountDetails_RestApi.AccountDetail response = AccountDetails_RestApi.getAccountDetails();

        System.assertEquals(true, response.success);
        System.assertEquals('Account details retrieved successfully', response.message);
        System.assertEquals(acct.Id, response.accountId);
        System.assertEquals(acct.Name, response.accountName);
        System.assertEquals(200, RestContext.response.statusCode);

}
    
    
    @isTest
    static void testGetAccountDetails_Wrong() {


        RestRequest request = new RestRequest();
         Contact conct = [SELECT Id,LastName FROM Contact WHERE LastName='TestAcc0'];
        Id ids = '0035i000009tPW5AAM';
        system.debug('conct== ' + conct );
        request.requestURI = '/services/apexrest/accountDetails/' + ids /*conct.Id*/;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        AccountDetails_RestApi.AccountDetail response = AccountDetails_RestApi.getAccountDetails();

        System.assertEquals(false, response.success);
        System.assertEquals('There is no account with the Id', response.message);
        System.assertEquals(400, RestContext.response.statusCode);

}
    @isTest
    static void testGetAccountDetails_Missing() {


        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/accountDetails/' ;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        AccountDetails_RestApi.AccountDetail response = AccountDetails_RestApi.getAccountDetails();

        System.assertEquals(false, response.success);
        System.assertEquals('Account ID is required', response.message);
        System.assertEquals(400, RestContext.response.statusCode);

}
    
}