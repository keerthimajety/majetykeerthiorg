public class processtest {
   // @invocablemethod
    public static void create_contactrec()
    {
        list<contact> conlist=new list<contact>();
        Contact conrec=new Contact(LastName='saadhvi');
        conlist.add(conrec);
        Contact conrec2=new Contact(mobile_number__c='9246663018');
        conlist.add(conrec2);
        List<Database.SaveResult>  Result1=Database.insert(conlist,false);
        system.debug(Result1);
        list<DmlError__c> errlst =new list<DmlError__c>();
        for(Database.SaveResult ds:Result1)
        {
        
        DmlError__c  err=new DmlError__c(Id_o_fDML__c=ds.getId());
            err.Name='contactinsert';
            err.DML_status__c = ds.isSuccess();
         
            for(Database.Error e : ds.getErrors())
            {
                err.errormessage__c= e.getMessage();
            }
            errlst.add(err);
         
        
        
    }
        insert errlst;

}
}