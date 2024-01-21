public class utililty {
    
    @future
     public static void acc_contactcount_update(string jsonstring){
         
         
        list<Contact> contactlst = (list<Contact>)json.deserialize(jsonString, list<contact>.class);

        list<Id>  accidlst = new list<id>();
            list<Account> updatedacclst=new list<Account>();
            for(Contact c:contactlst)
            {
                if(c.AccountId !=null)
                {
                accidlst.add(c.AccountId);
                }
            }
           list<AggregateResult> countrec=[Select Count(Id) countrec,AccountId from Contact where AccountId IN :accidlst group by AccountId] ;
            for(AggregateResult a :countrec)
            {
               
                Account singlerec =new Account(Id=(Id)a.get('AccountId'));
                system.debug(a.get('countrec'));
                singlerec.count_of_contacts__c= (decimal)a.get('countrec');
                updatedacclst.add(singlerec);
            }
        if(updatedacclst.size()>0)
        {
            update updatedacclst;
        }
        system.debug('system.limits.getFutureCalls()   ='+system.limits.getFutureCalls());
        system.debug('system.limits.getLimitFutureCalls()'+system.limits.getLimitFutureCalls());
    }

    //functio to send email to the user.User as perameter
    public static void email_user(string emailid)
    {
        
        system.debug('entered the method');
       Messaging.SingleEmailMessage message=new  Messaging.SingleEmailMessage();
        message.toaddresses = new string[]{emailid};
            message.subject='Batch status is completed';
            message.plaintextbody='Batch status is completed';
        list<Messaging.SingleEmailMessage> messageslist=new list<Messaging.SingleEmailMessage>{message};
            
          Messaging.SendEmailResult[] results =Messaging.sendEmail(messageslist);
          system.debug(messageslist);
        system.debug('results= '+results);
        if(results[0].success)
            system.debug('emailsent');
        else
            system.debug('unable to send email');
    }
  


}