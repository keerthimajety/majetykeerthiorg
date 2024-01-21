import { LightningElement,api } from 'lwc';

export default class ProgressChild extends LightningElement {
  @api  
progressvalue=0;
@api
progressstop=false;
 @api
handleProgress(){
   console.log("insidehandleprogress")
   console.log(this.progressvalue)
   console.log("progressstop value is"+ this.progressstop)
   if(this.progressstop == false)
   {
    
    
    var si =setInterval(()=>{
      this.progressvalue=this.progressvalue +10
     
       if(this.progresvalue>=100 || this.progressstop==true)
      {
          console.log("inside the loop")
          this.progressvalue=0;
         const e=new CustomEvent("progress");
         this.dispatchEvent(e)
         clearInterval(si)
         console.log("cleared intervel")
         
         
      }

  },500)
   }
    else
    {
      clearInterval(si);
      this.progressvalue=0;
      console.log("inside clearinterval");


    }

}
}