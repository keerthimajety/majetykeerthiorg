import { LightningElement } from 'lwc';

export default class ProgressParent extends LightningElement {

    progressValue;
    stopenable=false;
    handleclick()
    {
        console.log("insidehandleclick")
        this.template.querySelector("c-progress-child").handleProgress();
       
        this.template.querySelector("c-progress-child").progressstop=false;
       this.template.querySelector("lightning-button").disabled =true
      
    }
    handlestop()
    {
         this.stopenable=true;
         this.template.querySelector("c-progress-child").progressstop=true;
         //this.template.querySelector(".stopbutton").disabled=false
         this.template.querySelector("c-progress-child").handleProgress();
         //this.template.querySelector("c-progress-child").progressstop=false;
         this.template.querySelector("lightning-button").disabled =false

    }
    handleonprogress(event)
    {
        //clearInterval()
        console.log("inside handle on progress")
        this.template.querySelector("lightning-button").disabled =false
       

    }
}