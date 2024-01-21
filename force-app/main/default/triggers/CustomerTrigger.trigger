//case study 6 triggers
//when we create customer record assosiated with the account then
//User in Account Manager field will be automatically added to the particular account team.


trigger CustomerTrigger on Customer__c (after insert) {
    
    Set<id> accids =new Set<id>();
    Map<Id,Customer__C> newrecords=new Map<Id,Customer__C>();
    
   /* for(Customer__C c:trigger.new)
    {
        if(c.Account__c!=null)
        {
       accids.add(c.Account__c) ;
       newrecords.put(c.Account__c,c);
        }
        
    }
     list<Account> acclst = [Select id  from Account where Id In :accids];
    list<AccountTeamMember> ATMlst = new list<AccountTeamMember>();
    for(Account a:acclst)
    {   
        system.debug(newrecords.get(a.Id));
        AccountTeamMember atmrec = new AccountTeamMember(AccountId=a.Id,UserId = newrecords.get(a.Id).Account_manager__c);
        ATMlst.add(atmrec);
    }
    Insert ATMlst;*/
}