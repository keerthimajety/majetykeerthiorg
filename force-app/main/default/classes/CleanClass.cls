/***********************************************************************
Name        CleanClass
author      keerthi
date        4-1-2023
Description To refactor and clean the code as given in the DIY day 8.
*************************************************************************/


public class CleanClass {
 
    public integer M1=80,M2=30,M3=40;
    public decimal Average;
    public string result,grade;
    public void disp_result(){
        result = (M1>45&& M2>45 && M3>45)?'Pass':'fail';
        system.debug(result);
            
    }
    public void disp_grade(){
        average=(M1+M2+M3)/3;
        
        grade= (result=='pass')?(average>90?'s':(average>80?'A':(average>70?'B':'C'))):'No grade';
        system.debug(grade);
               
           
    }
    
        
    
    
}