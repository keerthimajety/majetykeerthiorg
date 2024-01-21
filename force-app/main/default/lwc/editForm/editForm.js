/*import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EditForm extends LightningElement {

    handlesuccess(event)
    {
       // alert("record saved successfully" + event.detail.id)

       const toastEvent = new ShowToastEvent({
        title :"Contact saved",
        message :"Contact created successfully with the recordId =" + event.detail.id,
        variant :"success"
       })
       this.dispatchEvent(toastEvent)
       //alert("handlesuccess")

    }
    handlesubmit(event)
    {
       event.preventDefault();
       // console.log(this.querySelector(".efield").field-name)
       const enteredemail = this.template.querySelector(".efield")
       
       console.log("entered email value ="+ enteredemail.value);


        if(enteredemail.value == "" )
        {
            console.log("befortoast")
            const toastEvent2 = new ShowToastEvent({
                title :"Email field",
                message :"Please enter valid email",
                variant :"error"
               })
               this.dispatchEvent(toastEvent2)
               console.log("after the toast");
         
        }
        else
        {

            console("Insideelse")
            const fields=event.detail.fields

            this.template.querySelector("lightning-record-edit-form").submit(fields);

        }


       
        //
       
        
    }
   

}*/

import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Day18 extends LightningElement {

    handlesuccess(event)
    {
        console.log("insidehandlesuccess")
       alert("record saved successfully" + event.detail.id)

       const toastEvent = new ShowToastEvent({
        title :"Contact saved",
        message :"Contact created successfully with the recordId =" + event.detail.id,
        variant :"success"
       })
       this.dispatchEvent(toastEvent)
    //alert("handlesuccess")

    }
    handlesubmit(event)
    {
        console.log('TEst console')
        event.preventDefault();
        //console.log(this.querySelector(".efield").field-name)
      const enteredemail = this.template.querySelector(".efield")
     
      
      console.log("entered email value ="+ enteredemail.value);
      console.log("entered email value ="+ typeof(enteredemail.value));

        if(enteredemail.value != null && enteredemail.value != '' && enteredemail.value != undefined )
        {
            console.log('inside if')
            const fields=event.detail.fields;
            console.log(event.detail.fields)
            //fields.Email = 'susi@gmail.com';
            this.template.querySelector('lightning-record-edit-form').submit(fields);

           
         }
        else

        {
            console.log("befortoast")
            const toastEvent2 = new ShowToastEvent({
                title :"Email field",
                message :"Please enter valid email",
                variant :"error"
               })
              this.dispatchEvent(toastEvent2)
               console.log("after the toast");

        }


       
       
       
        
    }
   

}