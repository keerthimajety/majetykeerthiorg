import { LightningElement,api,wire } from 'lwc';
import LightningModal from 'lightning/modal';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {refreshApex} from "@salesforce/apex"

import create_receipt_rec from "@salesforce/apex/receiptController.create_receipt_rec"

export default class Modal7 extends LightningModal {
    @api recordId;
    @api content;
    receiptid;
    amount;
    modeofpay;
    dateofpayment;
    handlechange(event)
    {
        if(event.target.name == 'Receipt_Id__c' )
          this.receiptid =event.target.value;
          if(event.target.name == 'Amount__c' )
          this.amount=parseFloat(event.target.value);
          if(event.target.name == 'Mode_of_Pay__c' )
          this.modeofpay=event.target.value;
          if(event.target.name == 'Amount_Paid_Date__c' )
          this.dateofpayment = event.target.value;
         console.log(this.recordId)

    }
   handleSave()
   {
    console.log(this.receiptid)
    console.log(this.recordId)
    console.log(this.modeofpay)
    console.log(this.amount)
   // console.log(this.content)
    
     create_receipt_rec({receiptId: this.receiptid ,Amount :  this.amount ,modeofpay  :  this.modeofpay ,contactid : this.content})
     .then(result => {
        this.dispatchEvent(new ShowToastEvent({
            title :"Receipt created",
            message :"Receipt succesfully created "+ result ,
            variant :"success"
           }))
        console.log(result)})
     .catch(error => {console.log(error)})
     ///refreshApex(this.content.data2);
     this.close('okay');
   }
  
}