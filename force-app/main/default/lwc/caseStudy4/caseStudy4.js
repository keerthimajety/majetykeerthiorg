import { LightningElement,api } from 'lwc';
import cloneCase from "@salesforce/apex/caseController.cloneCase"
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from "lightning/actions";
export default class CaseStudy4 extends LightningElement {


    @api recordId
    
handleclick()
{
    console.log(this.recordId);
    console.log("inside handleclick")
    cloneCase({recordid : this.recordId})
    .then(result => {console.log(result)
                     console.log('inside then')
                    /* toToastMessage(title, message, variant) 
                     const event = new ShowToastEvent({
                        title: title,
                        message: message,
                        variant: variant,
                    });*/
                   // this.dispatchEvent(event);
                  
          
                                         /*toToastMessage(title, message, variant){
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);*/
    //}
                                         
                   
               alert('case is cloned successfully');
               const event=new ShowToastEvent({
                title :'success message',
                 message :'Case successfully cloned',
                 variant :'success' });
               this.dispatchEvent(event);  
                   
                })
    .catch(error => {console.log(error)})
    this.dispatchEvent(new CloseActionScreenEvent());
}
}