/*
@description: Inherits interface class  and invokes methods in handler. Logic to call methods in handler class based on the trigger instance.
Anything used here should be declared in Interface class. Method names should match with method name in handler class.
*/
public class TriggerDispatcher {
    
    /*
    @description : Call this method from your trigger, passing in an instance of a trigger handler which implements TriggerHandlerInterface.
    This method will fire the appropriate methods on the handler depending on the trigger context.
    @inputs : handler class
    */
    public static void run(TriggerHandlerInterface handler) {
        
        
        try{

            // Using switch and enum to avoid cyclomatic(using multi level if-else conditions) complexity.
            switch on Trigger.operationType {
                // Trigger operation enum values are used to define trigger insatance.
                when BEFORE_INSERT{
                    handler.beforeInsert(trigger.new);
                }
                when BEFORE_UPDATE{
                    handler.beforeUpdate(trigger.newMap, trigger.oldMap);
                }
                when BEFORE_DELETE{
                    handler.beforeDelete(trigger.oldMap);
                }
                when AFTER_INSERT{
                    handler.afterInsert(Trigger.newMap);
                }
                when AFTER_UPDATE{
                    handler.afterUpdate(trigger.newMap, trigger.oldMap);
                }
                when AFTER_DELETE{
                    handler.afterDelete(trigger.oldMap);
                }
                when AFTER_UNDELETE{
                    handler.afterUndelete(trigger.oldMap);
                }
            }

            
        }catch(exception ex){
            System.debug('Message'+ex.getMessage());
            System.debug('Stack'+ex.getStacktracestring());
            
        }
    }
}