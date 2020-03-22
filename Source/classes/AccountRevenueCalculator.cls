public class AccountRevenueCalculator {
    public static void AnnualRevenueRollUpUpdate(Map<Id,SObject> newSObjectMap,Map<Id,SObject> oldSObjectMap){
        Map<Id,Account> newAccountMap = (Map<Id,Account>)newSObjectMap;
        Map<Id,Account>  oldAccountMap = (Map<Id,Account>)oldSObjectMap;
        
        List<Account> newAccountList = newAccountMap.values();
        List<Account> oldAccountList = oldAccountMap.values();
        
        List<account> finalAccountList =new list<account>();
        set<id> parentAccId=new set<id>();   
        for(Account acc: newAccountList){
            parentAccId.add(acc.parentId);           
            if(acc.parentId != oldAccountMap.get(acc.id).parentId){
                parentAccId.add(oldAccountMap.get(acc.id).parentId);                
            }
        }
        List<AggregateResult> AggResultList = [select parentId,sum(annualrevenue) AnnualRev from account 
                                               where parentid=:parentAccId AND parentId!= null group by parentid];
        
        if(!AggResultList.isEmpty()){
            for(AggregateResult ar: AggResultList ){
                Account a =new Account(id=(id)ar.get('parentid'),annualrevenue=(Double)ar.get('AnnualRev'));
                finalAccountList.add(a);
            }
        }
        
        if(!finalAccountList.isEmpty()){            
            update finalAccountList;
        }
    }
    
    public static void AnnualRevenueRollUpInsert(Map<Id,SObject> newSObjectMap){
        Map<Id,Account> newAccountMap = (Map<Id,Account>)newSObjectMap;        
        List<Account> newAccountList = newAccountMap.values();
        List<account> finalAccountList =new list<account>();
        set<id> parentAccId=new set<id>();   
        for(Account acc: newAccountList){
            parentAccId.add(acc.parentId);
        }
        List<AggregateResult> AggResultList = [select parentId,sum(annualrevenue) AnnualRev from account 
                                               where parentid=:parentAccId AND parentId!= null group by parentid];
        
        if(!AggResultList.isEmpty()){
            for(AggregateResult ar: AggResultList ){
                Account a =new Account(id=(id)ar.get('parentid'),annualrevenue=(Double)ar.get('AnnualRev'));
                finalAccountList.add(a);
            }
        }
        
        if(!finalAccountList.isEmpty()){            
            update finalAccountList;
        }
    }
}