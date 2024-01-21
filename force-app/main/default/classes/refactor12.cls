public class refactor12 {
    
   
    public static void empupdate(){
        
     list<employee__c>  emplist=new list<employee__c>();
    list<employee__c>  emprec=[Select id,Name from employee__c];
    for(employee__c emp: emprec)
    {
        
        employee__c e=new employee__c();
        e.Name=emp.Name+'refactor';
        e.id=emp.id;
        emplist.add(e);
    }
  update emplist;
    }
    
    Public static void accinsert(){
      list<Account> accnewlist=new list<Account>();
        for(integer i=0;i<5;i++)
        {
            Account singlerec =new Account();
            singlerec.Name ='Test'+i;
            singlerec.priority_field__c='high';
            accnewlist.add(singlerec);
        }
        insert accnewlist;
        
    }
    public static void coninsert(){
        list<Contact> conlist =new list<Contact>();
        for(Account acc:[Select Id,Name from Account])
        {
           Contact conrec=new Contact();
            conrec.AccountId=acc.Id;
            conrec.last_name__c='SN'+acc.Name;
            conlist.add(conrec);
           
        }
    insert conlist;
    }
    
}