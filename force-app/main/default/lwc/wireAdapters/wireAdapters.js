import { LightningElement } from 'lwc';
import cname from "@salesforce/schema/Contact.Name"
import {getRecord} from 'lightning/uiRecordApi';
import {  wire } from "lwc";

const FIELDS = ["Contact.Name", "Contact.Title", "Contact.Phone", "Contact.Email"];
export default class WireAdapters extends LightningElement {


contactphone;
contactname;
contactemail;


    @wire(getRecord,{recordId : '0035g00000mR3tFAAS',fields : FIELDS})
     ContactInfo({data,error})
{
    if(data)
    { 
        console.log(data)
     this.contactphone=data.fields.Phone.value;
     this.contactname=data.fields.Name.value;
     this.contactemail=data.fields.Email.value;
        console.log(this.contactphone)
    }
    else if(error)
    {
        console.log(error)
    }
    
    
}


}