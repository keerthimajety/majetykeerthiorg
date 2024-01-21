/***********************************************************************
Name        casestudy2b in Asynchronous apex (Batch apex)
author      keerthi
date        23-2-2023
Description Run a batch checking for the market number in the store matching the Market and maping it to the store.
*************************************************************************/
public class batchapexcasestudy2b implements Database.Batchable<sObject> , DataBase.Stateful{
    Map<String,Market__c> MarketMaplist=new Map<String,Market__C>();
    list<Market__c> newmarketrec =new list<Market__c>();
    list<store__c> storelist =new list<store__c>();
    list<Market__C> Marketlist=[Select Id,Name,Zone__c from Market__c];
    set<string> marketcodeset=new set<string>();
    integer count=0;
    public database.QueryLocator start(Database.BatchableContext bc)
    
    {  
        
        for(Market__C m:Marketlist)
        {
            MarketMaplist.put(m.Name,m);
        }
        system.debug(MarketMaplist);
        return Database.getQueryLocator('Select id,Market__c ,Market_Code__c,Zone_Code__c,Zone2__c from store__c');
    }
    public void execute(Database.BatchableContext bc,list<store__c> scope)
    {  
        list<store__C> strlst =new list<store__C>() ;
        strlst.addall(scope);
        //system.debug('scopesize'+scope.size());
           for(Store__c s:strlst)
           {
                              
             if(MarketMaplist.containsKey(s.Market_Code__c))  //if already market code matches the existing market map the market with store
             {
                
                 s.Market__c=(Id)MarketMaplist.get(s.Market_Code__c).Id;
                 MarketMaplist.get(s.Market_Code__c).Zone__c=s.Zone2__c;
                 system.debug(s.Market__c);
             }
               else       //creating new zone for the zone code
               {
                   storelist.add(s);
                   system.debug('in else loop');
                   if(!marketcodeset.contains(s.Market_Code__c))
                   {
                   marketcodeset.add(s.Market_Code__c);
                       Market__C  marketsinglerec=new Market__C(Market_Name__C=s.Market_Code__c,Zone__c=s.Zone_Code__c);
                       newmarketrec.add(marketsinglerec);
                   }
                   
                   
               } 
           }
        //insert newzonerec;
        Database.SaveResult[] updateResult= Database.update(strlst,false) ;
        Database.SaveResult[] insertResult=Database.insert(newmarketrec,false) ;
        //display result of the insert dml operation
        system.debug(insertResult);
        //mapping the store with Market with newly created market records only if it matches the marketcode
         for(Market__C m:Marketlist)
        {
            MarketMaplist.put(m.Name,m);
        }
         //mapping all the store records with market 
        
        for(store__C s:storelist)
        {
           if(MarketMaplist.containsKey(s.Market_Code__c))  //if already zone code matches the existing zones map the zone with store
             {
                
                 s.Market__c=(Id)MarketMaplist.get(s.Market_Code__c).Id;
                 
                 system.debug(s.Market__c);
             }  
        }
        Database.update (storelist,false);
        Database.update (MarketMaplist.values(),false);    
       
    }
    public void Finish(Database.BatchableContext bc)
    {
        
        system.debug(count);
        
     
        system.debug('batch executed');
        
    }
}