public class opphandler {
    
    //diy day 56 tamil apex triggers
    public static void create_task(list<opportunity> opplist,Map<Id,opportunity> oppoldmap,Map<Id,opportunity> oppnewmap)
    {
        list<Task> Tasktoupdate=new list<Task>();
        for(opportunity opp:opplist)
        {
            if(oppoldmap.get(opp.Id).StageName != oppnewmap.get(opp.Id).StageName && oppnewmap.get(opp.Id).StageName=='Closed Won')
            {
                Task T=new Task();
                T.Subject=opp.Name +'Task assigned';
                T.WhatId=opp.Id;
                
                Tasktoupdate.add(T);
            }
        }
        Insert Tasktoupdate;
    }
    
    //day 53 tamil apex triggers
    //If opportunity changed to negotiation the update all the count of opp in the account object.
    public static void opp_count_update(list<opportunity> opplist,Map<Id,opportunity> oppoldmap,Map<Id,opportunity> oppnewmap)
    {
        set<Id> idset=new set<Id>();
        for(Opportunity opp:opplist)
        {
            if(oppoldmap.get(opp.Id).StageName != oppnewmap.get(opp.Id).StageName && oppnewmap.get(opp.Id).StageName=='Negotiation/Review')
                idset.add(opp.AccountId);
        }
        list<Account> acclist=[Select Id,opp_count__c ,(select id from opportunities) from Account where Id IN :idset];
        for(Account acc:acclist)
        {
            acc.opp_count__c =acc.opportunities.size();
        }
        update acclist;
    }
    //if the oppportunity is closed won and description field is null or empty it should through an error
    
    public static void validateInsert(list<opportunity> opportunities)
    {
        for(opportunity opp:opportunities)
        {
            if(opp.StageName =='Closed Won' && opp.Description ==null)
                opp.addError('Description','Description field cannot be empty if stagename is closed won');
            
        }
    }
    //if the user updates the quantity custum field in opportunity then update all quantities in the opportunity line items should be same
    public static void update_quantity_Lineitems(list<opportunity> opportunities,Map<Id,opportunity> oldmapopp,Map<Id,opportunity> newmapopp)
    {
        list<Id> idset=new list<Id>();
        list<OpportunityLineItem> olitoupdate=new list<OpportunityLineItem>();
        for(opportunity opp:opportunities)
        {
            if(oldmapopp.get(opp.Id).Quantity_custom__c != newmapopp.get(opp.Id).Quantity_custom__c)
                idset.add(opp.Id);
        }
        list<OpportunityLineItem> oplList=[select id,OpportunityId,Quantity from OpportunityLineItem where OpportunityId IN :idset];
        for(OpportunityLineItem oli :oplList)
        {
            
            system.debug(Trigger.newMap.get(oli.OpportunityId));
            oli.Quantity= newmapopp.get(oli.OpportunityId).Quantity_custom__c;
            olitoupdate.add(oli);
            
            
            
        }
        update olitoupdate;
    }
    
    public static void enable_active(list<opportunity> oppnew)
    {
        set<Id> idlist =new set<id>();
        for(opportunity o:oppnew)
        {
            if(o.AccountId !=null)
            {
                //idlist.add(o.Id);
                idlist.add(o.AccountId);
            }
        }
        system.debug('inside trigger');
        list<Account> accrec=[Select Id,Active__C from account where id IN :idlist];
        
        if(accrec.size() >0)
        {
            for (account a:accrec) 
            {
                system.debug('inside trigger');
                a.Active__c ='yes';
            }
            
            Database.SaveResult[] result =Database.update(accrec,false);
            for(Database.SaveResult ds:result)
            {
                if(ds.isSuccess()) 
                {
                    system.debug('updated successfully');
                    
                }
                else
                {
                    for(Database.Error err:ds.getErrors())
                    {
                        system.debug('the errors are as follows');
                        system.debug(err.getMessage());
                        system.debug(err.getFields());
                    }
                }
            }
        }
        
        
    }
    //if opportunity stage changed to closed won the account field active__c should be yes and contact active__c should be true
    public static void active_edit(list<opportunity> oppnewlst,Map<Id,Opportunity> oppoldmap,Map<Id,Opportunity> oppnewmap)
    {
        set<id> idlist =new set<Id>();
        for(opportunity o:oppnewlst)      
        {
            system.debug(oppoldmap.get(o.Id).StageName);
            system.debug(oppnewmap.get(o.Id).StageName);
            if((oppoldmap.get(o.Id).StageName != oppnewmap.get(o.Id).StageName) && (oppnewmap.get(o.Id).StageName =='Closed Won'))
            {
                idlist.add(o.AccountId);               
            }
        }
        Map<Id,contact> conrec=new Map<Id,Contact>();
        list<contact> conlist=[Select Id,AccountId,Active__c from contact where AccountId IN :idlist];
        list<contact> contoupdate=new list<contact>();
        for(contact c :conlist)
        {
            conrec.put(c.AccountId,c);
        }          
        list<Account> accrec=[Select Id,Active__c from account where Id IN :idlist];
        for(account a :accrec)
        {
            a.Active__c='Yes';               
            // conrec.get(a.Id).Active__c =true;
        }
        update accrec;          
        contoupdate = conrec.values();
        update contoupdate;
    }
    //day 58 diy 1 tamil apex triggers
    //when the opportunity marked as closed won create a task for sales rep to follow up the opportunity
    public static void create_task_salesrep(list<opportunity> oppnew,Map<id,opportunity> oppoldmap,Map<id,opportunity> oppnewmap)
    {
        
        list<Task> TaskList=new list<Task>();
        list<opportunity> newopplist=new list<opportunity>();
        Map<Id,User> UserList=new Map<Id,User>([Select Name from User  ]);
        for(opportunity opp:oppnew)
        {
            if(!recursionclass.IdSetRec.contains(opp.Id))
            {
                recursionclass.IdSetRec.add(opp.Id) ;
                newopplist.add(opp);
                
            }
        }
        
        for(opportunity opp:newopplist)
        {
            if(opp.StageName !=oppoldmap.get(opp.Id).StageName && opp.StageName=='Closed Won')
            {
                Task singletask=new Task();
                singletask.WhatId =opp.Id;
                //singletask.WhoId=oppnewmap.get(opp.id).;
                singletask.Subject='Follow the opportunity';
                singletask.Description='Hi '+UserList.get(opp.Sales_Rep__c).Name +'Please follow the opportunity by making a call to the Customer';
                singletask.ActivityDate=system.today() +2;
                singletask.OwnerId=opp.Sales_Rep__c;
                TaskList.add(singletask);
                system.debug(singletask);
            }
        }
        insert TaskList;
    }
    //when opp is deleted the assosiated accounts have no opp means del the account
    public static void opp_acc_delete(list<opportunity> oppnew)
    {
        set<id> idset=new set<id>();
        for(opportunity o:oppnew)
        {
            idset.add(o.AccountId);
        }
        list<Account> acc_to_delete=new list<Account>();
        list<Account> acclist=[Select Id,Name ,(Select Id from Opportunities) from Account where Id IN :idset];
        for(Account acc:acclist)
        {
            if(acc.opportunities.size() ==0)
            {
                acc_to_delete.add(acc);
            }
        }
        delete acc_to_delete;
    }
    //when the opportunity line item is created /updated/deleted Update the total quantity and total Line Item in the opportunity object
    Public static void opp_lineItem_Update(list<OpportunityLineItem> oliList )
    {
        Set<Id> oppids=new Set<Id>();
        system.debug('inside the opp line item update');
        for(opportunityLineItem ol : oliList)
        {
            oppids.add(ol.OpportunityId) ;
            system.debug('added opp id is '+ol.opportunityId);
        }
        list<opportunity> opplisttoupdate=new list<opportunity>();
        list<AggregateResult> oliaggregatelist=[select COUNT(Quantity) ,SUM(UnitPrice) ,OpportunityId from OpportunityLineItem  where OpportunityId IN :oppids Group By OpportunityId];
        system.debug(oliaggregatelist);
        for(AggregateResult ar:oliaggregatelist)
        {
            Opportunity opp=new Opportunity(Id=(Id)ar.get('OpportunityId'),Total_Line_Item_Price__c=(decimal)ar.get('expr1'),Total_Line_Item_Quantity__c=(decimal)ar.get('expr0'));
            opplisttoupdate.add(opp);
        }
        if(opplisttoupdate !=null)
        {
            Database.SaveResult[] result=Database.update(opplisttoupdate,false);
            for(Database.Saveresult ds :result)
            {
                if(ds.isSuccess())
                {
                    system.debug('update Successfull');
                    
                }
                else
                {
                    for(database.error error :ds.geterrors())
                    {
                        system.debug(error.getMessage());
                    }
                }
            }
        }
        
    }
}