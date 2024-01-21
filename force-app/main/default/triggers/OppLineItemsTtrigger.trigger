/***********************************************************************
Name        casestudy7
author      keerthi
date        02-1-2023,06-02-2023
Description when opp line item created ,that product shoud be displayed in the oppline item field in opportunity.
*************************************************************************/


trigger OppLineItemsTtrigger on OpportunityLineItem (after insert,after update,after delete) {
    //diy day 55 tamil rollup summeries when opplineitem is inserted ,updated,deleted 
    ///the quantity and price should be updated in opportunity object fields.
     system.debug('inside trigger');
    
    opphandler.opp_lineItem_Update(trigger.new);
   
   switch on Trigger.operationType
   {
      when AFTER_INSERT 
      {
          //create an asset assosiated with the account when opportunity line item is created
          oplhandler.create_asset(trigger.new);
          set<ID> oppidlst=new set<ID>();
          for(OpportunityLineItem oli:trigger.new)
          {
              if(oli.OpportunityId !=null)
              oppidlst.add(oli.OpportunityId);
          }
        map<id,opportunity> opplst =new map<id,opportunity>([Select Id,Oppr_LineItems_ProductCode__c from opportunity where id IN : oppidlst ]);
         
          for(OpportunityLineItem oli :trigger.new)
         {
            
            if(opplst.get(oli.OpportunityId).Oppr_LineItems_ProductCode__c ==null)
             opplst.get(oli.OpportunityId).Oppr_LineItems_ProductCode__c =oli.ProductCode;
             else
               opplst.get(oli.OpportunityId).Oppr_LineItems_ProductCode__c= opplst.get(oli.OpportunityId).Oppr_LineItems_ProductCode__c+',' +oli.ProductCode;
             //opplst.add(opp);
         }
          update opplst.values();
          
          /*Count no of opp line items assosiated with an opportunity and display the count on accounts custom field*/
          set<id> oppids=new set<id>();
          for(opportunitylineitem oli:trigger.new)
          {
             if (oli.OpportunityId !=null) 
                 oppids.add(oli.OpportunityId);
          }
           list<opportunity> opplist = [Select Id,AccountId,Account.count_of_line_items__c ,(Select Id,OpportunityId from Opportunitylineitems) from opportunity where Id IN :Oppids];
           list<account> accnewlist=new list<account>();
          if(opplist.size()>0)
           {
               for(opportunity opp:opplist)
               {
                   integer count=opp.opportunitylineitems.size();
                   system.debug('count of products'+ count);
                   Account accnew =new Account(ID=opp.AccountId,count_of_line_items__c=count);
                   accnewlist.add(accnew);
                   
                   
               }
               Update accnewlist;
           }
          
          
          
             }
       when AFTER_DELETE
       {
           
          set<ID> oppidlst=new set<ID>();
          for(OpportunityLineItem oli:trigger.old)
          {
              if(oli.OpportunityId !=null)
              oppidlst.add(oli.OpportunityId);
          }
        map<id,opportunity> opplst =new map<id,opportunity>([Select Id,Oppr_LineItems_ProductCode__c from opportunity where id IN : oppidlst]);
           for(opportunity o:opplst.values())
           {
               opplst.get(o.id).Oppr_LineItems_ProductCode__c=null;
           }
           list<OpportunityLineItem> olilist =[select ProductCode,OpportunityId from OpportunityLineItem where OpportunityId In :oppidlst];
         for(OpportunityLineItem oli :olilist)
         {
            system.debug(olilist);
            if( opplst.get(oli.OpportunityId).Oppr_LineItems_ProductCode__c==null)
             opplst.get(oli.OpportunityId).Oppr_LineItems_ProductCode__c =oli.ProductCode;
             else
               opplst.get(oli.OpportunityId).Oppr_LineItems_ProductCode__c= opplst.get(oli.OpportunityId).Oppr_LineItems_ProductCode__c+',' +oli.ProductCode;
             //opplst.add(opp);
         }
          update opplst.values();
             }
       
    
       
    }
}