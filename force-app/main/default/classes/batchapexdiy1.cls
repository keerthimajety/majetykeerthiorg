public class batchapexdiy1 implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(DataBase.BatchableContext bc)
    {
        string query= 'Select Id,FirstName from Contact LIMIT 40';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc,list<contact> scope)
    {
        system.debug('each batch size = '+scope.size());
        for(contact c:scope)
        {
            if(c.FirstName==null)
            c.FirstName ='Batch Test';
        }
        update scope;
    }
    public void finish(DataBase.BatchableContext bc)
    {
        system.debug('jobID ='+ bc.getJobId());
       AsyncApexJob job=[SELECT CreatedById, Status, Id FROM AsyncApexJob where id= :bc.getJobId()] ;
        system.debug('apex jobs '+ job);
       // Map<Id,User> user_data=new Map<Id,User>([SELECT Id, Name, Email FROM User where id =:job.CreatedById]);
       User user_data=[SELECT Id, Name, Email FROM User where id =:job.CreatedById];
        system.debug(user_data.Email);
        //send email method from utility class ..sending email to the job created user
        
        utililty.email_user((string)user_data.Email);
    }
}