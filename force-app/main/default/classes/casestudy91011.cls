public class casestudy91011{
    
    
   
    //case study 9
    //Method to search two words  from contact and list name fields and retrive name and phonenumber
    public static void search_data(){
        
    string word ='Arun kumar OR  Aravind';
    list<list<SObject>> search_rec = [Find :word 
                                       IN NAME FIELDS 
                                       returning 
                                       Contact(Name,Phone) ,Lead(Name,Phone)];
        for(list<sObject> s:search_rec)
        {
            system.debug(s);
        }
        
    }
    // case study 10
    // //Method to retrive account name and last name of each contact assosiated with that account
    public static void load_data(){
        list<Account> accname_rec=[select Name ,(select LastName from contacts) from Account];
        
       for(Account a:accname_rec)
       {
           
           system.debug('Account Name= '+a.Name);
           
           
           for(contact c:a.contacts)
           {   
               
               system.debug('contact last name '+c.LastName);
               
           }
       }
        
    }
    //function to get total no of opportunity records
     public static void opp_count(){
         
         list<AggregateResult>  opp_rec=[select Count(Id)  from Opportunity ];
         for(AggregateResult a:opp_rec)
         {
         system.debug('No of opp records = '+a.get('expr0'));
         }
        
        
    }
    
    
    //create account and opportunities assositated with that account..with the given details in casestudy 12
    
    public static void insertAccOpp(){
        Account newrec =new Account(Name='A02',Priority_field__c='high');
        insert newrec;
        list<opportunity> newopplst =new list<Opportunity>();
        
        Opportunity createopp1 = new Opportunity(Name='Opp1',Amount=345,AccountId=newrec.Id,StageName='Prospecting',Closedate = Date.newInstance(2023,01,22));
        
         Opportunity createopp2 = new Opportunity(Name='Opp2',Amount=567,AccountId=newrec.Id,StageName= 'Prospecting',Closedate = Date.newInstance(2023,02,22));
        newopplst.add(createopp1);
        newopplst.add(createopp2);
//newopplst.add(createopp2);
        insert newopplst;
    
    
    
        
        list<AggregateResult> rec_sum=[Select SUM(Amount) from Opportunity where AccountId =:newrec.Id];
        system.debug('total sum of amount for the account id is = '+rec_sum);


  
     
    
    }
      //query to return list of stage name and opp records 
    public static void stageopprec(){
        
         list<AggregateResult> listrec=[Select Count(Id) ,StageName from Opportunity Group by StageName];
        for(AggregateResult a:listrec)
        system.debug(a);
    }
}

/*//integer year= YEAR(TODAY());
string username=UserInfo.getName();

string locale=UserInfo.getLocale();
system.debug('locale = '+locale);
integer length=username.length();
system.debug('stringlength = '+length);
string first5char=username.substring(0,5);
system.debug('first 5 charecters of username = '+ first5char);
//date myDate = DATE(Today());
//date weekStart = myDate.toStartofWeek();
system.debug('startdate of week  '+weekStart);
*/