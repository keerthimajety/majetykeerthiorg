public class Batchapexday5 implements Database.Batchable<sObject>{
   list<lead> leadlist=new list<lead>();
    public database.QueryLocator start(Database.BatchableContext bc)
    {
        string query = 'Select id from Lead where CreatedDate = TODAY ';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc,list<lead> scope)
    {
        for(lead l:scope)
        {
            if(l.Status=='Open - Not Contacted')
                leadlist.add(l);
        }
        
    }
    public void finish(Database.BatchableContext bc)
    {
        system.debug('Batch is executed');
        system.debug('no of leads not contacted today = '+leadlist.size());
        integer noofleads=leadlist.size();
        //sending email 
        Messaging.SingleEmailMessage message=new  Messaging.SingleEmailMessage();
        message.toaddresses = new string[]{'keerthimajety@gmail.com'};
            message.subject='Batch status is completed';
            message.plaintextbody='no of leads not contacted today = '+noofleads;
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