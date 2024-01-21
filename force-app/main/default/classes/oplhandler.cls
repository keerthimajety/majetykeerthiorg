public class oplhandler {
    
    public static void create_asset(list<OpportunityLineItem> newrec)
    {
        Set<id> idlist=new set<id>();
        for(OpportunityLineItem opl:newrec)
        {
            idlist.add(opl.OpportunityId);
        }
        list<opportunity> opplist=[Select Id,AccountId from Opportunity where Id IN :idlist AND AccountId!=null];
        list<Asset> asslist=new list<Asset>();
        for(Opportunity o:opplist)
        {
            Asset ass=new Asset(Name='motors',AccountId=o.AccountId);
            asslist.add(ass);
        }
        
        Database.SaveResult[] result=Database.insert(asslist,false);
        for(Database.SaveResult ds:result)
        {
            if(ds.IsSuccess())
            {
                system.debug('Inserted successfully');
            }
            else
            {
                system.debug('error occured');
                for(Database.Error dr:ds.geterrors())
                {
                    system.debug('the following errors appear');
                    {
                        system.debug(dr.getmessage());
                        system.debug(dr.getFields());
                    }
                }
            }
        }
    }
    
    public static void update_products(list<opportunitylineitem> oplnew)
    {
        set<id> idlist=new set<id>();
        
        for(opportunitylineitem opl:oplnew)
        {
            //idlist.add(opl.OpportunityId);
            idlist.add(opl.Product2Id);
            
        }
        list<AggregateResult> productqty=[Select sum(quantity)quantity ,Product2Id from OpportunitylineItem where Product2Id IN :idlist group by Product2ID];
        system.debug(productqty);
        Map<Id,Integer> prod_qty=new Map<Id,Integer>();
        for(AggregateResult ag:productqty)
        {
         prod_qty.put((Id)ag.get('Product2Id'),(integer)ag.get('quantity'));
            
        }
         list<Product2> productlist=[Select Id ,TotalQuantities__c from Product2 where Id IN :idlist]   ;
        list<Product2> Prolisttoupdate=new list<product2>();
            
        {
            if(productlist.size()>0)
            {
                
            
            for(Product2 p2:productlist)
            {
               if(p2.TotalQuantities__c !=null)
                p2.TotalQuantities__c = p2.TotalQuantities__c- prod_qty.get(p2.Id);
                Prolisttoupdate.add(p2);
            }
            }
        }
        if(Prolisttoupdate.size()>0)    
            update Prolisttoupdate;
            
            
        
        
    }
}