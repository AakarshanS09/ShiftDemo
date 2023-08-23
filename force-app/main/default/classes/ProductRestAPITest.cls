@isTest
public class ProductRestAPITest {
    @testSetup
    public static void setup() {
        List<Product__c> prdtList = new List<Product__c>();
        for (Integer i = 0; i < 5; i++) {
            Product__c prdt = new Product__c();
            prdt.name = 'Test ' + i;
            prdt.Product_code__c = 'abc-00' + i;
            prdtList.add(prdt);
        }
        insert prdtList;
    }

    @isTest
    static void testProductDetailsSuccess() {
        RestRequest request = new RestRequest();
        Product__c pdt = [SELECT Id, Name FROM Product__c WHERE Name = 'Test 0'];

        system.debug('pdt== ' + pdt);
        //ID ids = 'a0F5i00000HpbdJEAR';
        request.requestURI = '/services/apexrest/products/' + pdt.id;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.getProducts();

        System.assertEquals(true, response.success, 'Result of the process');
        System.assertEquals('Product details retrieved successfully', response.message, 'product  details message');
        System.assertEquals(pdt.Id, response.productId, 'Records ID');
        System.assertEquals(pdt.Name, response.productName, 'Name of the Record');
        System.assertEquals(200, RestContext.response.statusCode, 'Status Code');
    }

    @isTest
    static void testGetProducttDetailsWrong() {
        RestRequest request = new RestRequest();

        //Id ids = '0035i000009tPW5AAM';

        request.requestURI = '/services/apexrest/products/' + system.label.DemoId;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.getProducts();

        System.assertEquals(false, response.success, 'Result of the process');
        System.assertEquals('There is no Product with the Id', response.message, 'The product message');
        //System.assertEquals(400, RestContext.response.statusCode);
    }
    @isTest
    static void testGetProducttDetailsMissing() {
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/accountDetails/';
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.getProducts();

        System.assertEquals(false, response.success, 'Result of the process');
        System.assertEquals('Product ID is required', response.message, 'The product message');
        // System.assertEquals(400, RestContext.response.statusCode);
    }

    @isTest
    static void testProductDelete() {
        RestRequest request = new RestRequest();
        Product__c pdt = [SELECT Id, Name FROM Product__c WHERE Name = 'Test 0'];

        system.debug('pdt== ' + pdt);
        //ID ids = 'a0F5i00000HpbdJEAR';
        request.requestURI = '/services/apexrest/products/' + pdt.id;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.deleteProducts();

        System.assertEquals(true, response.success, 'Result of the process');
        System.assertEquals('Product deleted successfully', response.message, 'The product message');
        System.assertEquals(pdt.Id, response.productId, 'Product Record Id');
        System.assertEquals(pdt.Name, response.productName, 'Product Record Name');
    }

    @isTest
    static void testPrdtDeleteDetailsMissing() {
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/accountDetails/';
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.deleteProducts();

        System.assertEquals(false, response.success, 'Result of the process');
        System.assertEquals('Product ID is required', response.message, 'The product message');
        // System.assertEquals(400, RestContext.response.statusCode);
    }

    @isTest
    static void testPrdtDeleteDetailsWrong() {
        RestRequest request = new RestRequest();

        //Id ids = '0035i000009tPW5AAM';

        request.requestURI = '/services/apexrest/products/' + system.label.DemoId;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.deleteProducts();

        System.assertEquals(false, response.success, 'Result of the process');
        System.assertEquals('There is no Product with the Id', response.message, 'The Product meaasage');
        //System.assertEquals(400, RestContext.response.statusCode);
    }

    @isTest
    static void testProductInsert() {
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/accountDetails/';
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.createProducts('Test 0', 'abc-000');

        System.assertEquals(true, response.success, 'Result of the process');
        System.assertEquals('Product Inserted successfully', response.message, 'The product message');
    }

    @isTest
    static void testPrdtNameMiss() {
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/accountDetails/';
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.createProducts(null, 'abc-000');

        System.assertEquals(false, response.success, 'Result of the process');
        System.assertEquals('Product Name is required', response.message, 'The product message');
    }

    @isTest
    static void testProductUpdate() {
        RestRequest request = new RestRequest();
        Product__c pdt = [SELECT Id, Name FROM Product__c WHERE Name = 'Test 0'];

        request.requestURI = '/services/apexrest/products/' + pdt.id;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.updateProducts('Test 0', 'abc-001');

        System.assertEquals(true, response.success, 'Result of the process');
        System.assertEquals('Product Updated successfully', response.message, 'The product message');
        System.assertEquals(pdt.Id, response.productId, 'Product Record Id');
        System.assertEquals(pdt.Name, response.productName, 'Product Record Name');
        //System.assertEquals(200, RestContext.response.statusCode);
    }

    @isTest
    static void testPrdtUpdateteDetailsMissing() {
        RestRequest request = new RestRequest();
        request.requestURI = '/services/apexrest/accountDetails/';
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.updateProducts('Test 0', 'abc-000');

        System.assertEquals(false, response.success, 'Result of the process');
        System.assertEquals('Product ID is required', response.message, 'The product message');
        // System.assertEquals(400, RestContext.response.statusCode);
    }

    @isTest
    static void testPrdtUPdateDetailsWrong() {
        RestRequest request = new RestRequest();

        //Id ids = '0035i000009tPW5AAM';

        request.requestURI = '/services/apexrest/products/' + system.label.DemoId;
        RestContext.request = request;

        RestResponse responseMock = new RestResponse();
        RestContext.response = responseMock;

        ProductRestAPI.ProductDetail response = ProductRestAPI.updateProducts('Test 0', 'abc-000');

        System.assertEquals(false, response.success, 'Result of the process');
        System.assertEquals('There is no Product with the Id', response.message, 'The product message');
        //System.assertEquals(400, RestContext.response.statusCode);
    }
}
