public class CnctController {
    private string sortOrder = 'FirstName';
    public List<Contact> getContacts(){
        List<Contact> cncts = Database.query(
        'SELECT Id,FirstName,LastName,Email From Contact '
        + 'Order By '+ sortOrder +' ASC');
        return cncts;
    }
    public void sortByFirstName(){
        this.sortOrder = 'FirstName';
    }
    public void sortByLastName(){
        this.sortOrder = 'LastName';
    }

}