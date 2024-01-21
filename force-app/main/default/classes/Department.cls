public class Department {

    string Name;
    integer Employees;
    
    public static void  finddept(){
        
       List <Department__c> dep=[SELECT Name ,(select id from employees__r)   from Department__c ];
       integer maxemp=0;
        string dept;
        for(Department__c d:dep)
        {    
            integer noofemp=d.employees__r.size();
            if(noofemp>maxemp)
            {
             maxemp=noofemp;
                dept=d.Name;
            }
            system.debug(d.Name);
            system.debug(noofemp);
           //system.debug(d.employees__r.Id);
        }
        system.debug('=======================================================================');
         system.debug('department with max employees = '+dept);
            system.debug('no of employees is ='+ maxemp);
            
    }
    
    
    
}