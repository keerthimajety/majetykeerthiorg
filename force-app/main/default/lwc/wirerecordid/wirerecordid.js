import { LightningElement,wire ,api} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import BLOODGROUP from "@salesforce/schema/Blood_donor__c.blood_group__c"
import DONORNAME from "@salesforce/schema/Blood_donor__c.donor_name__c"
import AGE from "@salesforce/schema/Blood_donor__c.age__c"
const FIELDS =[BLOODGROUP,DONORNAME,AGE];
export default class Wirerecordid extends LightningElement {
    bloodGroup;
    donorName;
    age;
    
 @api recordId


    @wire(getRecord,{recordId : "$recordId",fields : FIELDS})
     BlooddonorInfo({data,error})//fetched data is destructured into data and error
{
    if(data)
    { 
        console.log(data)  
        console.log("fieldvalue"+data.fields.blood_group__c.value)
     this.bloodGroup=data.fields.blood_group__c.value;//retrived the idividual fields from the data object
     this.donorName=data.fields.donor_name__c.value;
     this.age=data.fields.age__c.value;
     console.log("blood donor fieldvalue exits blood group value is" +this.bloodGroup)
       // console.log(this.contactphone)
    }
    else if(error)
    {
        console.log(error)//in case of error ,the error object contains the data related to error
    }
    
    
}


}