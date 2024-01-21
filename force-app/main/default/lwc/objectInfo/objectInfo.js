import { LightningElement,wire,api } from 'lwc';
import ACCOUNTINFO from "@salesforce/schema/Account"
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
export default class ObjectInfo extends LightningElement {
@api objectApiName
Count=0;
picklistcount=0
customfieldcount=0;
fieldNames
fieldsInfo;
    showaccountInfo=true;
    @wire(getObjectInfo,{objectApiName : ACCOUNTINFO})
    AccountInfo({data,error})
    {
        if(data)
        {
            console.log("object Info Data =");
            console.log(data)
            console.log("data displayed")
            console.log(data.fields)
            this.fieldsInfo=data.fields
            //Count;
            this.fieldNames=Object.keys(data.fields)
            for(let keys in data.fields)//interating the data.fields object with index
            {
                ++this.Count;  //count to increase the no of fields or no of properties
                
                console.log(this.fieldNames)
                console.log(keys) //each property in the data.fields
               // console.log(data.fields[keys].dataType =="Picklist")
                if((data.fields[keys].dataType =="Picklist")) //if the property's datatype matches to picklist
                ++this.picklistcount;
           
              if(keys.includes("__c", 0))//if the prperty name includes __c the custom fieldcount increases
               ++this.customfieldcount
               
            }
            console.log("No of fields")
            console.log(this.Count)
            console.log("No of picklist fields")
            console.log(this.picklistcount)
            console.log(this.fieldNames)
            console.log("custom fields")
            console.log(this.customfieldcount)
            
        }
        if(error)
        {
            console.log("Error occured"+error)
        }
    }

   // console.log(this.fieldApiName)



}