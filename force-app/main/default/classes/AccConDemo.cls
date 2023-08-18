public class AccConDemo {
    public void accmethod(){
        for(Account acc : [Select Name,Phone,(Select FirstName,LastName,Phone 
                           From Contacts) From Account 
                           Where Name = 'Tech tros 2']){
                               
                  System.debug('Contact details...'+ acc.Contacts);
                               
        for(Contact C : acc.Contacts){
                 System.debug('Contact First Name..'+ c.FirstName);   
                 System.debug('Contact Last Name..'+ c.LastName);
                               }                       
                           }
      
    }
}