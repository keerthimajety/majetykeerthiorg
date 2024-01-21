public class revision1{
    //when ever lead is created create a duplicate lead
    
    list<Account> triggernew;
    public revision1()
    {
        triggernew =(List<Account>)Trigger.new;
        
    }
    
    /*When any Opportunity is created with amount populated or Opportunity
Amount is updated then populate total Amount on Account Level for all
related opportunities in Annual Revenue Field. If opportunity is deleted or
undeleted then update Amount on Account as well. (Hint: rollup summary)*/
    public static void updateamountinopp(list<opportunity> opplist)
    {
        Set<Id> idset=new Set<Id>();
        for(opportunity opp:opplist)
        {
            If(opp.AccountId !=null)
                idset.add(opp.AccountId);
            
        }
        list<Account> acclisttoupdate=new list<Account>();
        list<AggregateResult> agrresult=[Select SUM(Amount) ,AccountId from Opportunity where AccountId IN :idset Group by AccountID];
        if(agrresult.size()>0)
        {
            for(AggregateResult agr:agrresult)
            {
                Account acc=new Account();
                acc.AnnualRevenue = (Decimal)agr.get('expr0');
                acc.Id=(Id)agr.get('AccountId');
                acclisttoupdate.add(acc);
            } 
        }
        
        if(acclisttoupdate.size()>0)
            update acclisttoupdate;
            
        
    }
    public static void create_duplicate_lead(list<Lead> leadlist)
    {
        
        if(variable.runonce())
        {
            List<Lead> leadlist1=new List<Lead>();
            leadlist1=leadlist.deepClone();
            insert leadlist1;
            
        }
        
    }
    
    
    //IF we uncheck the isactivetest checkbo from account the also uncheck the is active checkbox of the related user
    //of that contact assosiated with it.
    public static void uncheck_user_contacts(List<Account> acclist,Map<id,account> accoldmap,Map<id,account> accnewmap)
    {
        list<id> accids =new  list<id>();
        list<contact> conlisttoupdate=new  list<contact>();
        for(account a:acclist)
        {
            if(accnewmap.get(a.Id).isActiveTestA__c == false && accoldmap.get(a.Id).isActiveTestA__c != accnewmap.get(a.Id).isActiveTestA__c)
            {
                accids.add(a.Id) ;
                
            }
            
        }
        
        list<Contact> conlist=[Select Id,isActiveTestC__c from contact where AccountId IN :accids];
        for(Contact c:conlist)
        {
            c.isActiveTestC__c=false;
            conlisttoupdate.add(c);
        }
        update conlisttoupdate;
        list<user> userlist=new list<user>();
        list<Account> acclist2 =[Select Id,OwnerId from Account where Id in :accids];
        for(Account Acc:acclist2)
        {
            User u=new User();
            u.isActiveTest__c=false;
            u.Id=acc.OwnerId;
            userlist.add(u);
        }
        update userlist;
        
        
    }
    //capgemini senario
    public static void enter_phone_contact(List<Contact> conlist)
    {
        Set<id> idset=new Set<Id>();
        
        list<Contact> conlisttoupdate =new list<Contact>();
        for(Contact c:conlist)
        {
            if(c.AccountId !=null)
                idset.add(c.AccountId);
        }
        if(idset.size() >0)
        {
            Map<Id,Account> accmap=new Map<Id,Account>([Select Id,other_phone_number__c from Account where Id IN :idset]);
            for(Contact c:conlist)
            {
                if(accmap.get(c.AccountId).other_phone_number__c !=null)
                {
                    c.Phone = accmap.get(c.AccountId).other_phone_number__c;
                    system.debug(c.Phone);
                    
                }
                
            }
        }
        
    }
    
    //kishore senario
    //when case is resolved save the date in the account custom field case close date
    public static void save_case_close(list<case> casenewlist,Map<Id,Case> caseoldmap,Map<Id,Case> casenewmap)
    {
        Set<Id> accidset=new set<Id>();
        for(Case c:casenewlist)
        {
            if(caseoldmap.get(c.Id).Status !=casenewmap.get(c.Id).Status && 
               casenewmap.get(c.Id).Status == 'Resolved')
                accidset.add(c.AccountId);
        }
        list<Account> acclist=[Select Id,case_closed_date__c from Account where Id IN :accidset];
        if(acclist.size()>0)
        {
            for(Account a:acclist) 
            {
                a.case_closed_date__c=Date.today();
                
            }
            update acclist;
        }
    }
    //kishore given trigger senario
    //when an account owner is changed update Account Related opportunity Teammembers owner
    public static void update_opp_teamowner(list<Account> acclist,Map<Id,Account> accoldmap,Map<Id,Account> accnewmap)
    {
        set<Id> idset=new set<Id>();
        for(Account acc:acclist)  
        {
            if(accoldmap.get(acc.Id).ownerId != accnewmap.get(acc.Id).ownerId) 
                idset.add(acc.Id);
        } list<OpportunityTeamMember> oppteamlist=new list<OpportunityTeamMember>();
        //to add team member in the opportunity team
        /* list<opportunity> opplist=[Select Id,AccountId from Opportunity where AccountId IN :idset];
for(Opportunity opp:opplist)
{
OpportunityTeamMember otm=new OpportunityTeammember();
otm.OpportunityId=opp.Id;
otm.TeamMemberRole='Sales Rep';
otm.UserId=accnewmap.get(opp.AccountId).ownerId;
//otm.OpportunityAccessLevel='Read Only';
oppteamlist.add(otm);

}
insert oppteamlist;*/
        
        //to change the teammember according to the account owner change
        Map<Id,Opportunity> oppmap=new Map<Id,Opportunity>([Select Id,AccountId from Opportunity where AccountId IN :idset]);
        system.debug(oppmap.keyset());
        list<OpportunityTeamMember> oppteamlist2=[Select Id,UserId,OpportunityId from OpportunityTeamMember where OpportunityId IN :oppmap.keyset()];
        system.debug('oppteammemberlist');
        system.debug(oppteamlist2);
        if(oppteamlist2.size() >0)
        {
            for(OpportunityTeamMember otm:oppteamlist2)
            {
                Id oppaccountId=oppmap.get(otm.OpportunityId).AccountId;
                OpportunityTeammember tm=new OpportunityTeamMember(Id=otm.Id,UserId=accnewmap.get(oppaccountId).ownerId);
                oppteamlist.add(tm);
                system.debug('insideforloop');
                
            }
            system.debug(oppteamlist);
            update oppteamlist;
        }
    }
    
    //1.where a case is created with origin as email set status to new and priority to medium
    public static void case_field_set(list<Case> casenewlist)
    {
        for(Case c:casenewlist)
        {
            if(c.origin == 'email')
            {
                c.Status='New';
                c.Priority = 'Medium';
            }
        }
    }
    
    //trigger senarios ramya challenge day 8
    //Update the highest amount in the opportunity to Accounts Field.
    public static void update_highestamt_opp(list<opportunity> opplist)
    {
        Set<id> idset=new set<id>();
        for(opportunity opp:opplist)
        {
            If(opp.AccountId !=null)
            idset.add(opp.AccountId);
        }
        list<AggregateResult> oppagrlist=[Select MAX(Amount),AccountId from opportunity where AccountId IN :idset  group by AccountId] ;
        list<account> acctoupdate=new list<account>();
        for(AggregateResult agr:oppagrlist)
        {
            Account acc=new Account();
            acc.Id=(Id)agr.get('AccountId');
            acc.maxoppamount__c=(Decimal)agr.get('expr0');
            acctoupdate.add(acc);
        }
        update acctoupdate;
    }
    //trigger senarios no.21
    //when an account is created send an email to the systemadmin user
    public static void email_systemadmin(list<Account> accnew)
    {
        Profile p=[Select Id, Name from Profile where Name like 'system admin%' LIMIT 1];
        User systemadminuser=[Select Email from User where ProfileId =:p.Id  LIMIT 1];
        system.debug(p.Id);
        for(Account Acc:accnew)
        {
            Messaging.SingleEmailMessage message=new Messaging.SingleEmailMessage();
            String[] emailadd=new String[]{systemadminuser.Email};
                message.toAddresses= emailadd;
            message.subject='New account created';
            message.plainTextBody ='new account created with the Id'+acc.Id;
            system.debug(message);
            list<Messaging.SingleEmailMessage> messages=new List<Messaging.SingleEmailMessage>{message};
                Messaging.sendEmailResult[] result=Messaging.SendEmail(messages);
            
        }
        
    }
    //revision 24 
    //If the owner of the account is changed change the owner of all the assosiated contacts
    public static void change_contact_owner(list<Account> acclist,Map<Id,Account> accoldmap,Map<Id,Account> accnewmap)
    {
        set<Id> idset=new set<Id>();
        for(Account acc:acclist)
        {
            if(accoldmap.get(acc.Id).OwnerId != accnewmap.get(acc.Id).OwnerId)
                idset.add(acc.Id);
        }
        list<Contact> conlist=[Select Id,OwnerId,AccountId from Contact where AccountId IN :idset];
        for(Contact con:conlist)
        {
            con.OwnerId =accnewmap.get(con.AccountId).OwnerId;
            
        }
        update conlist;
    }
    
    //ramya challenge day 10
    // Block the user ,When a user try to delete the account ,if a account was created a week before.
    public static void acc_delete_validate(list<account> accoldmap){
        Date startDate=date.today();
        for(Account acc:accoldmap)
        {
            system.debug(startDate);
            system.debug(acc.CreatedDate.date());
            system.debug(acc.CreatedDate.date().daysBetween(startDate));
            system.debug(startDate.daysBetween(acc.CreatedDate.date()));
            if(acc.CreatedDate.date().daysBetween(startDate) >7)
            {
                system.debug('insideif');
                acc.addError('Account record cannot be deleted as it is created 7 days before');
            }
            
        }
    }
}