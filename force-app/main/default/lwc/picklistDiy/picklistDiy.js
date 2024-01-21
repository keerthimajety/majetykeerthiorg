import { LightningElement,wire,api,track } from 'lwc';
import { getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry'

export default class PicklistDiy extends LightningElement {
  @api
   SelectedrecordId;
   value="individual"
   value1="Agriculture"
   recordtypeinfo;
   picklistoptions;
   
   @track
   optionslist2=[];
   @track
   Industryoptions
 
    @wire(getObjectInfo,{objectApiName :'Account'})
    AccountInfo({data,error})
    {
        if(data)
        {
           
            console.log(data.recordTypeInfos)
                
             this.recordtypeinfo=data.recordTypeInfos;
             this.SelectedrecordId=data.defaultRecordTypeId;
             for(let x in this.recordtypeinfo)
             {
                console.log("insideforloop")
                const obj1 = { label : this.recordtypeinfo[x].name,
                               value  : this.recordtypeinfo[x].recordTypeId  }
              this.optionslist2.push(obj1)
             }
             console.log(this.optionslist2)
        
        }
        if(error)
        {
            console.log(error)
        }
    }
    @wire(getPicklistValues,{recordTypeId : '$SelectedrecordId',fieldApiName : INDUSTRY_FIELD} )
   picklistInfo({data,error})
   {
    if(data)
   {
    console.log(data)
    this.picklistoptions =data;
    this.Industryoptions=data.values.map(x => {console.log(x)
    return {label : x.label,value : x.value}})
    console.log(this.Industryoptions)

   }
   

    if(error)
    console.log(data.error)

   }
   get recordtypeoptions(){
    console.log(this.recordtypeinfo) 
    //using for in loop
   
   return  (JSON.parse(JSON.stringify(this.optionslist2)))
   //console.log(this.rtypearray)

   }
    handleclick(event)
    {
       
          
    }
    handlechange(event)
    {
        
        this.SelectedrecordId =event.target.value;
        console.log(this.picklistoptions)
        


    }
}


//practice code
  /*  let recordtypearray1=Object.keys(data.recordTypeInfos)
             console.log(recordtypearray1)
             this.optionslist =recordtypearray1.map(x => {
                console.log(data.recordTypeInfos[x])
                return {label :data.recordTypeInfos[x].name ,value : data.recordTypeInfos[x].recordTypeId}
             })
             console.log(this.optionslist)
           
            for(let x of recordtypearray1)
            {
                this.optionslist.push(
                    { label :data.recordTypeInfos[x].name  ,value : data.recordTypeInfos[x].recordTypeId}
                )
             console.log(data.recordTypeInfos[x])
            }
           
         //console.log(JSON.stringify(this.optionslist))

         
            // console.log(JSON.stringify(Object.keys(data.recordTypeInfos)))
           /* this.recordtypearray=Object.keys(data.recordTypeInfos)
             console.log(this.recordtypearray);
             const mapinfo=this.recordtypearray.map((x) =>{
                return {value : data.recordTypeInfos[x].recordTypeId ,label :data.recordTypeInfos[x].name}})
                console.log(mapinfo);

               /*GetrecordTypeInfo() {
        // Returns a map of record type Ids 
        const rtis = this.objectInfo.data.recordTypeInfos;
        Object.keys(rtis).forEach(element => {
           console.log(rtis[element].name);
        });*/