//when we create a customerproject with 'active' status the Active customer project field in opportunity detail page should be 
//automatically checked.
//case study 4 triggers
trigger Customerprotrigger on Customer_Project__c (after insert) {
    
    
  customerprotriggerhandler.Activefldchk(trigger.new);
    
}