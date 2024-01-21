public class Apphandler {
 
    public static void create_con(list<Account> accnew)
    {
        list<id> idlist=new list<id>();
        list<Contact> contacttoupdate=new list<contact>();
        
        for(Account a :accnew)
        {
            if(a.Industry=='Banking')
            idlist.add(a.Id);
            
        }
        system.debug(idlist);
         list<Account> accrec=[Select Id,Name,Phone from Account where Id in :idlist]   ;
        system.debug(accrec.size());
        if(accrec.size()>0)
        {
            for(Account a:accrec)
            {
                Contact con=new Contact(LastName=a.Name,AccountId=a.Id,mobile_number__C=a.Phone);
                contacttoupdate.add(con);
            }
            system.debug(contacttoupdate);
            Database.SaveResult[] result= Database.insert(contacttoupdate,false);
            for(Database.Saveresult ds:result)
            {
                if(ds.isSuccess())
                {
                    
                  system.debug('successfully inserted');
                }
                else
                {
                    for(Database.Error e:ds.getErrors())
                    {
                        system.debug('error messages = '+e.getmessage());
                        system.debug('fields with error ='+e.getfields());
                    }
                }
            }
        }
    }
    
    public static void update_opp(list<Account> accnew)
    {
        list<id> idlist=new list<id>();
      for(Account acc:accnew)  
      {
         
        idlist.add(acc.id) ;
      }
        list<opportunity> opplist = [Select Id,AccountId,StageName,CreatedDate from opportunity where AccountId IN :idlist];
        if(opplist.size()>0)
        {
            for(opportunity o:opplist)
            if(o.StageName!='Closed Won' && (  o.CreatedDate < system.now() -30 ))
            {
              o.StageName ='Closed Won';
            }
            
            Database.SaveResult[] result=Database.update(opplist,false);
            for(Database.SaveResult ds:result)
            {
                if(!ds.isSuccess())
                {
                    system.debug('An Error occured');
                   For(Database.Error err:ds.getErrors()) 
                   {
                       system.debug('Error messages = '+ err.getMessage());
                       system.debug('Error fields ='+ err.getFields());
                   }
                }
            }
        }
    }
    
}