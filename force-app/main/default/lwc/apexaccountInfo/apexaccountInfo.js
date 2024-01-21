import { LightningElement ,wire,track} from 'lwc';
import getacclist from "@salesforce/apex/accountController.getacclist";

export default class ApexaccountInfo extends LightningElement {

    value ='Hot'
    Selectedrating='Hot';
    @track
    accountList;
    ratingoptions=[
        {label :'Hot',value :'Hot'},
        {label :'warm',value :'Warm'},
        {label :'cold',value :'Cold'}
    ]
    @wire(getacclist,{rating : '$Selectedrating'})
    acclistinfo({data,error})
    {
      if(data)
      {
       this.accountList=data;
       console.log(data)
      }
      if(error)
      {
        console.log(error)
      }
    }
   
    handleChange(event)
    {
        this.Selectedrating=event.target.value;
        console.log(this.accountList)
    }
}