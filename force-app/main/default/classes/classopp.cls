/***********************************************************************
Name        day 10 diy 2
author      keerthi
date        7-1-2023
Description day 10 diy display all opportunity records with amount grater than 5000
*************************************************************************/
public class classopp {
 // function to display opp records diy 1 day 10
    public static void disp_oppamount(){
        List<opportunity> occamount=[SELECT Id, Name, Amount FROM Opportunity where Amount>=5000];
        for(opportunity o:occamount)
        {
            system.debug(o.Name);
            system.debug(o.Amount);
            system.debug('======================================');
        }
    }
        
        //function to display all opp with particular stage day10 diy4 */
        Public static void disp_oppstage(){
        List<opportunity> oppstagerec=[ SELECT Id, LeadSource, StageName, Name FROM Opportunity where StageName='Prospecting' and LeadSource='Web'];
        for(opportunity o:oppstagerec)
        {
            system.debug(o.Name);
            system.debug(o.StageName);
            system.debug(o.LeadSource);
            system.debug('======================================');
        }
        
    }
    
    //function to count no of opp in a stage diy 3
    Public static void opp_count(){
        List<AggregateResult> opprec= [ SELECT  Count(ID) total ,StageName FROM Opportunity  Group By StageName];
        for(AggregateResult a:opprec)
       {
            system.debug(a.get('total'));
           system.debug(a.get('StageName'));
       }
    }
    //function to display all opp records whose name starts with s DIY 5
    
    public static void oppnamem(){
        List<opportunity> opp=[SELECT Id, Name FROM Opportunity Where Name LIKE 'S%'];
        for(opportunity o:opp)
        {
            system.debug(o.Name);
            system.debug(o.Id);
            system.debug('==================================');
        }
    }
    public static void oppr(){
        List<opportunity> opp=[SELECT Id, Name, Amount FROM Opportunity where Amount>=5000  order by Name];
        for(opportunity o:opp)
        {
            system.debug(o.Name);
            system.debug(o.Id);
            system.debug(o.amount);
            system.debug('==================================');
        }
    }//function to display the total sum of amount for a particular stage prospecting
    
     public static void disp_sumamount(){
        List<opportunity> opp=[SELECT Id, Name,StageName , Amount FROM Opportunity where StageName='Prospecting' and Amount !=null];
         decimal sum =0;
         integer i=1;
         system.debug(opp);
        for(opportunity o:opp)
        {   
            system.debug(o.Name);
            system.debug(o.Amount);
            if(i==1)
            {
                sum=o.amount;
                i++;
            }
            else
           sum = sum + o.Amount;
            
            system.debug('======================================');
        }
         system.debug('sum of all opportunities is  '+sum);
    }
}