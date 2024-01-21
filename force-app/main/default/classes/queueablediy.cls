public class queueablediy implements Queueable{
    
    public void  execute(QueueableContext ctx)
    {
        list<contact> conlist=[Select Id, LastName from contact where CreatedDate = LAST_YEAR];
        system.debug(conlist);
        delete conlist;
        //chaining the job.THis queueable job deletes the accounts created in the last week
        system.enqueueJob(new queueablediy2());
    }

}