public class Acchandler {
    //when account is inactive close all the cases if any
    public static void acc_closecases(list<Account> accnew,Map<Id,Account> accoldmap,Map<Id,Account> accnewmap)
    {
        set<id> idset=new set<id>();
        for(Account acc :accnew)
        {
            if(accoldmap.get(acc.Id).Active__c != accnewmap.get(acc.Id).Active__c && accnewmap.get(acc.Id).Active__c=='No')
                idset.add(acc.Id);
        }
        
        list<case> caselist=[Select Id,Status from case where AccountId IN :idset];
        if(caselist.size()>0)
        {
            for(case c:caselist)
            {
               c.Status = 'Closed'; 
            }
            update caselist;
        }
    }
    //do not allow user to delete the acc record if its active and the user is not the account owner.
    public static void delete_validate(list<account> accoldlist)
    {
        for(account acc:accoldlist)
        {
            if(acc.Active__c =='Yes' && acc.OwnerId != UserInfo.getUserId())
                acc.addError('Cannot delete the account if its active or you are not the account owner');
        }
    }

}