import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import BRINFO from "@salesforce/schema/blood_request__c"
import BRPATIENT_NAME from "@salesforce/schema/blood_request__c.patient_name__c"
import BR_NAME from "@salesforce/schema/blood_request__c.Name"
import ATT_NAME from "@salesforce/schema/blood_request__c.attender_name__c"
import ATT_CONTACT from "@salesforce/schema/blood_request__c.attender_contact_NO__c"



export default class EditformCustomObject extends LightningElement {
   @api  recordId;
   
   recId=this.recordId;
   bloodrequestinfo=BRINFO;
    fields={
        patientname : BRPATIENT_NAME,
        bloodrequestname    :BR_NAME,
        attendername:ATT_NAME,
        attendercontact:ATT_CONTACT
    }
    handlesuccess(event)
    {
        console.log('inside handlesuccess')
        alert(event.detail.id)
    }
    handlesubmit(event)
    {
      /*  event.preventDefault();
        const patientname=event.detail.fields.patient_name__c.value;
        const bloodrequestname=event.detail.fields.patient_name__c.value;
       
        const fields = event.detail.fields;
        console.log(event.detail.fields)
      fields.patient_name__c.value = patientname + bloodrequestname;
      this.template.querySelector("lightning-record-edit-form").submit(fields);*/
        }
    
handleerror(event)
{
    console.log("inside error")
    console.log(event.detail.message)
    this.dispatchEvent(
        new ShowToastEvent({
          title: "Error creating record",
          message: event.detail.message,
          variant: "error",
        }),
      );
}

}