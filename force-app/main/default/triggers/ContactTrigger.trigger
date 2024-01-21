//casestudy 2 in triggers
//
trigger ContactTrigger on Contact(before insert,after insert,after delete,before update) {
    
 system.debug('inside trigger')   ;
 system.debug(Trigger.operationType);
    switch on Trigger.operationType
    {
        when BEFORE_INSERT
        {
            revision1.enter_phone_contact(trigger.new);
             //when an account has more 10 contacts we should restrict it from adding more
            set<id> idset=new set<id>();
            for(contact con:trigger.new)
            {
                if(con.AccountId !=null)
               idset.add(con.AccountId);
            }
            Map<Id,Account> acclistwithcontacts=new Map<Id,Account>([Select Id,Name ,(Select Id,Name from Contacts) from Account where Id IN :idset]);
            for(Contact c:trigger.new)
            {
                if(c.AccountId !=null)
                {
                     if(acclistwithcontacts.get(c.AccountId).Contacts.size()>=11)
                    c.adderror('you cannot add more than 10 contacts in each account');
                }
               
            }
        }
        when BEFORE_UPDATE
        {
             //If contact status field is changed to inactive , Check for related opps and if its status is closed won and 
    //recurring field is true, do no allow the contact to change to inactive.
          Contacttriggerhandler.con_update_validate(trigger.new,trigger.oldmap,trigger.newmap)  ;
        }
        when AFTER_INSERT
        { 
           
            //update the no of contacts in account
            /*Contacttriggerhandler.acc_contactcount_update(trigger.new);*/
            //when the contact relationship checkbox is checked the contactrelation ship is automatically created.
            Contacttriggerhandler.ContactRelation_create(trigger.new);
            //update the no of contacts in account future method by passing the context variable as the parameter.
            string jsonstring=Json.serialize(trigger.New);
            utililty.acc_contactcount_update(jsonstring);
            Contacttriggerhandler.create_account(trigger.new);
        }
           
        when AFTER_DELETE
        {
           
            
            Contacttriggerhandler.acc_contactdelete_update(trigger.old);
            //when contact is deleted the contact relationship object also should get deleted.
            Contacttriggerhandler.CRdelete(trigger.old);
            
            
            
        }
       
            
    }
   
}