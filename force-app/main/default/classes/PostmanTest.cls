@isTest
public class PostmanTest {
    @testSetup
    public static void setup() {
        // Create common test accounts
        List<Account> acc = new List<Account>();
        List<Contact> conList = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            acc.add(new Account(Name = 'TestAcc' + i));
        }
        insert acc;
        for (Account acclist : acc) {
            Contact con = new Contact();
            con.LastName = acclist.name;
            con.AccountId = acclist.Id;
            conlist.add(con);
        }
        insert conlist;
    }

    @isTest
    static void getAccountDetailsSuccess() {
        RestRequest request = new RestRequest();
        Account acct = [SELECT Id, Name FROM Account WHERE Name = 'TestAcc0'];

        system.debug('acct== ' + acct);
        request.requestURI = '/services/apexrest/accountDetails/' + acct.Id;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        AccountDetails_RestApi.AccountDetail response = AccountDetails_RestApi.getAccountDetails();

        System.assertEquals(true, response.success, 'checks wheather succcess or not');
        System.assertEquals('Account details retrieved successfully', response.message, 'What is the message delivered');
        System.assertEquals(acct.Id, response.accountId, 'Records Id');
        System.assertEquals(acct.Name, response.accountName, 'Records Name');
        System.assertEquals(200, RestContext.response.statusCode, 'Status of the process');
    }

    @isTest
    static void getAccountDetailsWrong() {
        RestRequest request = new RestRequest();
        Contact conct = [SELECT Id, LastName FROM Contact WHERE LastName = 'TestAcc0'];
        //Id ids = '0035i000009tPW5AAM';
        system.debug('conct== ' + conct);
        request.requestURI = '/services/apexrest/accountDetails/' + conct.Id;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        AccountDetails_RestApi.AccountDetail response = AccountDetails_RestApi.getAccountDetails();

        System.assertEquals(false, response.success, 'checks wheather succcess or not');
        System.assertEquals('There is no account with the Id', response.message, 'Expected Message');
        System.assertEquals(400, RestContext.response.statusCode, 'Status Code');
    }
    @isTest
    static void getAccountDetailsMissing() {
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/accountDetails/';
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        AccountDetails_RestApi.AccountDetail response = AccountDetails_RestApi.getAccountDetails();

        System.assertEquals(false, response.success, 'checks wheather succcess or not');
        System.assertEquals('Account ID is required', response.message, 'Expected Message');
        System.assertEquals(400, RestContext.response.statusCode, 'status code');
    }
}
