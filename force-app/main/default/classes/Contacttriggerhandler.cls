public class Contacttriggerhandler {
    
    //If contact status field is changed to inactive , Check for related opps and if its status is closed won and 
    //recurring field is true, do no allow the contact to change to inactive.
    public static void con_update_validate(list<contact> contactnew,Map<Id,Contact> contactoldmap ,Map<Id,Contact> contactnewmap)
    {
        Set<Id> idset=new Set<Id>();
        for(Contact con:contactnew)
        {
            if(contactoldmap.get(con.Id).Active__c != contactnewmap.get(con.Id).Active__c &&
               contactnewmap.get(con.Id).Active__c ==false)
            {
                if(con.AccountId !=null)
                    idset.add(con.AccountId);
            }
            list<Opportunity> opplist=[Select Id,StageName,AccountId from Opportunity where AccountId IN :idset];
            Set<Id> oppaccountIdset=new Set<Id>();
            for(Opportunity opp:opplist)
            {
                
                if(opp.StageName == 'Closed Won' )
                {
                    oppaccountIdset.add(opp.AccountId);
                }
            }
            system.debug(oppaccountIdset);
            for(Contact c:contactnew)
            {
                if(oppaccountIdset.contains(c.AccountId))
                    c.addError('Cannot change the field to inactive');
                system.debug('inside add error');
            }
        }
    }
    //updates the no of contacts in the account field
  /*  public static void acc_contactcount_update(List<contact> contactlst){
        
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
        
    }
*/
    public static void acc_contactdelete_update(List<contact> contactlst){
        
        list<Id>  accidlst = new list<id>();
            list<Account> updatedacclst=new list<Account>();
            for(Contact c:contactlst)
            {
                if(c.AccountId !=null)
                accidlst.add(c.AccountId);
            }
           list<Account> acclst =[Select Id,count_of_contacts__c,(select Id from Contacts) from Account where Id IN :accidlst];
            for(Account a:acclst)
            {
               
                integer count =(Integer)a.contacts.size();
                system.debug(count);
                 //if(a.count_of_contacts__c==1)
                    // count=0;
                Account singlerec =new Account(Id=a.Id,count_of_contacts__c=count);
                updatedacclst.add(singlerec);
            }
                  
            update updatedacclst;
        
    }
    
    public static void ContactRelation_create(list<contact> newrecords){
         //when the contact relationship checkbox is checked the contactrelation ship is automatically created.
            list<id> conids=new list<id>();
            for(contact c:newrecords)
            {
                if(c.Contact_Relationship__c ==true)
                  conids.add(c.Id) ; 
            }
            list<Contact_Relationship__c> CRlst=new list<Contact_Relationship__c>();
            list<contact> conrec=[select id,Contact_Relationship__c from contact where id IN :conids];
            system.debug(conrec);
             for(contact c:conrec)    
                {
                  Contact_Relationship__c cr =new  Contact_Relationship__c(Contact__c=c.Id,Name ='CR1'); 
                    system.debug(cr);
                    CRlst.add(cr);
                }      
            insert CRlst;
        }
    
    public static void CRdelete(list<contact> deletedrec)
    {
       // map<ID,contact> conrecold=deletedrec;
         
           list<Id> idlist=new list<id>();
           for(contact c:deletedrec)
           {
               idlist.add(c.Id);
           }
           list<Contact_Relationship__c> Crdlist =[select Id,Contact__c from Contact_Relationship__c where Contact__c IN :idlist];
            system.debug(crdlist);
            delete crdlist;
    }
        public static void create_account(list<contact> conlist)
        {
            list<Account> accupdate=new list<Account>();

           for(contact c:conlist)
           {
               Account acc =new Account(Name=c.LastName+01);
               accupdate.add(acc);
               
           }
            Database.SaveResult[] result = Database.insert(accupdate,false);
            for(Database.Saveresult ds:result)
            {
            if(ds.isSuccess())
            {
                system.debug('successfully inserterd');
            }
            else
            {
                for(Database.Error err :ds.getErrors())
                {
                    system.debug('The following error occured');
                    system.debug(err.getMessage());
                    system.debug(err.getFields());
                }
                
            }
            }
                
            }
        
        
    }