public class DEmoWrapper {
    public static AccountWrapper demoWrapperMethod(string accountName){
        List<account>acclist=[Select Id,Name,(Select Name From Opportunities),
                              (Select LastName From Contacts),(Select Id From Cases) From Account WHERE name=:accountName];
        AccountWrapper curlWrapper = new AccountWrapper();
        curlWrapper.conlist = acclist[0].Contacts;
        curlWrapper.oppList = acclist[0].Opportunities;
        curlWrapper.casList = acclist[0].Cases;
        return curlWrapper;
    }
    public class AccountWrapper{
        list<contact>conlist;
        list<opportunity>oppList;
        list<case>casList;
    }
}