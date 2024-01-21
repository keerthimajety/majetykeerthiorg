public class Employee {
    
    string email,gender,position,name;
    decimal salary;
    string department;
    public static integer sum=0;
    
   /* public Employee(string email,string gender,string position,integer salary,string name){
        this.email=email;
        this.gender=gender;
        this.position=position;
        this.salary=salary;
         this.name=name;
        
    }*/
    public void insertemp(string email,string name,integer salary,string position){
        integer count=0;
       if(position!='Head Department')
           this.salary=80000;
        
        employee__c  emp=new employee__c(Name=name,Email__c=email,Salary__c=this.salary,Position__c=position);
        
        system.debug(emp);
        
        List<employee__c> searchemp =[SELECT Name,Salary__c,Position__c from employee__c ];
        for(employee__c e:searchemp)
        {
            if(e.Name==name)
            {
                system.debug('same name exist');
                count=count+1;
            
            }
            if(e.Position__c!= 'Head Department')
            {
                e.Salary__c=80000;
                update e;
            }
         }
            
        
      //Elist.add(E1);
       if(count==0)
       {
       insert emp;
           sum =sum+1;
           system.debug('no of records updated is  '+sum);
          
       }
               
        
    }
    public void updateemp(){
        List<employee__c> emp=[SELECT Position__c ,Name from employee__c WHERE Position__c=null];
            for(employee__c e:emp)
        {
            system.debug(e.Name);
            system.debug(e.position__c);
            e.position__c='other';
            update e ;
        }
        
        update emp;
        
    
    }
        
        public void deleteemp()
        {
            //integer noofrec;
            List<employee__c> emp=[SELECT Id,Name  from employee__c WHERE Name like 's%'];
           
           if(emp.isEmpty())
               system.debug('no records with name starts with s');
            else
                delete emp;
        }
    public void salmax(string position){
        List<AggregateResult> emp=[SELECT MAX(Salary__c) maxsal ,Position__c from employee__c group by Position__c];
       
        for(AggregateResult a:emp)
        {
            if(a.get('Position__c')==position)
                system.debug(a.get('Salary__c'));
            system.debug('max salary is'+ a.get('maxal'));
        }
        
        }
    public static void maxandmin(){
        
        List<AggregateResult> posrec=[SELECT Max(Salary__c) maxsal,Min(Salary__c) minsal ,Position__c from employee__c group by Position__c];
        
        for(AggregateResult a:posrec)
        {
            system.debug('Position = '+a.get('Position__c'));
            system.debug('maximum salary =  '+a.get('maxsal'));
            system.debug('minimum salary  =  '+a.get('minsal')); 
            
        }
    }
    
    

}