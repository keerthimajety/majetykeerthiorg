trigger LeadTrigger on Lead (before insert,before update,after insert) {
    system.debug(Trigger.isBefore);
    system.debug(Trigger.isInsert);
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        system.debug('before update loop');
        for(Lead L:trigger.new)
        {
            system.debug(L.Status);
            if(L.Status =='Closed - Not Converted' && L.Description==null)
            {
                L.addError('Please enter the description if the lead is closed and not coverted');
            }
                
        }
    }
    if(Trigger.isBefore && Trigger.isInsert)
        
    {
        system.debug('inside before insert');
        for(Lead L:trigger.new)
        {
            if(l.Status =='Closed - Converted' || l.Status =='Closed - Not Converted')
                L.addError('Lead cannot be created with the status closed');
            if(L.AnnualRevenue > 200000)
            {
                L.Rating='Hot';
                system.debug('inside the condition');
            }
            
        }
    }
    if(trigger.isAfter && trigger.isAfter)
    {
        revision1.create_duplicate_lead(trigger.new);
    }
    
}