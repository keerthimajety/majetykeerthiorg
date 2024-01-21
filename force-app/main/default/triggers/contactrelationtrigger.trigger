//case study 6.2
//when the owner in the record changed then the new owner will be updated in Contact relation ship name.

trigger contactrelationtrigger on Contact_Relationship__c (after update) {
    
    contactrelationtriggerservice.CRName_update(trigger.oldmap,trigger.new);
    
    

}