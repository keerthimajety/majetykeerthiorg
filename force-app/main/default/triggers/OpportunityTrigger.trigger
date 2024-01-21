trigger OpportunityTrigger on Opportunity (after insert,after update,after delete,before insert) {
    
    switch on trigger.operationtype
    {
        when BEFORE_INSERT
        {
            opphandler.validateInsert(trigger.new);
        }
        when AFTER_INSERT
        {
             //Update the highest amount in the opportunity to Accounts Field.
            revision1.update_highestamt_opp(trigger.new);
            //enable the active field in account to yes if an opp is created
            //opphandler.enable_active(trigger.new);
            system.debug('trigger inside');
            
            
/*            Id currentid;
    list<Account> accrec = new list<Account>();
    list<id> idlist =new list<Id>();
            for(Opportunity o:trigger.new)
            {
                idlist.add(o.AccountId);
            }
          Map<Id,decimal>  maxamountmap =new  Map<Id,decimal>();   
         list<AggregateResult>  maxvalue = [Select Max(Amount),AccountId  from Opportunity where Accountid IN :idlist Group by AccountId];
         decimal max_amount;
   		 for(AggregateResult a:maxvalue)
   			 {
  				  
   				  max_amount = (decimal)(a.get('expr0')); 
                 currentid =(Id) a.get('AccountId');
                  system.debug(currentid);
    			  Account acc=new Account(Id=currentid,opportunity_max_value__c=max_amount);
                  accrec.add(acc);
    
   			 }
        
       
   // update accrec;
  */

        }
        when AFTER_UPDATE
        { 
            //diy 56 apex tamil triggers
             //Update the highest amount in the opportunity to Accounts Field.
            revision1.update_highestamt_opp(trigger.new);
            opphandler.create_task(trigger.new,trigger.oldmap,trigger.newmap);
            //day 53 tamil apex triggers
    //If opportunity changed to negotiation the update all the count of opp in the account object.
            opphandler.opp_count_update(trigger.new,trigger.oldmap,trigger.newmap);
            
             //if the user updates the quantity custum field in opportunity then update all quantities in the opportunity line items should be same
            opphandler.update_quantity_Lineitems(trigger.new,trigger.oldMap,trigger.newMap);
            //when a stage is changed to closed won enable active
            opphandler.active_edit(trigger.new,trigger.oldMap,trigger.newMap);
            
            //when the opportunity closed won create a task for the salesrep to follow up the opportunity
             opphandler.create_task_salesrep(trigger.new,trigger.oldmap,trigger.newmap)  ;
            
            
            Map<Id,Opportunity> oppoldrec=trigger.oldmap;
            Map<Id,Opportunity> oppnewrec=trigger.newmap;
            list<Id> idlist=new list<Id>();
            Map<Id,Opportunity> accoppmap=new Map<Id,Opportunity>();
            for(opportunity o:trigger.new)
            {
                if(oppoldrec.get(o.Id).client_contact__c != oppnewrec.get(o.Id).client_contact__c)
                {
               idlist.add(o.AccountId) ;
                accoppmap.put(o.AccountId,o);
                }
            }
            list<Account> acclist=[Select Id,client_contact__c from account where Id IN :idlist];
            for(account a:acclist)
            {
               a.client_contact__c = accoppmap.get(a.Id).client_contact__c;
            }
            update acclist;
                
            }
         when AFTER_DELETE
     {
         opphandler.opp_acc_delete(trigger.old);
     }
    
        }
    
    
    
}