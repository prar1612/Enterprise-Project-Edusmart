trigger ApplicationTrigger on Lead (after update,after insert) {
    if(trigger.isUpdate) {
        ApplicationTriggerHandler.convertToStudent(trigger.oldMap,trigger.newMap);
    }
    else if(trigger.isInsert){
        ApplicationTriggerHandler.assignToEvaluator(trigger.newMap);
    }
   

}