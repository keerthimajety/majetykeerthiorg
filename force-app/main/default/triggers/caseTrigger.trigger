trigger caseTrigger on Case (before insert,after update) {
    
    //system.debug('entered inside trigger');
    if(trigger.isBefore && trigger.isInsert)
    {
        revision1.case_field_set(trigger.new);
    }  
    if(trigger.isAfter && trigger.isUpdate)
    {
        revision1.save_case_close(trigger.new,trigger.oldMap,trigger.newMap);
    }
}