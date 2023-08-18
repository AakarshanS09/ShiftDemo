public class oppdesdemo {
    public static void oppomethod(){
        List<Opportunity> oppolist = 
            [Select Id,Name,StageName,Description From Opportunity Where CreatedDate = Last_Year ];
        
        if(!oppolist.IsEmpty()){
            for(Opportunity opp : oppolist){
                if(opp.StageName == 'Closed Won'){
                    opp.description ='opportunity is Closed Won';
                }else if(opp.Stagename == 'Closed Lost'){
                    opp.description = 'oppotunity is Closed Lost';
                }
            }
        }
        if(!oppolist.IsEmpty()){
            update oppolist;
        }
    } 
}