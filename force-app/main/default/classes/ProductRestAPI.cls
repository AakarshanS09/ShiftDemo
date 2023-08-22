@RestResource(urlMapping='/products/*')
global with sharing class ProductRestAPI {
    @HttpGet
    global static ProductDetail getProducts() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String prdtId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

        //Map<string, string> paramsMap = RestContext.request.params;
        //string prdtId = paramsMap.get('Id');
        ProductDetail response = new ProductDetail();

        if (string.isBlank(prdtId)) {
            system.debug('prdtId == ' + prdtId);
            response.success = false;
            response.message = 'Product ID is required';
            res.statusCode = 400;
        } else {
            system.debug('prdtId == ' + prdtId);

            List<Product__c> prdtList = [SELECT Id, Name, Product_code__c FROM Product__c WHERE Id = :prdtId WITH SECURITY_ENFORCED];
            System.debug('prdtList==' + prdtList);
            //prdtList == null
            if (prdtList.isEmpty()) {
                response.success = false;
                response.message = 'There is no Product with the Id';
                res.statusCode = 400;
            } else {
                response.success = true;
                response.message = 'Product details retrieved successfully';
                response.productId = prdtList[0].Id;
                response.productName = prdtList[0].Name;
                response.productCode = prdtList[0].Product_code__c;
                res.statusCode = 200;
            }
        }

        return response;
    }

    @HttpDelete
    global static ProductDetail deleteProducts() {
        //create a new instance for product object
        List<Product__c> prod = new List<Product__c>();
        RestResponse res = RestContext.response;
        RestRequest req = RestContext.request;
        String prodId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

        //As params returns in Map<string, string> format and request the params
        //Map<string, string> paramsMap = RestContext.request.params;
        //It will get the Id passed from external system
        //string prodId = paramsMap.get('Id');
        ProductDetail response = new ProductDetail();
        //Query the product record
        prod = [SELECT Id, Name, Product_Code__c FROM Product__c WHERE Id = :prodId WITH SECURITY_ENFORCED];
        system.debug('prod==' + prod);
        if (string.isBlank(prodId)) {
            system.debug('prodId == ' + prodId);
            response.success = false;
            response.message = 'Product ID is required';
            res.statusCode = 400;
        } else {
            system.debug('prodId == ' + prodId);
            System.debug('prod ==' + prod);
            //prod == null
            if (prod.isEmpty()) {
                response.success = false;
                response.message = 'There is no Product with the Id';
                res.statusCode = 400;
            } else {
                //Delete the product from salesforce
                delete as user prod;
                response.success = true;
                response.message = 'Product deleted successfully';
                response.productId = prod[0].Id;
                response.productName = prod[0].Name;
                response.productCode = prod[0].Product_code__c;
                res.statusCode = 200;
            }
        }

        //return the String
        return response;
    }

    @HttpPost
    //Name and ProductCode will come from external system as a input
    global static ProductDetail createProducts(String Name, String ProductCode) {
        //Create an instance of products
        Product__c prod = new Product__c();
        ProductDetail response = new ProductDetail();
        //Map the input params to name and productCode
        prod.Name = Name;
        prod.Product_Code__c = ProductCode;

        if (string.isBlank(prod.Name)) {
            response.message = 'Product Name is required';
            response.success = false;
        } else {
            //insert the product
            insert prod;
            response.success = true;
            response.message = 'Product Inserted successfully';
            response.productId = prod.Id;
            response.productName = prod.Name;
            response.productCode = prod.Product_code__c;
        }

        //Return this product to the third party system as a response
        return response;
    }

    @HttpPatch
    //Name and ProductCode will come from external system as a input
    global static productDetail updateProducts(String Name, String ProductCode) {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        //String prdtRequestURI = req.requestURI;

        String prodId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

        //String requestBody = req.requestBody.toString();
        ProductDetail response = new ProductDetail();

        //As params returns in Map<string, string> format and request the params
        //Map<string, string> paramsMap = RestContext.request.params;
        //It will get the Id passed from external system
        //string prodId = paramsMap.get('Id');

        //Create an instance of products
        List<Product__c> prod = new List<Product__c>();

        //Map the input params to Id, name and productCode

        if (string.isBlank(prodId)) {
            system.debug('prodId == ' + prodId);
            response.message = 'Product ID is required';
            response.success = false;
        } else {
            prod = [SELECT Id, Name, Product_Code__c FROM Product__c WHERE Id = :prodId WITH SECURITY_ENFORCED];
            if (prod.isEmpty()) {
                response.message = 'There is no Product with the Id';
                response.success = false;
            } else {
                prod[0].Id = prodId;
                prod[0].Name = Name;
                prod[0].Product_Code__c = ProductCode;
                response.success = true;
                response.message = 'Product Updated succesfully';
                response.productId = prod[0].Id;
                response.productName = prod[0].Name;
                response.productCode = prod[0].Product_code__c;
                res.statusCode = 200;
            }
        }

        //update the product
        update prod;

        //Return this product to the third party system as a response
        return response;
    }

    global class ProductDetail {
        global Boolean success;
        global String message;
        global String productId;
        global String productName;
        global String productCode;
    }
}
