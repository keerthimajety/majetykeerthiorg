/***********************************************************************
Name        Numberlist
author      keerthi
date        2-1-2023
Description Day 5 diy to calculate student marks.
*************************************************************************/
public class student {
    public integer  mark1;
    public integer  mark2;
    public integer mark3;
    private double average;
    private string grade1;
    
    public void result(){
        if(mark1>50  && mark2>50 && mark3>50)
            system.debug('student is pass');
        else
            system.debug('student is failed');
    }
    public void grade(){
        average= (mark1 + mark2+mark3)/3;
        grade1= (mark1>50  && mark2>50 && mark3>50)?(average>90?'s':(average>80?'A':(average>70?'B':'C'))):'No grade' ;
            system.debug('student grade is  '+ grade1);
    }

}