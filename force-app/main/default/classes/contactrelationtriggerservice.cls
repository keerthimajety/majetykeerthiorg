public class contactrelationtriggerservice {

    
    public static void CRName_update(map<id,Contact_Relationship__c> oldmap,list<Contact_Relationship__c> newrec){
        
        
    map<id,Contact_Relationship__c> Croldrec=oldmap;
    //map<id,Contact_Relationship__c> Crnewrec=trigger.newmap;
    list<Contact_Relationship__c> Crlst =new list<Contact_Relationship__c>();
    Map<id,user> userlst =new Map<id,user>( [select Name,Id from User]);
    for(Contact_Relationship__c cr:newrec)
    {
        if(Croldrec.get(cr.Id).OwnerId != cr.OwnerId)
        {
            
            Contact_Relationship__c crrec =new Contact_Relationship__c(Id=cr.Id,Name=userlst.get(cr.OwnerId).name);
            crlst.add(crrec);
                
                   }
    }update Crlst;
    }
    {}
}