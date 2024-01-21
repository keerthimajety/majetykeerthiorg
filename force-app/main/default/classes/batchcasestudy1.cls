public class batchcasestudy1 implements Database.Batchable<sObject> {

    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator('Select id ,OwnerId from lead where Days_since_last_activity__c > 1 ');
    }
    /*where Days_since_last_activity__c>5*/
    public void execute(Database.BatchableContext bc,list<Lead> scope)
    {
        list<Task> tasklisttoupdate =new list<Task>();
        Map<Id,User> userlist = new Map<Id,User>([Select id,ManagerId ,Name from User ]);
        system.debug('list size'+scope.size());
       for(lead l:scope)
       {
           system.debug(l.OwnerId);
           l.OwnerId = userlist.get(l.OwnerId).ManagerId;
           system.debug(l.OwnerId);
           //create a task
           Task onetask =new Task();
           onetask.WhatId = l.Id;
           onetask.WhoId = l.OwnerId;
           onetask.Subject = 'not active';
           onetask.Description='this lead is not active from last 5 days';
           tasklisttoupdate.add(onetask);
           
           
       }
        //
        update scope;
        //inserting task to the concerd leadowners.
        insert tasklisttoupdate;
        system.debug(scope);
    }
    public void finish(Database.BatchableContext bc)
    {   
        
        system.debug('batch completed');
    }
}