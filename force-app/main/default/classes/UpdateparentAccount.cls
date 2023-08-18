public class UpdateparentAccount implements Queueable {
    
    private List<Account> acclist;
    private id parentAccId;
    
    public UpdateparentAccount(List<Account> accRecords, Id id){
        this.acclist = accRecords;
        this.parentAccId = id;
    }
    
    public void execute(QueueableContext context){
        for(Account acc : acclist){
            acc.ParentId = parentAccId;
        }
        
        update acclist; 
    }

}