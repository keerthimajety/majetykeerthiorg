import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import RECEIPT_OBJECT from '@salesforce/schema/Receipt__c'
import AMOUNT_FIELD from '@salesforce/schema/Receipt__c.Amount__c'
import DATE_FIELD from '@salesforce/schema/Receipt__c.Amount_Paid_Date__c'
import MODEOFPAY_FIELD from '@salesforce/schema/Receipt__c.Mode_of_Pay__c'
import RECEIPTID_FIELD from '@salesforce/schema/Receipt__c.Receipt_Id__c'
import CONTACTID_FIELD from '@salesforce/schema/Receipt__c.ContactId__c'

export default class MyModal extends LightningModal {
    fields=[AMOUNT_FIELD,DATE_FIELD,MODEOFPAY_FIELD,RECEIPTID_FIELD,CONTACTID_FIELD]

    objectName=RECEIPT_OBJECT
    

    @api recordId;
    @api content;
    handlesuccess(event)
    {
        this.close('okay');
    }
    
    handleOkay() {
        this.close('okay');
    }
    handlechange(event)
    {
        
    }
}