trigger AccountTrigger on Account (before insert,before delete,after update,after insert,before update) {
    
    switch on Trigger.operationType
    {
        when BEFORE_UPDATE
        {
            
            for(Account acc:trigger.new)
            {
                system.debug(acc.BillingStreet);
                
               if(trigger.oldMap.get(acc.Id).BillingStreet !=trigger.newMap.get(acc.Id).BillingStreet)
               {
                   system.debug('Inside the conditional loop of billing address');
                   if(acc.Address_Changed__c != null)
                   acc.Address_Changed__c=acc.Address_Changed__c+1;
                   else
                       acc.Address_Changed__c=1;
                   
                   if(acc.Address_Changed__c> decimal.valueof(Label.No_of_times_Address_can_be_changed_in_Account_object))
                       acc.addError('Addressfield cannot be changed more than 5 times');
               }  
            }
           
        }
        when  BEFORE_INSERT
        {
            
            for(Account a:trigger.new)
            {
                if(a.AnnualRevenue==null)
                    a.AnnualRevenue = 200000;
                a.Address_Changed__c=0;
            }
        }
        when  BEFORE_DELETE
        {
            revision1.acc_delete_validate(trigger.old);
           //do not allow the user to delete the account record if the the user is not loggedin user and if the active is active 
           Acchandler.delete_validate(trigger.old);
            User username=[SELECT   FirstName FROM User where FirstName ='keerthi' ];
            //Id profileId=userinfo.getProfileId();
           //String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
                if(username.Firstname !='keerthi')
                {
                    for(Account a:trigger.old)
                    {
                    system.debug('parent id present');
                    a.adderror('unable to delete the record');
                    }
                    
                }
            
        }
        
        when AFTER_INSERT
        {
            //trigger senarios no.21
            //when an account is created send an email to the systemadmin user
            revision1.email_systemadmin(trigger.new);
            //
            //when account is created with industry Banking the create a assosiated contact with last name = account name and phone number
            //is account phone number
            Apphandler.create_con(trigger.new);
            system.debug('in the after insert trigger');
            List<Contact> newcontactLst=new List<Contact>();
            integer i=0;
            for(Account a:trigger.new)
            {
                
                if(a.Number_of_Locations__c !=0)
                {
                    for(i=0;i<a.Number_of_Locations__c;i++)
                    {
                        Contact contactrec=new Contact(LastName='Rec'+i);
                        newcontactLst.add(contactrec);
                        
                    }
                }
            }
            insert newcontactLst;
            
            
            
        }
        when AFTER_UPDATE
        {
            revision1.uncheck_user_contacts(trigger.new,trigger.oldMap,trigger.newMap);
            
            //revision add team member in opportunity
            revision1.update_opp_teamowner(trigger.new,trigger.oldMap,trigger.newMap);
            
            //rev 24 when acc owner is changed change the contact owner also
           revision1.change_contact_owner(trigger.new,trigger.oldMap,trigger.newMap);
            //when the account is inactive all the cases should be closed
            Acchandler.acc_closecases(trigger.new,trigger.oldmap,trigger.newmap);
           //when account is updated ,all assosiated opportunities stage should be changed to closedWon
           
            //Apphandler.update_opp(trigger.new);//commented on nov 30
            
            //when the account owner is changed then the assosiated contact owner is also changed.
            Map<Id,Account> oldaccmap = trigger.oldmap;
            Map<Id,Account> newAccmap = trigger.newmap;
            set<Id> idset = new set<id>();
            for(Account a:trigger.new)
            {
                Idset.add(a.Id);
            }
            //querying the contact list which are assosiated with the updated accounts.
           list<contact> conlist=[Select Id,AccountId,OwnerId from Contact where AccountId IN :idset];
            for(contact c:conlist)
            {
                //checking wether the owner field in account in updated or not.
                //If updated to new owner then the related contacts owner also changed.
              if(oldaccmap.get(c.AccountId).OwnerId != newAccmap.get(c.AccountId).OwnerId) 
              {
                c.OwnerId =  newAccmap.get(c.AccountId).OwnerId;
                  
              }
            }
            update conlist;
            
           
            
        }
    }
    
    
    
}