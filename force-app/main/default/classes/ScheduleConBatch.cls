public class ScheduleConBatch implements schedulable {
    
    public void execute(SchedulableContext sc){
        
        ContactBatch conProcess = new ContactBatch();
        Database.executeBatch(conProcess);
    }

}