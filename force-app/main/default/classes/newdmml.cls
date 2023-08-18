public class newdmml {
    public void dmlmethod(){
        Account acc = [Select Name,Id,Phone From Account Where Name = 'Tech tros 2'];
        System.debug('Acc...'+acc);
        
        acc.phone = '444555';
        Update acc;
        
        Account Updateacc = [Select Name,Id,Phone From Account Where Name = 'Tech tros 2'];
        System.assertEquals(Updateacc, acc , 'not equal');
    }
}