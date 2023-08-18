public class OppStageflow {
    public static void oppstmethod(){
        Map<String,object> params = new Map<String,object>();
        params.put('recordid','0065i000006xcC5AAI' );
        flow.Interview.Fetch_Opp_Stage fetchoppstage = new flow.Interview.Fetch_Opp_Stage(params);
        fetchoppstage.start();
        
        string returnvalue = (string) fetchoppstage.getVariableValue('oppstage');
        system.debug('Flow returned' + returnvalue);


    }

}