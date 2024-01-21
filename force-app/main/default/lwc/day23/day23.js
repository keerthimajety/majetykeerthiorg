import { LightningElement ,wire} from 'lwc';

import { deleteRecord } from "lightning/uiRecordApi";
import getacclist from '@salesforce/apex/accountController.getacclist'
import getsearchlst from '@salesforce/apex/accountController.getsearchlst'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex'

export default class Day23 extends LightningElement {

    accountList;
    accResponselist;
    WiredaccountResponse;
    @wire(getacclist,{rating :'Hot'})
    accountinfo(response)
    {
      this.WiredaccountResponse=response;
        if(response)
        {
            this.accResponselist=response.data;
            this.accountList=response.data;
            console.log(response)
        }
        
       
    }
    handleclick(event)
    {
        this.accountList=this.accResponselist;   //copying the response to the accountsList when clicked
        console.log(this.accResponselist)
    }
    handledelete(event)
    {
       console.log("insidedelete")
        const recid=event.target.name;
        console.log(recid);
        //deleteRecord({recordId :recid})                  //deletes the particular record imperatively
        deleteRecord(recid)
        .then(() => {console.log("deleted")
        this.dispatchEvent(new ShowToastEvent({title : "deleteRecord",
                                                message :"Successfuly deleted",
                                                variant : "success"}));
          //refreash the response
        refreshApex(this.WiredaccountResponse)
        })
        .catch((error) => {console.log(error.body.message)})


        
        
    }
    
}