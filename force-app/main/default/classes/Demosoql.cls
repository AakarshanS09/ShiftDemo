public class Demosoql {
     public void demomethod(){
         List<City__c> citc = new List<City__c>();
         citc = [Select Name,Total_Amount__c,State__r.Name,
                 State__r.Total_Amount_from_Cities__c From City__c
                  Where Name = 'Chennai'];
         System.debug('citc..'+ citc  );
         if(!citc.IsEmpty())
             for (City__c C : citc){
                 System.debug('State Name...'+C.State__r.Name);
                 system.debug('Total Amount from Cities'+ C.State__r.Total_Amount_from_Cities__c);
             }
     }

}