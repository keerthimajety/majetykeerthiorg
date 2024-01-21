trigger employeeTrigger on employee__c (/*after delete,*/after insert) {
    
    //map<Id,employee__C> emplst=trigger.oldmap;
    List<Account> accupdatedlst =new list<Account>();
   /* for(employee__c e:trigger.old)   
    {
        list<account> acclst=[Select Id from Account where Id= :e.Account__c];
        Account accrec=new Account(Id=e.Account__c); 
        if(acclst.size() >0)
        {
            accrec.employee_active__c ='false';
        }
        else
        {
             accrec.employee_active__c ='true';
        }
        accupdatedlst.add(accrec);
    }
    update accupdatedlst;*/
    
    
    


///TRail avoiding soql inside for loop
//
//
/* commented for testing anoather code jan 3rd
 List<id> accountids =new List<id>();
for(employee__c e:trigger.old)
{
    accountids.add(e.Account__c);
}
    List<AggregateResult>  countemprec= [Select Count(Id) ,Account__c from employee__C where Account__c IN :accountids group by Account__c];
    system.debug(countemprec);
    for(AggregateResult a:countemprec)
    {
        system.debug('count of rec '+a.get('expr0'));
        Account accsinglerec =new Account(Id=(Id)(a.get('Account__C')));
        
        if(((Integer)a.get('expr0'))>0)
        {
            accsinglerec.employee_active__c ='true';
            accupdatedlst.add(accsinglerec);
        }
        else if(((Integer)a.get('expr0'))==0)
        {
            accsinglerec.employee_active__c ='false';
        accupdatedlst.add(accsinglerec);
        }
        system.debug(accsinglerec);
    }
    update accupdatedlst;
    
}*/
    list<employee__c> emplist=[Select Id,Salary__c from employee__c where Id IN :trigger.new];
    for(employee__c e:emplist)
    {
        e.Salary__c=60000;
    }
    update emplist;
}