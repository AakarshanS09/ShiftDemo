public class Oppstageflo {
    public Static void OppStagemethod(){
        Map<String,Object> params = new Map<String,Object>();
params.put('recordid','0065i000006xcC5AAI');
flow.Interview.Fetch_Opp_Stage Fos = new flow.Interview.Fetch_Opp_Stage(params);
Fos.start();

String returnval = (String) Fos.getVariableValue('oppstage');
System.debug('Flow returned...' + returnval);
    } 

}