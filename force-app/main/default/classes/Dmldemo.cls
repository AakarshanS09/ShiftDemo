public class Dmldemo {
    public void dmlmethod(){
        List<Contact> conclist = new List<Contact>{
            new Contact(FirstName = 'Shardul',LastName = 'Singh'),
            new Contact(FirstName = 'Prithvi', LastName = 'Shaw'),
            new Contact() };
                
                Database.SaveResult[ ]  srlist = Database.insert(conclist,false);
        
        for(Database.SaveResult sr : srlist){
            if(sr.isSuccess()){
                system.debug('Sucesfully inserted contact.Contact Id : ' + sr.getId());
            }else{
                for(Database.Error err : sr.getErrors()){
                    system.debug('The following error has occured:');
                    system.debug(err.getStatusCode()+':'+err.getMessage());
                    System.debug('Contact fields that affected this error:'+err.getFields());
                }
            }
        }
         
    }

}