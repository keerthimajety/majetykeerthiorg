import { LightningElement } from 'lwc';


export default class SimpleCalculator extends LightningElement {

    num1;
    num2;
    result;
    handlechange(event){
    if(event.target.name == 'first inputbox')
    this.num1=parseInt(event.target.value)
    if(event.target.name == 'second inputbox')
    this.num2=parseInt(event.target.value)
    
 
    }
    handleClick(event){
        if(event.target.label =='Add' )
        this.result=this.num1+this.num2
       if(event.target.label == 'Subtract')
        this.result = this.num1-this.num2
        if(event.target.label == 'Mul')
        this.result = this.num1*this.num2
        if(event.target.label == 'Div')
        this.result = this.num1/this.num2
        if(event.target.label == 'Clear')
        { this.result = null
            this.num1 =null
            this.num2  =null}
       

    }
}