public class FlowAccountAmount {
    @InvocableMethod
    public Static List<Decimal> updateAccountRevenue(List<ID> ids){
        
        List<Decimal> annualRevenuelist = new  List<Decimal>();
        
        List<Opportunity> opplist = [SELECT AccountId, Amount From Opportunity WHERE Id =: ids[0]];
        
        List<Account> acclist =[SELECT AnnualRevenue From Account WHERE Id = :oppList[0].accountId];
        
        acclist[0].AnnualRevenue = acclist[0].AnnualRevenue + opplist[0].Amount;
        
        update acclist;
        
        annualRevenuelist.add(acclist[0].AnnualRevenue);
        return annualRevenuelist;
    }
}