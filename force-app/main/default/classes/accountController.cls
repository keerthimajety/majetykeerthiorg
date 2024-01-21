public with sharing class accountController {
    
    @AuraEnabled(cacheable=true)
    public static list<Account> getacclist(String rating){

        return [Select Name,Rating from Account where Rating = :rating];
       
    }
    @AuraEnabled(cacheable=true)
    public static list<Account> getsearchlst(string searchword)
    {
       
       string str=searchword+ '%';
       
       return [Select Id,Name,BillingState,AccountNumber from Account where Name LIKE :str ];
    }
}