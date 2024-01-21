/***********************************************************************
Name        Numberlist
author      keerthi
date        5-1-2023
Description day 8 diySave set of integers in the list and find biggest number,sum of odd and even,count the number of negetive numbers
*************************************************************************/

public class Numberlist {
    public integer sumofodd=0,sumofeven=0;
    
    public List<integer> Numbers =new List<integer>();
        
        public void biggest_num(){
            
            integer big_num=0;
            for(integer i=0;i<Numbers.size();i++){
                
                if(Numbers[i]>big_num)
                    big_num=Numbers[i];
                
            }
            system.debug('biggest number is '+ big_num);
        }
    //Funtion to add even numbers in the list and odd numbers in the list and display seperately
      public void sumofoddeven() {
        
        
        
        for(integer eachnumber :Numbers){
                if(Math.mod(eachnumber, 2) ==0)
                   sumofeven=sumofeven+eachnumber;
              else
                  
                 sumofodd=sumofodd+eachnumber;
        }
        system.debug('sum of odd numbers in the list is' + sumofodd);
        system.debug('sum of even numbers in the list is  '+sumofeven);
          
          
         
        
    }
    //functiont to count negetive numbers in the list
    public void count_negetive(){
        integer count=0;
        for(integer eachnumber:Numbers)
        {
        if(eachnumber<0)
            count=count+1;
            }
        system.debug('count of negetive numbers in the list is '+count);
    }
    
    //functiont display the list in reverse oder
    public void rev_list(){
        
        
        for(integer i=(Numbers.size())-1;i>=0;i--)
        {
            system.debug('reversed list is '+Numbers[i]);
        }
        
        }
        
    
   
}