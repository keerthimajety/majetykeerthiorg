/***********************************************************************
Name        casestudy2 in Asynchronous apex (Batch apex)
author      keerthi
date        23-2-2023
Description Run a batch checking for the zone number in the store matching the zone and maping it to the store.
*************************************************************************/
public class batchapexcasestudy2 implements Database.Batchable<sObject> , DataBase.Stateful{
    Map<String,Zone__c> zoneMaplist=new Map<String,Zone__C>();
    list<zone__c> newzonerec =new list<zone__c>();
    list<store__c> storelist =new list<store__c>();
    list<Zone__C> zonelist=[Select Id,Name from zone__c];
    integer count=0;
    public database.QueryLocator start(Database.BatchableContext bc)
    
    {  
        
        for(Zone__C z:zonelist)
        {
            zoneMaplist.put(z.Name,z);
        }
        system.debug(zoneMaplist);
        return Database.getQueryLocator('Select id,Name ,Zone_Code__c,Zone2__c from store__c');
    }
    public void execute(Database.BatchableContext bc,list<store__c> scope)
    {  
        system.debug('scopesize'+scope.size());
           for(Store__c s:scope)
           {
                              
             if(zoneMaplist.containsKey(s.Zone_Code__c))  //if already zone code matches the existing zones map the zone with store
             {
                // system.debug('in if looop');
                 s.Zone2__c=(Id)ZoneMaplist.get(s.Zone_Code__c).Id;
                 //system.debug(s.Zone__c);
             }
               else       //creating new zone for the zone code
               {
                  // system.debug('in else loop');
                   zone__c zonesinglerec =new zone__c(Zone_Name__c=s.Zone_Code__C);
                   storelist.add(s);
                   if(!newzonerec.contains(zonesinglerec))
                   newzonerec.add(zonesinglerec);
               } 
           }
        insert newzonerec;
        update scope;
        system.debug(scope);
        system.debug('zone'+newzonerec);
            
       
    }
    public void Finish(Database.BatchableContext bc)
    {
        system.debug(count);
        Map<String,Zone__c> zoneMapnewlist=new Map<String,Zone__C>();
         list<Zone__C> zonelist=[Select Id,Name from zone__c];
        for(Zone__C z:zonelist)
        {
            zoneMaplist.put(z.Name,z);
        }
        for(store__c s:storelist)
        {
            s.Zone2__c = zoneMapnewlist.get(s.Zone_Code__C).id;
        }
        update storelist;
        system.debug('batch executed');
        
    }
}