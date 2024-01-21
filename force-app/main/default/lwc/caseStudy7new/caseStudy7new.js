import { LightningElement,api,wire } from 'lwc';
import Modal7 from 'c/modal7';
import getReceiptRec from '@salesforce/apex/receiptController.getReceiptRec'
import { refreshApex } from "@salesforce/apex";
export default class CaseStudy7new extends LightningElement {

    @api recordId;
    wireResponse;
    ReceiptList;
   
    coloumnList = [
        {label : 'Receipt ID',fieldName :'Receipt_Id__c'},
        {label : 'Amount',fieldName :'Amount__c'},
        {label : 'Mode of Pay',fieldName :'Mode_of_Pay__c'}
        
    ];
    @wire(getReceiptRec,{contactid : "$recordId"})
    Receiptinfo(response)
    {
        if(response)
        {
        this.wireResponse=response;
        this.ReceiptList=response
        
        
        console.log("insidewire")
        }
    }
    
    
    async handleClick() {
        const result = await Modal7.open({
            // `label` is not included here in this example.
            // it is set on lightning-modal-header instead
            size: 'Small',
            description: 'Accessible description of modal\'s purpose',
            content: this.recordId
            
        });
        // if modal closed with X button, promise returns result = 'undefined'
        // if modal closed with OK button, promise returns result = 'okay'
        console.log(result);
        console.log(this.ReceiptList.data)

       // refreshapex(this.ReceiptList);
      // refreshApex(this.wireResponse);
        
    }
    handlerefresh()
    {
        console.log(this.wireResponse);
        refreshApex(this.wireResponse);
    }
    

}