public class Pdfcontroller {
public Pdfcontroller(ApexPages.StandardController controller) {
Account acc = (Account)controller.getRecord();
String accPhn = acc.Phone;
//Assign "Account_[Ac].pdf" as a file name
String fileName = 'Account_' + accPhn + '.pdf';
Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=' + fileName);}
}