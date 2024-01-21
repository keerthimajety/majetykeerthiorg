import { LightningElement,wire,track } from 'lwc';


import getsearchlst from '@salesforce/apex/accountController.getsearchlst'



export default class CaseStudy6 extends LightningElement {
   
    @track accountList;
    lastName;
    mobile;

    handlechange1(event)
    {
        console.log(event.target.value)
        console.log(typeof event.target.value)
        const str=event.target.value
      
        if(event.target.value !=null || event.target.value != undefined || event.target.value !=" ") 
    {
        console.log("insideif")
        getsearchlst({searchword : event.target.value})
        .then(response => {this.accountList = response //when the user enters string in input box the accounts will be 
                                                       //displayed starting with account name as in the given string
        console.log(response)
        console.log(this.accountList)
        
   })
        .catch(error => {console.log(error)})
     
}
else
this.accountList=null;
    }
    handleclick(event)
    {
       
    }
    handlechange(event)
    { 

     
    }
   
    handledelete(event)
    {
      
    }
}