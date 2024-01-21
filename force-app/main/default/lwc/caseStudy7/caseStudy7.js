import { LightningElement,wire,api } from 'lwc';
import MyModal from 'c/myModal';
import getReceiptRec from '@salesforce/apex/receiptController.getReceiptRec'
export default class CaseStudy7 extends LightningElement {

@api recordId;
wireResponse;
coloumnList = [
    {label : 'Receipt ID',fieldName :'Receipt_Id__c'},
    {label : 'Amount',fieldName :'Amount__c'},
    {label : 'Mode of Pay',fieldName :'Mode_of_Pay__c'}
    
];
@wire(getReceiptRec,{contactid : "$recordId"})
ReceiptList;


async handleClick() {
    const result = await MyModal.open({
        // `label` is not included here in this example.
        // it is set on lightning-modal-header instead
        size: 'Small',
        description: 'Accessible description of modal\'s purpose',
        content: 'Passed into content api',
    });
    // if modal closed with X button, promise returns result = 'undefined'
    // if modal closed with OK button, promise returns result = 'okay'
    console.log(result);
    console.log(this.ReceiptList.data);
    refreshApex(ReceiptList)
}

}