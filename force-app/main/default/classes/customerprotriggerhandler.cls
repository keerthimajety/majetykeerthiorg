public class customerprotriggerhandler {
    
    public static void Activefldchk(list<Customer_Project__c>  newlist)
    {
         Set<id> oppids=new Set<id>() ;
    for(Customer_Project__c c:newlist)
    {  
        if(c.Status__c=='Active' && c.OpportunityId__c !=null)
        oppids.add(c.OpportunityId__c);
    }
    list<opportunity> opplst =[Select id,Active_Customer_Project__c from Opportunity where Id IN :oppids];
    for(Opportunity o:opplst)
    {
        o.Active_Customer_Project__c =True;
    }
    update opplst;
    }

}