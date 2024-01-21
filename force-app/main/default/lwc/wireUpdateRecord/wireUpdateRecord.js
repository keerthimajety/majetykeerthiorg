import { LightningElement ,wire,api} from 'lwc';
import {getobjectInfo,getPicklistValues} from 'lightning/uiObjectInfoApi'

export default class WireUpdateRecord extends LightningElement {

    value="Agriculture"
    industryoptions=[];
    recordid;

    @wire(getobjectInfo,{objectApiName : "$recordid" })
       
     objectinfo({data,error})
     {
        if(data)
        console.log(data)
     }
    @wire(getPicklistValues,{recordTypeId : "$objectinfo.default",fieldApiName : Industry})
    picklistinfo(data)
    {
        this.industryoptions=data.values.map(d=> { return { label : d.label,value : d.value}})
        console.log(this.industryoptions)
    }
    
}