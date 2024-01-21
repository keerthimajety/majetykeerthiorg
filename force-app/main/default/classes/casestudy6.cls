/***********************************************************************
Name        casestudy6
author      keerthi
date        15-1-2023
Description load 100 account records with account name Test01,Test02...Test100
*************************************************************************/

public class casestudy6{
    
    //load 100records with name test01,test02.....
 Public static void accload(){
      list<Account> accnewlist=new list<Account>();
        for(integer i=0;i<3;i++)
        {
            Account singlerec =new Account();
            singlerec.Name ='Test'+i;
            singlerec.priority_field__c='high';
            accnewlist.add(singlerec);
        }
        insert accnewlist;
        
  
}
    // update all account rec from Billing city CA to FL
    Public static void updateacc(){
        
        list<Account> acclist=[Select Name,BillingCity FROM Account where BillingCity='CA'];
        list<Account> accnewlist=new list<Account>();
        for(Account a:acclist)
        { 
            Account acc=new Account();
            acc.BillingCity = 'FL';
            acc.id = a.id;
            accnewlist.add(acc);
            
            
        }
        update accnewlist;
    }
    //method that takes a sentance as an input and displays the repetion of each word in the sentance;
    
    public static void word_count(string sentance){
        
       Map<String, Integer> stringcount= new Map<String, Integer>();
		for(String singleword: sentance.split('\\s+')) {
  		integer count;
            count= sentance.countMatches(singleword);
            
            if(count == null) {
             count = 0;
   		 stringcount.put(singleword, count+1);
        }
            stringcount.put(singleword, count);
		}
           system.debug(stringcount);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}