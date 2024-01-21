import { LightningElement } from 'lwc';

export default class InputText extends LightningElement {


    upperCaseResult;
    mytext
    
    handlechange(event){

        
        this.mytext = event.target.value
        this.upperCaseResult=(this.mytext).toUpperCase()
    }
   
}