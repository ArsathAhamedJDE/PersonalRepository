public class AccountTriggerHandler implements TriggerHandlerInterface{
    
    
    
    /*
    @description: All before DML insert logics are handled.
    @inputs : List of records
    @output : NA.
    */
    public void beforeInsert(List<Account> newItems) {
        
    }
    
    public void beforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
       
    }
    
    // Commeting the beforeDelete handler, as there is no dependent functionality and not in scope for Phase 1.
    public void beforeDelete(Map<Id, SObject> oldItems) {}
    
    public void afterInsert(Map<Id, SObject> newItems) {
         AccountRevenueCalculator.AnnualRevenueRollUpInsert(newItems);           
     }
    
    public void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        AccountRevenueCalculator.AnnualRevenueRollUpUpdate(newItems, oldItems);          
    }
    
    // Commeting the afterDelete,afterUndelete handler, as there is no dependent functionality and not in scope for Phase 1.
    public void afterDelete(Map<Id, SObject> oldItems) {}
    
    public void afterUndelete(Map<Id, SObject> oldItems) {}
    
}