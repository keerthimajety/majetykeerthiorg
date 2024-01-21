/***********************************************************************
Name        day 10 diy class
author      keerthi
date        7-1-2023
Description day 10 diy display all opportunity records
*************************************************************************/

public  class class10 {
    public List<Opportunity>  opp =[SELECT Id, Name, Description, StageName, Amount FROM Opportunity];
     
// Function to Display all opportunity records
// 
    public static void disp_opp(){
        List<Opportunity>  rec_opp =[SELECT Id, Name, Description, StageName, Amount FROM Opportunity];
    for(Opportunity o:rec_opp)
    {
        system.debug(o);
    }
    
}
}