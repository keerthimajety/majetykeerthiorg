public class ClassA {

public static  integer x=0;
    public static void display(){
        system.debug('hello apex');
        x++;
        
    }
    public  static void displayx(){
        if(x>0)
        system.debug('display function is executed'+ x+ 'times'); 
        else
            system.debug('display function is not executed');
    }
   
}