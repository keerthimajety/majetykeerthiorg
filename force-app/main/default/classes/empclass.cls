public class empclass {

    public static integer no_of_emp = 0;
    Map<String,employee1> empmap1=new Map<string,employee1>();
    public  void FindNumEmp(Map<string,employee1> empmap,string Department)
    {
        
        for(string i:empmap.keyset())
        {
           if(empmap.get(i).Department ==Department) 
           {
               no_of_emp =no_of_emp+1;
           }
        }
        system.debug('No of employees in '+Department+'is '+no_of_emp);
    }
    public static void lowsalemp(Map<string,employee1> empmap){
        Integer least_sal=empmap.values()[0].salary;
        string least_sal_empkey;
        for(string i:empmap.keyset())
        {
            
           if(empmap.get(i).Salary <least_sal) 
           {
               least_sal=empmap.get(i).Salary;
               least_sal_empkey =i;
           }
        }
        system.debug('least salary is '+least_sal);
         system.debug('least salary employee is '+empmap.get(least_sal_empkey)) ;          
        
    }
    public static void find_emp_inloc(Map<string,employee1> empmap,string location)
    {
        Integer no_of_employees=0;
        for(string i:empmap.keyset())
        {
            
           if(empmap.get(i).location==location) 
           {
               system.debug(empmap.get(i));
               no_of_employees++;
           }
        }
        system.debug('No of employees in the '+location+'are ='+no_of_employees);
    }
}