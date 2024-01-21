public class receiptController {

    @AuraEnabled(cacheable=true)
    Public static list<Receipt__c> getReceiptRec(Id contactid)
    {
        return [Select Amount__c,Receipt_Id__c,Mode_of_Pay__c from Receipt__c where ContactId__c = :contactid];
    }
    @AuraEnabled
    public static Id create_receipt_rec(String receiptId,decimal  Amount,String modeofpay,string contactid)
    {
        Receipt__c rec=new Receipt__c();
        rec.Receipt_Id__c=receiptId;
        rec.Mode_of_Pay__c=modeofpay;
        rec.Amount__c = Amount;
        rec.ContactId__c=contactid;
        insert rec;
         system.debug(rec)  ;
        return rec.Id;
    }
}