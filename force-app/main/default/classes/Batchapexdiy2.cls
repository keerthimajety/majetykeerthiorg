public class Batchapexdiy2 implements Database.Batchable<sObject> {

    public database.QueryLocator start(database.BatchableContext bc)
    {
        
        
        string query ='SELECT Id, Status, CreatedDate FROM Lead where CreatedDate =LAST_N_MONTHS:6 AND Status=\'Working - Contacted\'';
        system.debug('inside start');
        return Database.getQueryLocator(query);
        
        
    }
    public void execute(Database.BatchableContext bc,list<Lead> scope)
    {
        system.debug(scope.size());
        for(Lead l:scope)
        {
            l.Status = 'Closed - Not Converted';
        }
        update scope;
    }
    public void finish(database.BatchableContext bc)
    {
        system.debug('lead status updated ');
    }
}