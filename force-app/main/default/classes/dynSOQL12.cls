/***********************************************************************
Name        diy 2 day 12
author      keerthi
date       11-1-2023
Description dynamic soql 
*************************************************************************/

public class dynSOQL12 {
    
    
    //function to search records from the object .Object name and fields are the parameters.DIY2
    
    public static void searchrec(string objectname, list<string> fldlist){
        string strfld=fldlist[0];
        integer size=fldlist.size();
       for(integer i=1;i<size;i++)
       { 
         
            strfld=strfld+','+(fldlist[i]);
          
          
       }
        system.debug(strfld);
      list<SObject> searchlist=Database.query('Select '+strfld +' from '+objectname);
        
        for(Sobject s:searchlist)
        {
            system.debug(s);
        }
        
    }//functiont to search records using criteria .object name,fieldname list,searchfield,value,operater as parameters
    
      public static void searchrec(string objectname, list<string> fldlist,string searchfield,string operater,string value){
        string strfld=fldlist[0];
        integer size=fldlist.size();
       for(integer i=1;i<size;i++)
       { 
         
            strfld=strfld+','+(fldlist[i]);
          
          
       }
        system.debug(strfld);
      list<SObject> searchlist=Database.query('Select '+strfld +' from '+objectname+' where '+searchfield+' '+operater+value);
        
        for(Sobject s:searchlist)
        {
            system.debug(s);
        }
      }
}